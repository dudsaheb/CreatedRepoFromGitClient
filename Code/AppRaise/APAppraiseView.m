//
//  APAppraiseView.m
//  AppRaise
//
//  Created by anilOruganti on 04/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APAppraiseView.h"


@implementation APAppraiseView

@synthesize delgate;

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
    [super dealloc];
}

- (IBAction)closeBtnAction:(id)sender 
{
    if ([delgate respondsToSelector:@selector(closeBtnActionDelegate:)])
    {
        [delgate closeBtnActionDelegate:self];
    }
}

- (void)adjustFrameAsPerDeviceScreenSize{

    if (![self isThisLessThaniOS7Version]) {
        CGRect targetFrame = self.frame;
        targetFrame.origin = CGPointMake(0, 21);
        self.frame = targetFrame;
    }
    
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

@end
