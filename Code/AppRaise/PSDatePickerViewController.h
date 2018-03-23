//
//  PSDatePickerViewController.h
//  PreStartExpress
//
//  Created by anilOruganti on 09/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSDatePickerViewControllerDelegate<NSObject> 

@optional

- (void)onDateCancelButtonClicked;
- (void)onDateDoneButtonClicked:(NSDate*)date;

@end


@interface PSDatePickerViewController : UIViewController 
{
    
    UIDatePicker *datePicker;
    id<PSDatePickerViewControllerDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, assign) id<PSDatePickerViewControllerDelegate> delegate;

- (IBAction)dateCancelBtnAction:(id)sender;
- (IBAction)dateDoneBtnAction:(id)sender;

@end
