//
//  APAppController.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APAppController.h"
#import <QuartzCore/QuartzCore.h>
#import "APCommon.h"
#import "APConstants.h"
#import "AppRaiseAppDelegate.h"

@interface APAppController (Private)

- (void)showlayerAnimation;
- (void)loadSplashScreen;
- (void)loadMainView;
- (NSArray*)twoTabBarItemsModeViewControllers;
- (void)loadMainScreenWithOutTabBar;
- (void)loadTabBarController;

@end

@implementation APAppController

@synthesize tabbarController;
@synthesize vehicaleDataDictionary;

- (id)initWithWindow:(UIWindow*)window
{
    self = [super init];
    if (self) 
    {
        appWindow = window;
        
        self.vehicaleDataDictionary    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];

    }
    return self; 
}

+ (APAppController*)sharedAppController
{
    AppRaiseAppDelegate *appDelegate;
    appDelegate = (AppRaiseAppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.appCtrl;
}


- (void)showlayerAnimation
{
    CATransition *anmation  = [CATransition animation];
    anmation.delegate       = self;
    anmation.duration       = 0.75f;
    anmation.type           = kCATransitionFade;
    anmation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [[appWindow layer] addAnimation:anmation  forKey:@"Transition"];
    [[appWindow.rootViewController.view layer] addAnimation:anmation  forKey:@"Transition"];

    
}

- (void)loadSplashScreen
{
    emailViewController = nil;
    splahVC = [[APSplashViewController alloc] initWithNibName:@"APSplashViewController" bundle:nil];
    [splahVC startActivityIndicatorView];
    [splahVC.view setBackgroundColor:[UIColor yellowColor]];
    //[appWindow addSubview:splahVC.view];
    [appWindow.rootViewController.view addSubview:splahVC.view];
    [self performSelector:@selector(removeFromSplashView) withObject:nil afterDelay:1.0f]; 
}

- (void)removeFromSplashView
{
    [splahVC stopActivityIndicatorView];
    [splahVC.view removeFromSuperview];
    [self showlayerAnimation];  
    [splahVC release];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self loadMainView];
}

- (void)loadMainView
{
    NSLog(@"loadMainView");
    [self loadMainScreenWithOutTabBar];
}

- (void)loadMainScreenWithOutTabBar
{
    if (self.tabbarController != nil) 
    {
        [self.tabbarController.view removeFromSuperview];
        self.tabbarController   = nil;
    }
    if (nil != emailViewController) 
    {
        emailViewController = nil;
    }
    emailViewController = [[APEmailViewController alloc] initWithNibName:@"APEmailViewController" bundle:nil];
    emailViewController.delegate                = self;
    [emailViewController.view setBackgroundColor:[UIColor clearColor]];
    
    mainNavCtrl                         = [[UINavigationController alloc] initWithRootViewController:emailViewController];
    emailViewController.navigationController.navigationBarHidden = YES;
    //[appWindow addSubview:mainNavCtrl.view]; // DEPRECATED
    [appWindow.rootViewController.view addSubview:mainNavCtrl.view];
    [emailViewController release];
    
}


- (void)loadViewWithTabBar
{
    [self loadTabBarController];
}

- (void)loadTabBarController
{
    if (nil != mainNavCtrl) 
    {
        [mainNavCtrl.view removeFromSuperview];
        [mainNavCtrl release];
        mainNavCtrl = nil;
    }
    
    //    [self showlayerAnimation];  
	UITabBarController *tmpTabBarController = [[UITabBarController alloc] init];
	[tmpTabBarController setViewControllers:[self twoTabBarItemsModeViewControllers] animated:YES];
	tmpTabBarController.delegate = self;
	tmpTabBarController.view.multipleTouchEnabled = NO;
	[tmpTabBarController setSelectedIndex:1];
	self.tabbarController = tmpTabBarController;
    //[appWindow addSubview:self.tabbarController.view];// DEPRECATED
	[appWindow.rootViewController.view addSubview:self.tabbarController.view];
    [self showlayerAnimation];  
	[tmpTabBarController release];	
}

// Purpose       :  Implements twoTabBarItemsModeViewControllers
// Parameters :  nil
// Return type :  NSArray
// Comments  :  nil
- (NSArray*)twoTabBarItemsModeViewControllers
{
 
    CGFloat iosVersion = [[UIDevice currentDevice].systemVersion floatValue];
    BOOL isIOSIsLessThanOrEqual7 = (iosVersion<=7.0)?YES:NO;
    
    //CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
   // BOOL isSmallIphoneDevice3_5 = (screenHeight>480)?NO:YES;

    
	if(activeTabBarVCs)
    {
		[activeTabBarVCs release];
		activeTabBarVCs = nil;
	}
	
	activeTabBarVCs = [[NSMutableArray alloc] init];
    
	UINavigationController *navController = nil;
	
	//Creates Emails view controller 
    APEmailViewController *emailVC                  = [[APEmailViewController alloc] initWithNibName:@"APEmailViewController" bundle:nil];
    
    [emailVC.view setBackgroundColor:[UIColor clearColor]];

    if (isIOSIsLessThanOrEqual7) {
        
        emailVC.tabBarItem.title                         = @"Emails";
        emailVC.tabBarItem.image                        = [APCommon loadImageFromResourcePath:@"EmailTab" ofType:EXT_PNG];

    } else {
        emailVC.tabBarItem.image                        = [APCommon loadImageFromResourcePath:@"TabEmail" ofType:EXT_PNG];

    }
    
    

    
    navController                                   = [[UINavigationController alloc]initWithRootViewController:emailVC];
    emailVC.navigationController.navigationBarHidden = YES;
	[activeTabBarVCs addObject:navController];
    [emailVC release];
	[navController release];
	navController = nil;
	
	//Creates DashBoard View Controller	
    APHomeViewController *homeVc                    = [[APHomeViewController alloc] initWithNibName:@"APHomeViewController" bundle:nil];
    
    if (isIOSIsLessThanOrEqual7 ) {
        
        homeVc.tabBarItem.title                         = @"Home";
        homeVc.tabBarItem.image                         = [APCommon loadImageFromResourcePath:@"HomeTab" ofType:EXT_PNG];

    } else {
        homeVc.tabBarItem.image                         = [APCommon loadImageFromResourcePath:@"TabHome" ofType:EXT_PNG];

    }
    
    

    
    navController                                   = [[UINavigationController alloc] initWithRootViewController:homeVc];
    homeVc.navigationController.navigationBarHidden = YES;
    //homeVc.delegate                                 = self;
	[activeTabBarVCs addObject:navController];
    [homeVc release];
	[navController release];
	navController = nil;
    
    //Creates Saved reports View Controller	
    APReportMonthSelectionViewCtrl *viewAllController      = [[APReportMonthSelectionViewCtrl alloc] initWithNibName:@"APReportMonthSelectionViewCtrl" bundle:nil];
    
    if (isIOSIsLessThanOrEqual7 ) {
        viewAllController.tabBarItem.title              = @"Saved appraisals";
        viewAllController.tabBarItem.image              = [APCommon loadImageFromResourcePath:@"SaveTab" ofType:EXT_PNG];

    } else {
        viewAllController.tabBarItem.image              = [APCommon loadImageFromResourcePath:@"TabSave" ofType:EXT_PNG];

    }
    
    

    
	navController                                   = [[UINavigationController alloc] initWithRootViewController:viewAllController];
    viewAllController.navigationController.navigationBarHidden = YES;
	[activeTabBarVCs addObject:navController];
    [viewAllController release];
	[navController release];
	navController = nil;	
	return activeTabBarVCs;
}

#pragma mark - UITabBarController Deleagtes

- (void)tabBarController:(UITabBarController *)tabBarController 
 didSelectViewController:(UIViewController *)viewController
{
    // NSLog(@"selectedIndex %d",self.tabbarController.selectedIndex);
    switch (self.tabbarController.selectedIndex) 
    {
        case 0:
            [self showlayerAnimation];
            [self loadMainScreenWithOutTabBar];
            break;
        case 1:
            [[[[(UINavigationController *)viewController viewControllers] lastObject] navigationController] popViewControllerAnimated:NO];
            break;
        case 2:
            [[[[(UINavigationController *)viewController viewControllers] lastObject] navigationController] popViewControllerAnimated:NO];
            //[[[(UINavigationController*)viewController viewControllers] lastObject] removeSavedRecordsListView:YES];
            break;
    }
}



- (void)resetAllTheFormValues{
    
    [self.vehicaleDataDictionary setObject:@"" forKey:MAKE_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:MODEL_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:REGO_NO_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:TYPE_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:EXPIRY_DATE_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:ODOMETER_READING_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:BUILT_YEAR_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:COMPLIANCE_YEAR_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:VIN_NO_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:EXTERIOR_COLOR_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:INTERIOR_COLOR_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:ENGINE_SIZE_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:CYLINDERS_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:GEARS_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:MECHANICALS_TXTVIEW];
    [self.vehicaleDataDictionary setObject:@"" forKey:PANEL_WORK_TXTVIEW];
    [self.vehicaleDataDictionary setObject:@"" forKey:APPRAISAL_DATE_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:APPRAISED_BY_TXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:APPRAISED_SCORE_FIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:OTHER_INFO_TXTVIEW];
    [self.vehicaleDataDictionary setObject:@"" forKey:LAST_SERVICE_DATE_TXTFIELD];
    
    // Finance Stage
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_DATE_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_OWNERS_NAME_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_PHONE_NO_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_EMAIL_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_PAYOUT_TEXTFIELD];
    [self.vehicaleDataDictionary setObject:@"" forKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];
    
    // Default Finance Owing is NO
    [self.vehicaleDataDictionary setObject:@"NO" forKey:FINANCE_OWING_SWITCH];

    
    
    
    AppRaiseAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
 //   int totalSwitches = [appdelegate switchTagValue];
    int totalSwitches = [[self.vehicaleDataDictionary objectForKey:TOTAL_SWITCHES_COUNT] intValue];

    for (int i = 1; i < totalSwitches; i++)
    {
        [self.vehicaleDataDictionary setObject:SWITCH_DICTIONARY_VALUE(NO) forKey:SWITCH_DICTIONARY_KEY(i)];
    }
    
    for (int j =1; j < 10; j++)
    {
        [self.vehicaleDataDictionary setObject:FILTER_DICTIONARY_VALUE(NO) forKey:FILTER_DICTIONARY_KEY(j)];
    }
    
    
    // Again updating to zero
    [appdelegate setSwitchTagValue:0];
    
    // Resetting photos dictionary
    [[(AppRaiseAppDelegate*)[[UIApplication sharedApplication]delegate] photosCollectionDict] removeAllObjects];
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]delegate] setPhotosCollectionDict:nil];
    
    NSMutableDictionary *photosDict = [[NSMutableDictionary alloc] init];
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]delegate] setPhotosCollectionDict:photosDict];
    [photosDict release];
    
}


@end
