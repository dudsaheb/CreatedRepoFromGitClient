//
//  APSplashViewController.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APSplashViewController : UIViewController 
{
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UIImageView *imageView;

- (void)startActivityIndicatorView;
- (void)stopActivityIndicatorView;

@end
