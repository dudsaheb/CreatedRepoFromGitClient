//
//  APFilterSwitch.m
//  AppRaise
//
//  Created by anilOruganti on 23/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APFilterSwitch.h"
#import "APConstants.h"
#import "APCommon.h"

@implementation APFilterSwitch
@synthesize delegate;

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
    [filterBtn release];
    [super dealloc];
}

- (IBAction)filterBtnAction:(id)sender 
{
    if (isBtnClicked) 
    {
        [filterBtn setImage:[APCommon loadImageFromResourcePath:@"notFilteredBtn" ofType:EXT_PNG] forState:UIControlStateNormal];
        isBtnClicked = NO;
    }
    else
    {
        [filterBtn setImage:[APCommon loadImageFromResourcePath:@"filteredBtn" ofType:EXT_PNG] forState:UIControlStateNormal];
        isBtnClicked = YES;
    }
    if ([delegate respondsToSelector:@selector(filterButtonClicked: withSwitchTag:)])
    {
        [delegate filterButtonClicked:isBtnClicked withSwitchTag:self.tag];
    }
}

- (void)setFilterBtnStatus:(BOOL)status
{
    isBtnClicked = status;
    if (status) 
    {
        [filterBtn setImage:[APCommon loadImageFromResourcePath:@"filteredBtn" ofType:EXT_PNG] forState:UIControlStateNormal];
    }
    else
    {
        [filterBtn setImage:[APCommon loadImageFromResourcePath:@"notFilteredBtn" ofType:EXT_PNG] forState:UIControlStateNormal];
    }
}


- (void)awakeFromNib
{
    isBtnClicked = YES;
}
@end
