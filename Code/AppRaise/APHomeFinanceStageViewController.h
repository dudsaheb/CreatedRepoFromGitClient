//
//  APHomeFinanceStageViewController.h
//  AppRaise
//
//  Created by Shaik Dud saheb on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APCustomSwitch.h"
#import "PSDatePickerViewController.h"

@interface APHomeFinanceStageViewController : UIViewController <UITextFieldDelegate,PSDatePickerViewControllerDelegate,APCustomSwitchDelegate>
{
    UIScrollView *financeStageScrollView;
    UIView *financeStageView;
    
    
    UITextField *dateTextField;
    UIButton *dateButton;

    UITextField *ownersNameTextField;
    UITextField *phoneNoTextField;
    UITextField *emailTextField;
    
    UITextField *financierNameTextField;
    UITextField *currentRepaymentTextField;
    UITextField *financePayoutTextField;
    UITextField *paymentsAffordabilityTextField;
    
    UIButton *backButton;
    UIButton *nextButton;

    UIImageView *bgImageView;

    NSLayoutConstraint *bottomScrollViewConstraint;
    CGFloat originalBottomConstraintValue;
    
    NSMutableDictionary *financeStageFormDataDict;

    
    UITextField *activeTextField;
    
    PSDatePickerViewController *customDatePicker;
    CGFloat extraHeightIfItIsIPhone5Device;

    NSDate *selectedDate;
    
    APCustomSwitch *financeOwningSwitch;
}

@property (nonatomic, retain) IBOutlet UIScrollView *financeStageScrollView;
@property (nonatomic, retain) IBOutlet UIView *financeStageView;

@property (nonatomic, retain) IBOutlet UITextField *dateTextField;
@property (nonatomic, retain) IBOutlet UIButton *dateButton;

@property (nonatomic, retain) IBOutlet UITextField *ownersNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *phoneNoTextField;
@property (nonatomic, retain) IBOutlet UITextField *emailTextField;

@property (nonatomic, retain) IBOutlet UITextField *financierNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *currentRepaymentTextField;
@property (nonatomic, retain) IBOutlet UITextField *financePayoutTextField;
@property (nonatomic, retain) IBOutlet UITextField *paymentsAffordabilityTextField;

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

@property (nonatomic,retain) NSMutableDictionary *financeStageFormDataDict;
@property (nonatomic,retain) UITextField *activeTextField;

@property (nonatomic,retain) PSDatePickerViewController *customDatePicker;
@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,retain)     NSDate *selectedDate;

- (IBAction)onBackButtonAction:(id)sender;
- (IBAction)onNextButtonAction:(id)sender;
- (IBAction)onDateButtonAction:(id)sender;


@property (nonatomic,retain) IBOutlet NSLayoutConstraint *bottomScrollViewConstraint;
@property (nonatomic,assign) CGFloat originalBottomConstraintValue;

@property (nonatomic,retain) APCustomSwitch *financeOwningSwitch;

@end
