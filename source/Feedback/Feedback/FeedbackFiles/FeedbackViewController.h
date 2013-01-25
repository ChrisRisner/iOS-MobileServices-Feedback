//
//  FeedbackViewController.h
//  Feedback
//
//  Created by Chris Risner on 1/25/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate> {
    @private
    int maxCharacters;
    int rating;
}

- (id)initWithMaxCharacters:(int)maximumChars;

@property (weak, nonatomic) IBOutlet UITextView *txtComments;
@property (weak, nonatomic) IBOutlet UILabel *lblCharsRemaining;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailAddress;
- (IBAction)tappedStarOne:(id)sender;
- (IBAction)tappedStarTwo:(id)sender;
- (IBAction)tappedStarThree:(id)sender;
- (IBAction)tappedStarFour:(id)sender;
- (IBAction)tappedStarFive:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnStarOne;
@property (weak, nonatomic) IBOutlet UIButton *btnStarTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnStarThree;
@property (weak, nonatomic) IBOutlet UIButton *btnStarFour;
@property (weak, nonatomic) IBOutlet UIButton *btnStarFive;
@property (weak, nonatomic) IBOutlet UIScrollView *svScrollView;
- (IBAction)tappedSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
