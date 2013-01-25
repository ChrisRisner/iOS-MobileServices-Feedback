//
//  FeedbackViewController.h
//  Feedback
//
//  Created by Chris Risner on 1/25/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController <UITextViewDelegate> {
    @private
    int maxCharacters;
}

- (id)initWithMaxCharacters:(int)maximumChars;

@property (weak, nonatomic) IBOutlet UITextView *txtComments;
@property (weak, nonatomic) IBOutlet UILabel *lblCharsRemaining;

@end
