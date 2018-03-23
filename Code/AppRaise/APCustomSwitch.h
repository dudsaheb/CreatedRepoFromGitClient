//
//  APCustomSwitch.h
//  AppRaise
//
//  Created by anilOruganti on 19/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APCustomSwitchDelegate <NSObject>

@optional
- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag;
- (void)didOffbuttonSelected:(CGRect)rect withSwitchTag:(NSInteger)switchTag;

@end


@interface APCustomSwitch : UIView 
{
    id<APCustomSwitchDelegate> delegate;
    IBOutlet UIImageView *onOffImage;
    BOOL isSwitchStatusOn;
}
@property (nonatomic, assign) id<APCustomSwitchDelegate> delegate;
@property (nonatomic,assign) BOOL isSwitchStatusOn;

+ (APCustomSwitch*)sharedSwitch;
- (IBAction)onButtonAction:(id)sender;
- (IBAction)offButtonAction:(id)sender;
- (void)setSwitchStatus:(BOOL)switchStatus;
@end
