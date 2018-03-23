//
//  APPDFDisplayViewController.h
//  AppRaise
//
//  Created by anilOruganti on 22/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APPDFDisplayViewController : UIViewController <UITabBarDelegate>
{
    
    IBOutlet UIWebView *pdfWebView;
    UITabBarItem *acuraTab;
    UITabBarItem *homeTab;
    NSString *pdfFileName;
}
@property (nonatomic, retain) IBOutlet UITabBarItem *acuraTab;
@property (nonatomic, retain) IBOutlet UITabBarItem *homeTab;
@property (nonatomic, retain) NSString *pdfFileName;

@end
