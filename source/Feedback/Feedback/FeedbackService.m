//
//  FeedbackService.m
//  Feedback
//
//  Created by Chris Risner on 1/24/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "FeedbackService.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FeedbackService()
@property (nonatomic, strong) MSTable *feedbackTable;
@property (nonatomic)                  NSInteger busyCount;
@end

@implementation FeedbackService

static FeedbackService *singletonInstance;

+(FeedbackService*) getInstance {
    if (singletonInstance == nil) {
        singletonInstance = [[super alloc] init];
    }
    return singletonInstance;
}

-(FeedbackService *) init {
    // Initialize the Mobile Service client with your URL and key
    MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://feedbackservice.azure-mobile.net/"
            withApplicationKey:@"cWtFlOoaOADYmOlIWEfUoQBrESUAtA52"];
    
    // Add a Mobile Service filter to enable the busy indicator
    self.client = [newClient clientwithFilter:self];
    self.feedbackTable = [_client getTable:@"Feedback"];
    self.busyCount = 0;
    
    return self;
}

- (void) saveFeedback:(NSDictionary *)feedback
           completion:(CompletionBlock) completion {
    [self.feedbackTable insert:feedback completion:^(NSDictionary *result, NSError *error) {
        
        [self logErrorIfNotNil:error];
        
        completion();
    }];
}


- (void) busy:(BOOL) busy
{
    // assumes always executes on UI thread
    if (busy) {
        if (self.busyCount == 0 && self.busyUpdate != nil) {
            self.busyUpdate(YES);
        }
        self.busyCount ++;
    }
    else
    {
        if (self.busyCount == 1 && self.busyUpdate != nil) {
            self.busyUpdate(FALSE);
        }
        self.busyCount--;
    }
}

- (void) logErrorIfNotNil:(NSError *) error
{
    if (error) {
        NSLog(@"ERROR %@", error);
    }
}

#pragma mark * MSFilter methods


- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse
{
    // A wrapped response block that decrements the busy counter
    MSFilterResponseBlock wrappedResponse = ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        [self busy:NO];
        onResponse(response, data, error);
    };
    
    // Increment the busy counter before sending the request
    [self busy:YES];
    onNext(request, wrappedResponse);
}

@end
