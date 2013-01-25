//
//  FeedbackViewController.m
//  Feedback
//
//  Created by Chris Risner on 1/25/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "FeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FeedbackService.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController


- (id)initWithMaxCharacters:(int)maximumChars {
    self = [super init];
    
    maxCharacters = maximumChars;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([nibNameOrNil length] == 0) {
        //detect iPhone or iPad
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            nibNameOrNil = @"FeedbackView_iPad";
        } else {
            nibNameOrNil = @"FeedbackView_iPhone";
        }
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    rating = -1;
    self.txtComments.layer.cornerRadius = 5.0f;
    self.txtComments.layer.borderWidth = 2.0f;
    self.txtComments.layer.borderColor = [[UIColor grayColor] CGColor];
    
    if (maxCharacters > 0) {
        self.lblCharsRemaining.text = [NSString stringWithFormat:@"%i characters remaining", maxCharacters];
    } else {
        self.lblCharsRemaining.hidden = YES;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.txtEmailAddress resignFirstResponder];
    [self.txtComments resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (maxCharacters > 0) {
        int currentChars = [self.txtComments.text length];
        int newChars = currentChars + [text length];
        
        if (newChars > maxCharacters) {
            return NO;
        } else {
            self.lblCharsRemaining.text = [NSString stringWithFormat:@"%i characters remaining", (maxCharacters - newChars)];
            return YES;
        }
    } else {
        return YES;
    }
}

- (IBAction)tappedStarOne:(id)sender {
    [self setRatingWithStars:1];
}

- (IBAction)tappedStarTwo:(id)sender {
    [self setRatingWithStars:2];
}

- (IBAction)tappedStarThree:(id)sender {
    [self setRatingWithStars:3];
}

- (IBAction)tappedStarFour:(id)sender {
    [self setRatingWithStars:4];
}

- (IBAction)tappedStarFive:(id)sender {
    [self setRatingWithStars:5];
}

-(void) setRatingWithStars:(int)starCount {
    rating = starCount;
    //Dismiss the keyboard just in case it's showing
    [self dismissKeyboard];
    UIImage *selectedStarImage = [UIImage imageNamed:@"SelectedStar.png"];
    UIImage *unselectedStarImage = [UIImage imageNamed:@"UnselectedStar.png"];
    
    if (starCount == 1) {
        [self.btnStarOne setBackgroundImage:selectedStarImage forState: UIControlStateSelected & UIControlStateApplication];
        [self.btnStarTwo setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarThree setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFour setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFive setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
    } else if (starCount == 2) {
        [self.btnStarOne setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarTwo setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarThree setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFour setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFive setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
    } else if (starCount == 3) {
        [self.btnStarOne setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarTwo setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarThree setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFour setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFive setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
    } else if (starCount == 4) {
        [self.btnStarOne setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarTwo setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarThree setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFour setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFive setBackgroundImage:unselectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
    } else if (starCount == 5) {
        [self.btnStarOne setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarTwo setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarThree setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFour setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
        [self.btnStarFive setBackgroundImage:selectedStarImage forState:UIControlStateSelected & UIControlStateApplication];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.svScrollView) {
        CGRect rectBottom = CGRectZero;
        rectBottom.size = self.svScrollView.frame.size;
        rectBottom.origin.y = self.svScrollView.contentSize.height - rectBottom.size.height;
        rectBottom.origin.x = 0;
        
        [self.svScrollView scrollRectToVisible:rectBottom animated:YES];
    }
}
- (IBAction)tappedSubmit:(id)sender {
    //Do any validation of data you want here
    
    
    
    NSDictionary *record;
    if (rating > 0) {
        record =
            @{ @"comments" : self.txtComments.text
             , @"email" : self.txtEmailAddress.text
             , @"rating" : @(rating)};
    } else {
        record =
        @{ @"comments" : self.txtComments.text
        , @"email" : self.txtEmailAddress.text};
    }
    FeedbackService *feedbackService = [FeedbackService getInstance];
    [feedbackService saveFeedback:record completion:^{
        //Decide what you want to do here
        if ([self isModal]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

-(BOOL)isModal {
    
    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;        
    
}
@end
