//
//  APHomeViewController.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APCustomSwitch.h"
#import "PSDatePickerViewController.h"
#import "APAppraiseView.h"



@interface APHomeViewController : UIViewController<APCustomSwitchDelegate,UIScrollViewDelegate,PSDatePickerViewControllerDelegate,APAppraiseViewDelegate> 
{
    UIScrollView *firstStageScrollView;
    UIView *firstStageView;
    UITextField *makeTxtFiled;
    UITextField *typeTxtFiled;
    UITextField *modelTxtFiled;
    UITextField *regNoTxtFiled;
    UITextField *expiryDateTxtFiled;
    UITextField *odometerReadingTxtFiled;
    NSMutableDictionary *homeVCFormDataDict;
    PSDatePickerViewController *customDatePicker;
    

}

@property (nonatomic, retain) IBOutlet UIScrollView *firstStageScrollView;
@property (nonatomic, retain) IBOutlet UIView *firstStageView;
@property (nonatomic, retain) IBOutlet UITextField *makeTxtFiled;
@property (nonatomic, retain) IBOutlet UITextField *typeTxtFiled;
@property (nonatomic, retain) IBOutlet UITextField *modelTxtFiled;
@property (nonatomic, retain) IBOutlet UITextField *regNoTxtFiled;
@property (nonatomic, retain) IBOutlet UITextField *expiryDateTxtFiled;
@property (nonatomic, retain) IBOutlet UITextField *odometerReadingTxtFiled;

@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,assign) CGFloat extraYPossitionForTextFieldVisibility;
@property (nonatomic,assign) CGFloat extraHeightForContentSize;
@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

- (IBAction)nextBtnAction:(id)sender;
- (IBAction)expiryDateButtonClickedAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;


@end
