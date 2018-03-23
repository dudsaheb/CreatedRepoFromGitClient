//
//  APPhotosViewConroller.m
//  AppRaise
//
//  Created by anilOruganti on 24/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APPhotosViewConroller.h"
#import "PSPhotoTblViewCell.h"
#import "AppRaiseAppDelegate.h"
#import "APConstants.h"

@implementation APPhotosViewConroller
@synthesize noImagesLabel;
@synthesize photosTableView;
//@synthesize photosCollectDict;

@synthesize bgImageView;
@synthesize bottomConstraint = _bottomConstraint;

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
    [noImagesLabel release];
    [photosTableView release];
    [_bottomConstraint release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([self isThisIPhone5Device] && [self isThisLessThaniOS7Version]){
        [self.bottomConstraint setConstant:-10.00];
    }
    
    [self updateBgImageForIPhone5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    photosCollectDict = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] photosCollectionDict];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNoImagesLabel:nil];
    [self setPhotosTableView:nil];
    //self.photosCollectDict = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark ......
#pragma mark VIEW PHOTO TABLEVIEW - Delegate and DataSource  _ METHODE   
#pragma mark ......


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 164.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 3;
    return [photosCollectDict count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celIdentifier = @"PhotoCellIdentifier";
    
    PSPhotoTblViewCell *photoCell = (PSPhotoTblViewCell*)[tableView dequeueReusableCellWithIdentifier:celIdentifier];
    
    if (photoCell == nil)
    {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"PSPhotoTblViewCell" owner:self options:nil];
        photoCell = (PSPhotoTblViewCell*)[nibViews lastObject];
    }
    
    UIImage *img = (UIImage*)[photosCollectDict objectForKey:PHOTO_KEY(indexPath.row + 1)];
    if (img == nil) {
        [photoCell.containerView setHidden:YES];
    } else {
        [photoCell.containerView setHidden:NO];
        photoCell.photoImgView.image = img;
        [photoCell.photoImgView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return photoCell;
}

- (void)photosTableViewReloadData
{
    if ([photosCollectDict count] == 0 ) 
    {
        photosTableView.hidden  = YES;
        noImagesLabel.hidden    = NO;
    }
    else
    {
        photosTableView.hidden  = NO;
        noImagesLabel.hidden    = YES;
    }
    [photosTableView reloadData];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isThisIPhone5Device{
    
    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}

- (BOOL)isThisLessThaniOS7Version{

    BOOL status = YES;
    
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    status = (systemVersion<7.0)?YES:NO;
    return status;
}

- (void)updateBgImageForIPhone5{

    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}

@end
