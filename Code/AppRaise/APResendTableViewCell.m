//
//  APResendTableViewCell.m
//  AppRaise
//
//  Created by anilOruganti on 19/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APResendTableViewCell.h"

@implementation APResendTableViewCell
@synthesize reSendText;
@synthesize delegate;
@synthesize cellIndex;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [reSendText release];
    [super dealloc];
}
- (IBAction)reSendBtnAction:(id)sender
{
    if ([delegate respondsToSelector:@selector(reSendBtnDelegateAction:)]) 
    {
        [delegate reSendBtnDelegateAction:self];
    }
}
@end
