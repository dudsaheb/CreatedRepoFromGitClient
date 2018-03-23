//
//  APPhotosViewConroller.h
//  AppRaise
//
//  Created by anilOruganti on 24/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APPhotosViewConroller : UIViewController 
{
    
    UILabel *noImagesLabel;
    UITableView *photosTableView;
    NSDictionary *photosCollectDict;
}
@property (nonatomic, retain) IBOutlet UILabel *noImagesLabel;
@property (nonatomic, retain) IBOutlet UITableView *photosTableView;
//@property (nonatomic, retain) NSDictionary *photosCollectDict;

- (IBAction)backButtonAction:(id)sender;
- (void)photosTableViewReloadData;

@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end
