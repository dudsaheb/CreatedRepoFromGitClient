//
//  APEmailTableViewCell.h
//  AppRaise
//
//  Created by anilOruganti on 19/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APEmailTableViewCell;

@protocol APEmailTableViewCellDelegate <NSObject>

- (void)saveBtnActionDelegate:(APEmailTableViewCell*)emailcell fromSave:(BOOL)isFromSave;
- (void)textFieldBeginDelegate:(APEmailTableViewCell*)emailcell;
- (void)textFieldEndDelegate:(APEmailTableViewCell*)emailcell;

@end

@interface APEmailTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    
    UITextField                         *emailTextField;
    NSInteger                           cellIndex;
    id<APEmailTableViewCellDelegate>    delegate;
    BOOL                                isEmailSave;
    
}
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;
@property (nonatomic, assign) NSInteger             cellIndex;
@property (nonatomic, assign) id<APEmailTableViewCellDelegate> delegate;
@property (nonatomic,assign)     BOOL    isEmailSave;


- (IBAction)saveBtnAction:(id)sender;
@end
