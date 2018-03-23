//
//  APHomeViewController.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APHomeViewController.h"
#import "AppRaiseAppDelegate.h"
#import "APHomeSecondStageVC.h"
#import "APConstants.h"
#import "APCommon.h"

@interface APHomeViewController (Private)


- (void)prepareFirstStageView;
- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame;
- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view;
- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation;
- (void)configureForm;
/* - (void)fillFormDictionaryWithSwitchData; */

- (void)collectHomeViewControlleFormData;
- (BOOL)validateHomeViewControllerFormData;
- (void)showFormData;
- (void)setCustomSwitchStatus;
- (void)resignAllFirstResponders;
- (void)loadPickers;
//- (void)scrollToGivenRectWith:(NSInteger)viewTag;
- (void)datePickerResignAction;

@end

@implementation APHomeViewController
@synthesize firstStageScrollView;
@synthesize firstStageView;
@synthesize makeTxtFiled;
@synthesize typeTxtFiled;
@synthesize modelTxtFiled;
@synthesize regNoTxtFiled;
@synthesize expiryDateTxtFiled;

@synthesize odometerReadingTxtFiled;
@synthesize extraHeightIfItIsIPhone5Device;
@synthesize extraHeightForContentSize;
@synthesize bgImageView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [firstStageScrollView release];
    [firstStageView release];
    [makeTxtFiled release];
    [modelTxtFiled release];
    [typeTxtFiled release];
    [regNoTxtFiled release];
    [expiryDateTxtFiled release];
    [odometerReadingTxtFiled release];
    [customDatePicker release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self updateExtrHeightForiPhone5Device];
    
    homeVCFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];
    [[(AppRaiseAppDelegate*)[[UIApplication sharedApplication]delegate] photosCollectionDict] removeAllObjects];
    
    [self configureForm];
    
    /* [self fillFormDictionaryWithSwitchData]; */
    
    [self loadPickers];

    [self setupScrollView];
    [self preSetDatePickerVCFrame];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBgImageForIPhone5];
    [self showFormData];
    
    [self configureForm];
    [self prepareFirstStageView];
    [self setCustomSwitchStatus];
}

- (void)viewDidUnload
{
    [self setFirstStageScrollView:nil];
    [self setFirstStageView:nil];
    [self setMakeTxtFiled:nil];
    [self setModelTxtFiled:nil];
    [self setTypeTxtFiled:nil];
    [self setRegNoTxtFiled:nil];
    [self setExpiryDateTxtFiled:nil];
    [self setOdometerReadingTxtFiled:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupScrollView{

    self.firstStageScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(12, 128, 296, 300 + self.extraHeightIfItIsIPhone5Device)] autorelease];
    
    CGSize contentSize = CGSizeMake(self.firstStageView.frame.size.width, self.firstStageView.frame.size.height+self.extraHeightForContentSize);
    self.firstStageScrollView.contentSize = contentSize;
    
    [self.firstStageScrollView addSubview:self.firstStageView];
    [self.firstStageView setBackgroundColor:[UIColor clearColor]];
    
    [self.firstStageScrollView setDelegate:self];
    [self.view addSubview:self.firstStageScrollView];
}

#pragma mark ......
#pragma mark FORM DATA COLLECTION _ METHODES
#pragma mark ......

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: configureForm.
// Parameters	: 		 
// Return type	: void
// Comments	: 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)configureForm
{
    /*
    [homeVCFormDataDict setObject:@"" forKey:MAKE_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:MODEL_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:REGO_NO_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:TYPE_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:EXPIRY_DATE_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:ODOMETER_READING_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:BUILT_YEAR_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:COMPLIANCE_YEAR_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:VIN_NO_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:EXTERIOR_COLOR_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:INTERIOR_COLOR_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:ENGINE_SIZE_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:CYLINDERS_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:GEARS_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:MECHANICALS_TXTVIEW];
    [homeVCFormDataDict setObject:@"" forKey:PANEL_WORK_TXTVIEW];
    [homeVCFormDataDict setObject:@"" forKey:APPRAISAL_DATE_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:APPRAISED_BY_TXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:APPRAISED_SCORE_FIELD];
    [homeVCFormDataDict setObject:@"" forKey:OTHER_INFO_TXTVIEW];
    [homeVCFormDataDict setObject:@"" forKey:LAST_SERVICE_DATE_TXTFIELD];
    
    // Finance Stage
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_DATE_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_OWNERS_NAME_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_PHONE_NO_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_EMAIL_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_PAYOUT_TEXTFIELD];
    [homeVCFormDataDict setObject:@"" forKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];

     */

    // resetting all the form values
    [[APAppController sharedAppController] resetAllTheFormValues];

}

- (void)resignAllFirstResponders
{
    [self.makeTxtFiled resignFirstResponder];
    [self.modelTxtFiled resignFirstResponder];
    [self.regNoTxtFiled resignFirstResponder];
    [self.typeTxtFiled resignFirstResponder];
    [self.expiryDateTxtFiled resignFirstResponder];
    [self.odometerReadingTxtFiled resignFirstResponder];
    
    [self settingScrollviewFrame:YES withAnimation:YES];
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: collectRigCompressorFormDat
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectHomeViewControlleFormData
{
    if ([self validateHomeViewControllerFormData])
    {
        [homeVCFormDataDict setObject:self.makeTxtFiled.text forKey:MAKE_TXTFIELD];
        [homeVCFormDataDict setObject:self.modelTxtFiled.text forKey:MODEL_TXTFIELD];
        [homeVCFormDataDict setObject:self.regNoTxtFiled.text forKey:REGO_NO_TXTFIELD];
        [homeVCFormDataDict setObject:self.typeTxtFiled.text forKey:TYPE_TXTFIELD];
        [homeVCFormDataDict setObject:self.expiryDateTxtFiled.text forKey:EXPIRY_DATE_TXTFIELD];
        [homeVCFormDataDict setObject:self.odometerReadingTxtFiled.text forKey:ODOMETER_READING_TXTFIELD];
    }
}

- (void)showFormData
{
    self.makeTxtFiled.text  = [homeVCFormDataDict objectForKey:MAKE_TXTFIELD];
    self.modelTxtFiled.text = [homeVCFormDataDict objectForKey:MODEL_TXTFIELD];
    self.regNoTxtFiled.text = [homeVCFormDataDict objectForKey:REGO_NO_TXTFIELD];
    self.typeTxtFiled.text  = [homeVCFormDataDict objectForKey:TYPE_TXTFIELD];
    self.expiryDateTxtFiled.text = [homeVCFormDataDict objectForKey:EXPIRY_DATE_TXTFIELD];
    self.odometerReadingTxtFiled.text = [homeVCFormDataDict objectForKey:ODOMETER_READING_TXTFIELD];
}


#pragma mark ......
#pragma mark FORM DATA VALIDATION _ METHODES
#pragma mark ......

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: validateRigCompressorFormData
// Parameters	: 
// Return type	: BOOL
// Comments     : 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)validateHomeViewControllerFormData
{
    BOOL isValid = YES;
    
    //TODO: impliment validation
    if (self.makeTxtFiled.text == nil || [self.makeTxtFiled.text isEqualToString:@""] || [[self.makeTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify make."];
        return isValid;
    }
    if (self.modelTxtFiled.text == nil || [self.modelTxtFiled.text isEqualToString:@""] || [[self.modelTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify model."];
        return isValid;
        
    }
    if (self.regNoTxtFiled.text == nil || [self.regNoTxtFiled.text isEqualToString:@""] || [[self.regNoTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Rego Number."];
        return isValid;
    }
    if (self.typeTxtFiled.text == nil || [self.typeTxtFiled.text isEqualToString:@""] || [[self.typeTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify type."];
        return isValid;
    }
    if (self.expiryDateTxtFiled.text == nil || [self.expiryDateTxtFiled.text isEqualToString:@""] || [[self.expiryDateTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify expiryDate"];
        return isValid;
    }
    if (self.odometerReadingTxtFiled.text == nil || [self.odometerReadingTxtFiled.text isEqualToString:@""] || [[self.odometerReadingTxtFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify odometer Reading."];
        return isValid;
    }
    return isValid;
}

/*
- (void)fillFormDictionaryWithSwitchData
{
    for (int i = 1; i < 44; i++)
    {
        [ homeVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(NO) forKey:SWITCH_DICTIONARY_KEY(i)];
    }
    
    for (int j =1; j < 10; j++) 
    {
        [ homeVCFormDataDict setObject:FILTER_DICTIONARY_VALUE(YES) forKey:FILTER_DICTIONARY_KEY(j)];
    }
}

*/


- (IBAction)nextBtnAction:(id)sender 
{
    [self resignAllFirstResponders];
    
    if ([self validateHomeViewControllerFormData] == YES) 
    {
        [self collectHomeViewControlleFormData ];
        
        APHomeSecondStageVC *secondStageVc = [[APHomeSecondStageVC alloc] initWithNibName:@"APHomeSecondStageVC" bundle:nil];
        [self.navigationController pushViewController:secondStageVc animated:YES];
        [secondStageVc  release];
        

    }
}

- (void)loadPickers
{
    customDatePicker = [[PSDatePickerViewController alloc]initWithNibName:@"PSDatePickerViewController" bundle:nil];
    customDatePicker.delegate = self;
    customDatePicker.view.frame = CGRectMake(0, 480, 320, 260);
    [self.view addSubview:customDatePicker.view];
}

- (IBAction)expiryDateButtonClickedAction:(id)sender 
{
    [self resignAllFirstResponders];
    
    [self.view bringSubviewToFront:customDatePicker.view];
    
    [self settingScrollviewFrame:NO withAnimation:NO];
    
    //[self scrollToGivenRectWith:105];
    [self scrollRectToVisible:self.expiryDateTxtFiled.frame];
    
    [self animationForViewToVisable:CGRectMake(0, 180+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
}

- (void)onDateDoneButtonClicked:(NSDate*)date
{
    expiryDateTxtFiled.text = [APCommon formattedStringFromDate:date];
    [homeVCFormDataDict setObject:date forKey:EXPIRY_DATE_TXTFIELD];
    [self settingScrollviewFrame:YES withAnimation:YES];
    [self datePickerResignAction];
}

- (void)datePickerResignAction
{
    [self animationForViewToVisable:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
}

- (void)prepareFirstStageView
{
    // Reading last updated final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:0];
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];
    
    int switchTag = globalSwitchTagValue;
    for (NSString *yValue in kStageoneSwitchYValue) 
    {
        for (NSString *xValue in kStageoneSwitchXValue) 
        {
            [self prepareCustomSwith:++switchTag withSwitchValue:NO andFrame:CGRectMake([xValue intValue], [yValue intValue], 95, 33)];
        }
     }
    [self prepareCustomSwith:++switchTag withSwitchValue:NO andFrame:CGRectMake(30, 595, 95, 33)];
    [self prepareCustomSwith:++switchTag withSwitchValue:NO andFrame:CGRectMake(175, 595, 95, 33)];

    // Updating final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:switchTag];

}

- (void)setCustomSwitchStatus
{
    
    // Reading last updated final switch tag value
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];

    for (int i = 1; i < globalSwitchTagValue; i++)
    {
        NSLog(@"%d", i);
        UIView *viewObj = [self.view viewWithTag:i];
        if ([viewObj isKindOfClass:[APCustomSwitch class]]) 
        {
            NSString* statusStr = [homeVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(i)];
            [(APCustomSwitch*)viewObj setSwitchStatus:[statusStr boolValue]];

            /*
            NSString *keyForStage = SWITCH_STAGE_WISE_KEY(1, i);
            NSString* statusStr = [homeVCFormDataDict objectForKey:keyForStage];
            [(APCustomSwitch*)viewObj setSwitchStatus:[statusStr boolValue]];
            */

        }
    }
}
- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame
{
    
    id anyView = [self.view viewWithTag:switchTag];
    if ([anyView isKindOfClass:[APCustomSwitch class]]) {
        // Dont do any thing
        APCustomSwitch *cswitch = (APCustomSwitch*)anyView;
        [cswitch setSwitchStatus:NO];
    } else {
    
        NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
        APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
        cSwitch.frame           = theFrame;
        cSwitch.tag             = switchTag;
        
        NSString *statusStr = [homeVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)];
        
        /*
        NSString *keyForStage = SWITCH_STAGE_WISE_KEY(1, switchTag);
        NSString *statusStr = [homeVCFormDataDict objectForKey:keyForStage];
         */
        

        [cSwitch setSwitchStatus:[statusStr boolValue]];
        
        cSwitch.delegate        = self;
        [self.firstStageView addSubview:cSwitch];
        
    }
}

- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag
{
    NSLog(@"switchStatus %d,switchTag %d",switchStatus,switchTag);
    [self datePickerResignAction];
    [self resignAllFirstResponders];
    
    [homeVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(switchStatus) forKey:SWITCH_DICTIONARY_KEY(switchTag)];
}

- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [view setFrame:rectValue];
    [UIView commitAnimations];
}

- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation
{
    if (isFull) 
    {
        self.firstStageScrollView.frame = CGRectMake(12, 128, 296, 300+ self.extraHeightIfItIsIPhone5Device);
        //[firstStageScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 100) animated:isAnimation];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.firstStageScrollView.frame = CGRectMake(12, 128, 296, 120+ self.extraHeightIfItIsIPhone5Device);
        [UIView commitAnimations];
    }
}

/*
- (void)scrollToGivenRectWith:(NSInteger)viewTag
{
    
    CGRect rect = CGRectZero;
    switch (viewTag) 
    {
        case 101:
            rect = CGRectMake(0, 0, 320, 55);
            break;
        case 102:
            rect = CGRectMake(0, 60, 320, 55);
            break;
        case 103:
            rect = CGRectMake(0, 120, 320, 55);
            break;
        case 104:
            rect = CGRectMake(0, 580 , 320, 55);
            break;
        case 105:
            rect = CGRectMake(0, 740+50 , 320, 55);
            break;
        case 106:
            rect = CGRectMake(0, 720 , 320, 55);
            break;
    }
    
    [self.firstStageScrollView scrollRectToVisible:rect animated:YES];

 
//    if (![self isThisIPhone5Device]) {
//        [self.firstStageScrollView scrollRectToVisible:rect animated:YES];
//    } else {
//    
//        //[self.firstStageScrollView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y+self.extraYPossitionForTextFieldVisibility)];
//        CGPoint offset = CGPointMake(rect.origin.x, rect.origin.y+self.extraYPossitionForTextFieldVisibility);
//        [self moveScrollViewToOffset:offset withAnimation:YES];
//    }
 
 
}
*/

- (void)scrollRectToVisible:(CGRect)targetRect{

    
    [self.firstStageScrollView scrollRectToVisible:targetRect animated:YES];
    
    
}


#pragma mark .........
#pragma mark UITextField Delegate
#pragma mark .........

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       
{
    [self datePickerResignAction];
    [self settingScrollviewFrame:NO withAnimation:NO];
    //[self scrollToGivenRectWith:textField.tag];
    
    [self scrollRectToVisible:textField.frame];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    BOOL pressedReturnKey	= YES;
    
    BOOL returnValue	= YES;
    
	if(textField == makeTxtFiled)
	{
		[makeTxtFiled resignFirstResponder];
		[modelTxtFiled becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == modelTxtFiled)
	{
		[modelTxtFiled resignFirstResponder];
		[typeTxtFiled becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == typeTxtFiled)
	{
		[typeTxtFiled resignFirstResponder];
        pressedReturnKey = YES;
		returnValue	= YES;
	}
    
    if(textField == regNoTxtFiled)
	{
		[regNoTxtFiled resignFirstResponder];
        [expiryDateTxtFiled becomeFirstResponder];
        pressedReturnKey = YES;
		returnValue	= YES;
	}
    else if(textField == expiryDateTxtFiled)
	{
		[expiryDateTxtFiled resignFirstResponder];
        [odometerReadingTxtFiled becomeFirstResponder];
        pressedReturnKey = NO;
		returnValue	= NO;
	}else if(textField == odometerReadingTxtFiled)
	{
		[odometerReadingTxtFiled resignFirstResponder];
        pressedReturnKey = YES;
		returnValue	= YES;
	}
    if (pressedReturnKey) [self settingScrollviewFrame:returnValue withAnimation:pressedReturnKey];
    return returnValue;

}

- (IBAction)appRaiseButtonAction:(id)sender 
{
    APAppraiseView *apRaise = (APAppraiseView*)[[[NSBundle mainBundle] loadNibNamed:@"APAppraiseView" owner:self options:nil] lastObject];
    apRaise.delgate = self;
    [apRaise adjustFrameAsPerDeviceScreenSize];
    [self.view addSubview:apRaise];
}

- (void)closeBtnActionDelegate:(APAppraiseView*)appView
{
    [appView removeFromSuperview];
}

- (BOOL)isThisIPhone5Device{

    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}

- (void)updateExtrHeightForiPhone5Device{
    
    if ([self isThisIPhone5Device]) {
        self.extraHeightIfItIsIPhone5Device = 100;
        self.extraYPossitionForTextFieldVisibility = 20;
        self.extraHeightForContentSize = 36;
    } else {
        self.extraHeightIfItIsIPhone5Device = 0;
        self.extraYPossitionForTextFieldVisibility = 0;
        self.extraHeightForContentSize = 0;


    }
    
}

- (void)preSetDatePickerVCFrame{

    [customDatePicker.view setFrame:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260)];
}

- (void)moveScrollViewToOffset:(CGPoint)offsetPoint withAnimation:(BOOL)animation{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.firstStageScrollView setContentOffset:offsetPoint];
    [UIView commitAnimations];
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}


@end
