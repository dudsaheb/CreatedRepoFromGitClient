//
//  PSPhotoTblViewCell.h
//  PreStartExpress
//
//  Created by anilOruganti on 11/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PSPhotoTblViewCell : UITableViewCell 
{
    UIImageView *photoImgView;
}
@property (nonatomic, retain) IBOutlet UIImageView *photoImgView;
@property (nonatomic, retain) IBOutlet UIView *containerView;;


@end
