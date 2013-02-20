//
//  ViewController.m
//  Feedback
//
//  Created by Chris Risner on 1/24/13.
//  Copyright (c) 2013 Microsoft. All rights reserved.
//

#import "ViewController.h"
#import "FeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedSendFeedback:(id)sender {
    //Normal instantiator
//    UINavigationController *controller = [[FeedbackViewController alloc] init];
    //Character limit
    UINavigationController *controller = [[FeedbackViewController alloc] initWithMaxCharacters:1000];
    
    
    
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
