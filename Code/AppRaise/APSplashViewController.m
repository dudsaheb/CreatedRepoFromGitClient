//
//  APSplashViewController.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APSplashViewController.h"


@implementation APSplashViewController

@synthesize imageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [activityIndicator release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self isThisIPhone5Device]) {
        [self.imageView setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
        //[self.view setFrame:CGRectMake(0, 0, 320, 568)];
        [self.view setFrame:[UIScreen mainScreen].bounds];
    }
    
    [self.imageView setImage:[UIImage imageNamed:@"Default-568h@2x.png"]];
    //[self.view setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view setFrame:[UIScreen mainScreen].bounds];
    
}

- (void)viewDidUnload
{
    [activityIndicator release];
    activityIndicator = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)startActivityIndicatorView
{
    [activityIndicator startAnimating];
}

- (void)stopActivityIndicatorView
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

- (BOOL)isThisIPhone5Device{
    
    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}

@end
