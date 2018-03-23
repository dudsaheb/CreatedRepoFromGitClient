//
//  APReportMonthSelectionViewCtrl.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppraiseView.h"

@interface APReportMonthSelectionViewCtrl : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, APAppraiseViewDelegate>
{
    NSArray *monthsListArray;
    NSMutableArray *yearsListArray;
    UIPickerView *monthPicker;
}
@property (nonatomic, retain) IBOutlet UIPickerView *monthPicker;
- (IBAction)doneBtnAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;

@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

@end
