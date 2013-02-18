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
    MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://<YourMobileServiceUrl>.azure-mobile.net/"
            withApplicationKey:@"<YourApplicationKey>"];
    
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
    // A wrapped response block
    MSFilterResponseBlock wrappedResponse = ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        onResponse(response, data, error);
    };
    
    onNext(request, wrappedResponse);
}

@end
