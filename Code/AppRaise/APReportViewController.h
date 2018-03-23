//
//  APReportViewController.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppraiseView.h"
#import "APResendTableViewCell.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Reachability.h"

@interface APReportViewController : UIViewController<UITabBarDelegate,APAppraiseViewDelegate,APResendTableViewCellDelegate,MFMailComposeViewControllerDelegate>
{
    UILabel *selectedMonthLbl;
    UITableView *savedRecordsTbl;
    UITabBarItem *hometab;
    UITabBarItem *acuraTab;
    NSArray *vehicleRecordsArray;
    NSMutableArray *selectedMothRecords;
    NSInteger selectedMonth;
    
    Reachability                * hostReach;
    Reachability                * internetReach;
    Reachability                * wifiReach;
    NetworkStatus               netStatus;

}
@property (nonatomic, retain) IBOutlet UILabel *selectedMonthLbl;
@property (nonatomic, retain) IBOutlet UITableView *savedRecordsTbl;
@property (nonatomic, retain) IBOutlet UITabBarItem *hometab;
@property (nonatomic, retain) IBOutlet UITabBarItem *acuraTab;
@property (nonatomic, retain)  NSArray *vehicleRecordsArray;
@property (nonatomic, retain) NSMutableArray *selectedMothRecords;
@property (nonatomic, assign) NSInteger selectedMonth;

@property (nonatomic, retain) NSString *monthString;

@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

- (IBAction)deleteRecordsBtnAction:(id)sender;
- (void)getSelctedMonthRecords:(NSInteger)selectedMonth;
- (IBAction)appRaiseButtonAction:(id)sender;

@end
