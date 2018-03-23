//
//  PSPhotoTblViewCell.m
//  PreStartExpress
//
//  Created by anilOruganti on 11/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PSPhotoTblViewCell.h"


@implementation PSPhotoTblViewCell
@synthesize photoImgView;
@synthesize containerView;

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

- (void)dealloc
{
    [photoImgView release];
    [super dealloc];
}

@end
