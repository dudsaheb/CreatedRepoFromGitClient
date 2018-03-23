//
//  APEmailViewController.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APEmailTableViewCell.h"
#import "APAppraiseView.h"

@protocol APEmailViewControllerDeleagte <NSObject>

- (void)loadViewWithTabBar;

@end

@interface APEmailViewController : UIViewController<APEmailTableViewCellDelegate,APAppraiseViewDelegate> 
{
    UITableView *emailTableview;
    id <APEmailViewControllerDeleagte>  delegate;
    NSInteger                           cellCount;
    NSString                            *currentEmail;
    NSInteger                           currentCellId;
    NSMutableDictionary                 *emailDictionary;
    BOOL                    isEditEmail, iskeyBoardUp;
    IBOutlet UIButton                   *editAddressBtn;
    BOOL   isCellStillInEditingMode;
    
    CGSize tableViewOriginalContentSize;
    
    APEmailTableViewCell *currentEmailCell;
    NSLayoutConstraint *bottomContraintForTableView;
    CGFloat originalBottomContraintValueForTableView;
    
    UIButton *enterPrestartButton;

}

@property (nonatomic, retain) IBOutlet UITableView *emailTableview;
@property (nonatomic, retain) id <APEmailViewControllerDeleagte> delegate;
@property (nonatomic, assign) NSInteger   cellCount;
@property (nonatomic, retain) NSString   *currentEmail;
@property (nonatomic, assign) NSInteger   currentCellId;

@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;


- (IBAction)enterPreStartBtnAction:(id)sender;
- (IBAction)editAddressBtnAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;


@property (nonatomic,assign) CGSize tableViewOriginalContentSize;
@property (nonatomic,retain) APEmailTableViewCell *currentEmailCell;

@property (nonatomic,retain) IBOutlet NSLayoutConstraint *bottomContraintForTableView;

@property (nonatomic,assign) CGFloat originalBottomContraintValueForTableView;
@property (nonatomic,retain) IBOutlet UIButton *enterPrestartButton;

@end
