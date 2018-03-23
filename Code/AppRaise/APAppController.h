//
//  APAppController.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APSplashViewController.h"
#import "APEmailViewController.h"
#import "APHomeViewController.h"
#import "APReportMonthSelectionViewCtrl.h"

@interface APAppController : NSObject<UITabBarControllerDelegate,APEmailViewControllerDeleagte> 
{
    APSplashViewController  *splahVC;
    UIWindow                *appWindow;
    UINavigationController  *mainNavCtrl;
    UITabBarController      *tabbarController;
    NSMutableArray          *activeTabBarVCs;
    APEmailViewController   *emailViewController;
    NSMutableDictionary *vehicaleDataDictionary;
}

@property(nonatomic, retain) UITabBarController      *tabbarController;
@property (nonatomic,retain)     NSMutableDictionary *vehicaleDataDictionary;
;

- (id)initWithWindow:(UIWindow*)window;
+ (APAppController*)sharedAppController;
- (void)loadSplashScreen;
- (void)resetAllTheFormValues;
- (void)loadMainView;
- (void)removeFromSplashView;

@end
