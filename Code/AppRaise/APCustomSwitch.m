//
//  APCustomSwitch.m
//  AppRaise
//
//  Created by anilOruganti on 19/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APCustomSwitch.h"


@implementation APCustomSwitch

@synthesize delegate;
@synthesize isSwitchStatusOn;

+ (APCustomSwitch*)sharedSwitch
{
    APCustomSwitch *customSwitch;
	NSArray *nibViews;
	nibViews			= [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
	customSwitch	= (APCustomSwitch*)[nibViews lastObject];	
	return customSwitch;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [onOffImage release];
    [super dealloc];
}

- (IBAction)onButtonAction:(id)sender 
{
    onOffImage.image = [UIImage imageNamed:@"yesSwitch.png"];
    if ([delegate respondsToSelector:@selector(onOffButtonActionDelegate:withSwitchTag:)])
    {
        self.isSwitchStatusOn = YES;
        [delegate onOffButtonActionDelegate:YES withSwitchTag:self.tag];
    }
}

- (IBAction)offButtonAction:(id)sender 
{
    onOffImage.image = [UIImage imageNamed:@"noSwitch.png"];
    if ([delegate respondsToSelector:@selector(onOffButtonActionDelegate:withSwitchTag:)])
    {
        self.isSwitchStatusOn = NO;
        [delegate onOffButtonActionDelegate:NO withSwitchTag:self.tag];
    }
}

- (void)setSwitchStatus:(BOOL)switchStatus
{
    self.isSwitchStatusOn = switchStatus;
    onOffImage.image = (switchStatus) ? [UIImage imageNamed:@"yesSwitch.png"] : [UIImage imageNamed:@"noSwitch.png"];
}

@end
