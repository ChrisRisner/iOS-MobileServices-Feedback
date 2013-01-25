//
//  FeedbackViewController.m
//  Feedback
//
//  Created by Chris Risner on 1/25/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "FeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>

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

    self.txtComments.layer.cornerRadius = 5.0f;
    self.txtComments.layer.borderWidth = 2.0f;
    self.txtComments.layer.borderColor = [[UIColor grayColor] CGColor];
    
    if (maxCharacters > 0) {
        self.lblCharsRemaining.text = [NSString stringWithFormat:@"%i characters remaining", maxCharacters];
    } else {
        self.lblCharsRemaining.hidden = YES;
    }
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

@end
