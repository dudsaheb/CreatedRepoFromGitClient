//
//  APPDFDisplayViewController.m
//  AppRaise
//
//  Created by anilOruganti on 22/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APPDFDisplayViewController.h"


@implementation APPDFDisplayViewController
@synthesize acuraTab;
@synthesize homeTab;
@synthesize pdfFileName;

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
    [acuraTab release];
    [homeTab release];
    [pdfWebView release];
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
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    NSString *saveDirectory = [paths objectAtIndex:0];
//    NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:@""]; 
//    //NSString *path = [[NSBundle mainBundle] pathForResource:@"newFilePath" ofType:@"pdf"];
//    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:newFilePath]];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
//    webView.scalesPageToFit = YES;
//    [webView loadRequest:rq];
//    [self.view addSubview:webView];
//    [self.view sendSubviewToBack:webView];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *saveDirectory = [paths objectAtIndex:0];
    NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:pdfFileName]; 
    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:newFilePath]];
    pdfWebView.scalesPageToFit = YES;
    [pdfWebView loadRequest:rq];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setAcuraTab:nil];
    [self setHomeTab:nil];
    [pdfWebView release];
    pdfWebView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(tabBar.selectedItem == self.homeTab)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acuramultimedia.com"]];
    }
}

- (IBAction)onHomeButtonAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAcuraButtonAction:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acuramultimedia.com"]];
    
}

@end
