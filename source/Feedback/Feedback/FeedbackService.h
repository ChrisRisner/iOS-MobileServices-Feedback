//
//  FeedbackService.h
//  Feedback
//
//  Created by Chris Risner on 1/24/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#pragma mark * Block Definitions
typedef void (^CompletionBlock) ();
typedef void (^CompletionWithIndexBlock) (NSUInteger index);

@interface FeedbackService : NSObject<MSFilter>

@property (nonatomic, strong)   MSClient *client;

+(FeedbackService*) getInstance;


- (void) saveFeedback:(NSDictionary *)feedback
           completion:(CompletionBlock) completion;

- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse;

@end
