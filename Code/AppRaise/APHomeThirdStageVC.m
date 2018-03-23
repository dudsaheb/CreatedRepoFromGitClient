//
//  APHomeThirdStageVC.m
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APHomeThirdStageVC.h"
#import "AppRaiseAppDelegate.h"
#import "APConstants.h"
#import "APCommon.h"
#import "APHomeFourthStageVC.h"
#import "APHomeFinanceStageViewController.h"

@interface APHomeThirdStageVC (Private)

- (void)prepareThirdStageView;
- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame;
- (void)prepareFilterSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame;
- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view;
- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation;
- (void)scrollToGivenRectWith:(NSInteger)viewTag;
- (void)configureForm;
- (void)showFormData;
- (void)fillFormDictionaryWithSwitchData;
- (void)collectHomeThirdViewControlleFormData;
- (BOOL)validateHomeThirdViewControllerFormData;
- (void)resignAllFirstResponders;

@end


@implementation APHomeThirdStageVC
@synthesize stageThreeScrollView;
@synthesize stageThreeView;
@synthesize gearsTxtField;

@synthesize extraHeightIfItIsIPhone5Device;
@synthesize extraYPossitionForTextFieldVisibility;
@synthesize bgImageView;
@synthesize customDatePicker;
@synthesize lastServiceDateButton;
@synthesize lastServiceTextField;
@synthesize financeStageViewController;
@synthesize lastServiceDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        dataCollection2DictionaryStatus = NO;
    }
    return self;
}

- (void)dealloc
{
    [stageThreeScrollView release];
    [stageThreeView release];
    [gearsTxtField release];
    self.financeStageViewController = nil;
    
    [super dealloc];
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
    self.gearsTxtField.text  = nil;
    self.lastServiceTextField.text = nil;
}

- (void)showFormData
{
    self.gearsTxtField.text  = [homeThirdVCFormDataDict objectForKey:GEARS_TXTFIELD];
    
    self.lastServiceDate = [homeThirdVCFormDataDict objectForKey:LAST_SERVICE_DATE_TXTFIELD];
    self.lastServiceTextField.text = [APCommon formattedStringFromDate:self.lastServiceDate];
    
    for (int i = 22; i < 35; i++) 
    {
        //[ homeSecondVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(i)];
    }    
    for (int j =1; j < 10; j++) 
    {
        //[ homeThirdVCFormDataDict objectForKey:FILTER_DICTIONARY_KEY(j)];
    }
}

- (void)resignAllFirstResponders
{
    [self.gearsTxtField resignFirstResponder];
    [self settingScrollviewFrame:YES withAnimation:YES];

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: collectRigCompressorFormDat
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectHomeThirdViewControlleFormData
{
    if ([self validateHomeThirdViewControllerFormData])
    {
        [homeThirdVCFormDataDict setObject:self.gearsTxtField.text forKey:GEARS_TXTFIELD];
        
        [homeThirdVCFormDataDict setObject:self.lastServiceDate forKey:LAST_SERVICE_DATE_TXTFIELD];

    }
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
- (BOOL)validateHomeThirdViewControllerFormData
{
    BOOL isValid = YES;
    
    if (self.gearsTxtField.text == nil || [self.gearsTxtField.text isEqualToString:@""] || [[self.gearsTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Gear."];
        return isValid;
    }
    
    if (self.lastServiceTextField.text == nil || [self.lastServiceTextField.text isEqualToString:@""] || [[self.lastServiceTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Last Service Date."];
        return isValid;
    }
    
    return isValid;
}

- (void)fillFormDictionaryWithSwitchData
{
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    homeThirdVCFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];

    [self configureForm];
    [self prepareThirdStageView];
    [self fillFormDictionaryWithSwitchData];
    
    [self updateExtrHeightForiPhone5Device];
    [self loadPickers];


    //self.stageThreeScrollView.contentSize = self.stageThreeView.frame.size;
    //[self.stageThreeScrollView addSubview:self.stageThreeView];
    
    [self setupScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateBgImageForIPhone5];
    [self showFormData];
}

- (void)viewDidUnload
{
    [self setStageThreeScrollView:nil];
    [self setStageThreeView:nil];
    [self setGearsTxtField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setupScrollView{
    
    self.stageThreeScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(7, 70, 306, 335 + self.extraHeightIfItIsIPhone5Device)] autorelease];
    
    self.stageThreeScrollView.contentSize = self.stageThreeView.frame.size;
    [self.stageThreeScrollView addSubview:self.stageThreeView];
    
    [self.stageThreeView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.stageThreeScrollView];
}

- (void)prepareThirdStageView
{
    // Reading last updated final switch tag value
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];
    
    int switchTag = globalSwitchTagValue;
    for (NSString *yValue in kStageThirdSwitchYValue) 
    {
        if (switchTag < 34)
        {
            [self prepareCustomSwith:++switchTag withSwitchValue:YES andFrame:CGRectMake(kStageThirdSwitchX1Value, [yValue intValue], 95, 33)];

        }
        else
        {
            [self prepareCustomSwith:++switchTag withSwitchValue:YES andFrame:CGRectMake(kStageThirdSwitchX2Value, [yValue intValue], 95, 33)];
        }
    }
    
    // Updating final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:switchTag];
    
    
    
    int fSwitchTag = 0;

    for (NSString *yValue in kStageThirdFilterYValue) 
    {
            [self prepareFilterSwith:++fSwitchTag withSwitchValue:YES andFrame:CGRectMake(kStageThirdFilterXValue, [yValue intValue], 28, 28)];
            
    }
    
    

}

- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame
{
    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
    APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
    cSwitch.frame           = theFrame;
    cSwitch.tag             = switchTag;
    [cSwitch setSwitchStatus:[[homeThirdVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)] boolValue]];
    cSwitch.delegate        = self;
    [self.stageThreeView addSubview:cSwitch];
}

- (void)prepareFilterSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame
{
    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APFilterSwitch" owner:self options:nil];
    APFilterSwitch *fSwitch = (APFilterSwitch*)[nibViews lastObject];
    fSwitch.frame           = theFrame;
    fSwitch.tag             = switchTag;
    [fSwitch setFilterBtnStatus:[[homeThirdVCFormDataDict objectForKey:FILTER_DICTIONARY_KEY(switchTag)] boolValue]];
    fSwitch.delegate        = self;
    [self.stageThreeView addSubview:fSwitch];
}

- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag
{
    [self resignAllFirstResponders];
    NSLog(@"switchStatus %d,switchTag %d",switchStatus,switchTag);
    [homeThirdVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(switchStatus) forKey:SWITCH_DICTIONARY_KEY(switchTag)];

}

- (void)filterButtonClicked:(BOOL)btnStatus withSwitchTag:(NSInteger)switchTag
{
    [self resignAllFirstResponders];
    NSLog(@"switchStatus %d,switchTag %d",btnStatus,switchTag);
    [homeThirdVCFormDataDict setObject:FILTER_DICTIONARY_VALUE(btnStatus) forKey:FILTER_DICTIONARY_KEY(switchTag)];
    if (btnStatus) 
    {
        [[self.view viewWithTag:25+switchTag] setUserInteractionEnabled:YES];
    }
    else
    {
        [[self.view viewWithTag:25+switchTag] setUserInteractionEnabled:NO];
        [(APCustomSwitch*)[self.view viewWithTag:25+switchTag] setSwitchStatus:NO];
        [homeThirdVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(NO) forKey:SWITCH_DICTIONARY_KEY(switchTag + 25)];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)nextBtnAction:(id)sender 
{
    [self resignAllFirstResponders];

   if ([self validateHomeThirdViewControllerFormData] == YES)
    {
        /*
        APHomeFourthStageVC *fourthStageVc = [[APHomeFourthStageVC alloc] initWithNibName:@"APHomeFourthStageVC" bundle:nil];
        [self collectHomeThirdViewControlleFormData];
        [self.navigationController pushViewController:fourthStageVc animated:YES];
        [fourthStageVc  release];
         */
        
        self.financeStageViewController = [[APHomeFinanceStageViewController alloc] initWithNibName:@"APHomeFinanceStageViewController" bundle:nil];
        
        [self.navigationController pushViewController:self.financeStageViewController animated:YES];
        [self collectHomeThirdViewControlleFormData];
        [self.financeStageViewController  release];
        self.financeStageViewController = nil;
        
    }

}

- (IBAction)backBtnAction:(id)sender
{
    [self resignAllFirstResponders];

    [self collectHomeThirdViewControlleFormData];
    [self.navigationController popViewControllerAnimated:YES];
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
        stageThreeScrollView.frame = CGRectMake(7, 70, 306, 335+ self.extraHeightIfItIsIPhone5Device);
        //[secondStageScrollView scrollRectToVisible:CGRectMake(0, 0, 320, 100) animated:isAnimation];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        stageThreeScrollView.frame = CGRectMake(7, 70, 306,180+ self.extraHeightIfItIsIPhone5Device);
        [UIView commitAnimations];
    }
}

/*
- (void)scrollToGivenRectWith:(NSInteger)viewTag
{
    if (viewTag == 11)
    {
        [stageThreeScrollView scrollRectToVisible:CGRectMake(7, 222, 306, 55) animated:YES];
    }
    else
    {
        [stageThreeScrollView scrollRectToVisible:CGRectMake(7, 890, 306, 55) animated:YES];
    }
    
}
 
 */

#pragma mark .........
#pragma mark UITextField Delegate
#pragma mark .........

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       
{
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
    [self settingScrollviewFrame:YES withAnimation:YES];
    [textField resignFirstResponder];
    return YES;
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
    } else {
        self.extraHeightIfItIsIPhone5Device = 0;
        self.extraYPossitionForTextFieldVisibility = 0;
        
    }
    
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}




- (void)loadPickers
{
    self.customDatePicker = [[PSDatePickerViewController alloc]initWithNibName:@"PSDatePickerViewController" bundle:nil];
    self.customDatePicker.delegate = self;
    self.customDatePicker.view.frame = CGRectMake(0, 480+self.extraHeightIfItIsIPhone5Device, 320, 260);
    [self.view addSubview:self.customDatePicker.view];
}

- (IBAction)onLastServiceDateButtonAction:(id)sender
{
    [self resignAllFirstResponders];
    
    [self.view bringSubviewToFront:customDatePicker.view];
    
    [self settingScrollviewFrame:NO withAnimation:NO];
    [self scrollRectToVisible:self.lastServiceTextField.frame];
    [self animationForViewToVisable:CGRectMake(0, 180+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
}

- (void)onDateDoneButtonClicked:(NSDate*)date
{
    self.lastServiceDate = date;
    
    self.lastServiceTextField.text = [APCommon formattedStringFromDate:date];
    [homeThirdVCFormDataDict setObject:date forKey:LAST_SERVICE_DATE_TXTFIELD];
    [self datePickerResignAction];
    [self settingScrollviewFrame:YES withAnimation:NO];

}

- (void)datePickerResignAction
{
    [self animationForViewToVisable:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
}


- (void)scrollRectToVisible:(CGRect)targetRect{
    
    [self.stageThreeScrollView scrollRectToVisible:targetRect animated:YES];
    
}


@end
