//
//  APAppraiseView.h
//  AppRaise
//
//  Created by anilOruganti on 04/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APAppraiseView;

@protocol APAppraiseViewDelegate <NSObject>

- (void)closeBtnActionDelegate:(APAppraiseView*)appView;

@end

@interface APAppraiseView : UIView 
{
    id<APAppraiseViewDelegate> delgate;
}

@property (nonatomic, retain) id<APAppraiseViewDelegate> delgate;

- (IBAction)closeBtnAction:(id)sender;
- (void)adjustFrameAsPerDeviceScreenSize;

@end
