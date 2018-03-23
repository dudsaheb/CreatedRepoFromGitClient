//
//  APHomeSecondStageVC.h
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APCustomSwitch.h"
#import "APAppraiseView.h"



@interface APHomeSecondStageVC : UIViewController <APCustomSwitchDelegate,UIPickerViewDelegate,UIPickerViewDataSource,APAppraiseViewDelegate> 
{
    
    UIScrollView *secondStageScrollView;
    UIView *secondStageView;
    UITextField *builtYearTxtField;
    UITextField *vinNoTxtField;
    UITextField *exteriorColourTxtField;
    UITextField *interiorColourTxtField;
    UITextField *engineSizeTxtField;
    UITextField *cylindersTxtField;
    UIView *compliancePickerView;
    UIPickerView *complianceYearPicker;
    UILabel *pickerDisplayLabel;
    UIView *builtYearPickerView;
    UIPickerView *builtYearCustomPicker;
    NSArray *monthsListArray;
    NSMutableArray *yearsListArray;
    NSMutableDictionary *homeSecondVCFormDataDict;
    
 
    BOOL dataCollection2DictionaryStatus;
    
}
@property (nonatomic, retain) IBOutlet UIScrollView *secondStageScrollView;
@property (nonatomic, retain) IBOutlet UIView *secondStageView;
@property (nonatomic, retain) IBOutlet UITextField *builtYearTxtField;
@property (nonatomic, retain) IBOutlet UITextField *vinNoTxtField;
@property (nonatomic, retain) IBOutlet UITextField *exteriorColourTxtField;
@property (nonatomic, retain) IBOutlet UITextField *interiorColourTxtField;
@property (nonatomic, retain) IBOutlet UITextField *engineSizeTxtField;
@property (nonatomic, retain) IBOutlet UITextField *cylindersTxtField;
@property (nonatomic, retain) IBOutlet UIView *compliancePickerView;
@property (nonatomic, retain) IBOutlet UIPickerView *complianceYearPicker;
@property (nonatomic, retain) IBOutlet UILabel *pickerDisplayLabel;
@property (nonatomic, retain) IBOutlet UIView *builtYearPickerView;
@property (nonatomic, retain) IBOutlet UIPickerView *builtYearCustomPicker;


- (IBAction)nextBtnAction:(id)sender;
- (IBAction)backBtnAction:(id)sender;
- (IBAction)complianceYearPickerBtnAction:(id)sender;
- (IBAction)pickerDoneButtonAction:(id)sender;
- (IBAction)builtYearButtonClickedAction:(id)sender;
- (IBAction)builtYearPickerDoneButtonClickedAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender; 

@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,assign) CGFloat extraYPossitionForTextFieldVisibility;
@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;



@end
