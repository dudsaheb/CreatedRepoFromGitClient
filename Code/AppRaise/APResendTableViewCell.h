//
//  APResendTableViewCell.h
//  AppRaise
//
//  Created by anilOruganti on 19/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APResendTableViewCell;

@protocol APResendTableViewCellDelegate <NSObject>

- (void)reSendBtnDelegateAction:(APResendTableViewCell*)selectedCell;

@end

@interface APResendTableViewCell : UITableViewCell
{
    id<APResendTableViewCellDelegate> delegate;
    NSInteger cellIndex;
}
@property (retain, nonatomic) IBOutlet UILabel *reSendText;
@property (assign, nonatomic)id<APResendTableViewCellDelegate> delegate;
@property (nonatomic, assign) NSInteger cellIndex;
- (IBAction)reSendBtnAction:(id)sender;

@end
