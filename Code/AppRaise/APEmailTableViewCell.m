//
//  APEmailTableViewCell.m
//  AppRaise
//
//  Created by anilOruganti on 19/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APEmailTableViewCell.h"

@implementation APEmailTableViewCell

@synthesize emailTextField;
@synthesize cellIndex,delegate;
@synthesize isEmailSave;

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
- (void)awakeFromNib
{
    isEmailSave = NO;   
}

- (void)dealloc
{
    [emailTextField release];
    [super dealloc];
}

- (IBAction)saveBtnAction:(id)sender 
{
    self.isEmailSave = YES;
    [emailTextField resignFirstResponder];
    [delegate saveBtnActionDelegate:self fromSave:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [emailTextField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    if (self.isEmailSave == NO)
    {
        [delegate saveBtnActionDelegate:self fromSave:NO];

    }
    [delegate textFieldEndDelegate:self];
    [self.emailTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.isEmailSave = NO;
    [delegate textFieldBeginDelegate:self];
}


@end
