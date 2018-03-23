//
//  APHomeThirdStageVC.h
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APCustomSwitch.h"
#import "APFilterSwitch.h"
#import "APAppraiseView.h"
#import "PSDatePickerViewController.h"

@class APHomeFinanceStageViewController;

@interface APHomeThirdStageVC : UIViewController<APCustomSwitchDelegate,APFilterSwitchDelegate,APAppraiseViewDelegate,PSDatePickerViewControllerDelegate>
{
    
    UIScrollView *stageThreeScrollView;
    UIView *stageThreeView;
    UITextField *gearsTxtField;
    NSMutableDictionary *homeThirdVCFormDataDict;
    
    BOOL dataCollection2DictionaryStatus;
    
    PSDatePickerViewController *customDatePicker;
    UIButton *lastServiceDateButton;
    UITextField *lastServiceTextField;
    
    APHomeFinanceStageViewController *financeStageViewController;
    
    NSDate *lastServiceDate;

}

@property (nonatomic, retain) IBOutlet UIScrollView *stageThreeScrollView;
@property (nonatomic, retain) IBOutlet UIView *stageThreeView;
@property (nonatomic, retain) IBOutlet UITextField *gearsTxtField;

- (IBAction)nextBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;

@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,assign) CGFloat extraYPossitionForTextFieldVisibility;
@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;


@property (nonatomic,retain) PSDatePickerViewController *customDatePicker;
@property (nonatomic,retain) IBOutlet UIButton *lastServiceDateButton;
@property (nonatomic,retain) IBOutlet UITextField *lastServiceTextField;


- (IBAction)onLastServiceDateButtonAction:(id)sender;


@property (nonatomic,strong) APHomeFinanceStageViewController *financeStageViewController;

@property (nonatomic,retain) NSDate *lastServiceDate;

@end
