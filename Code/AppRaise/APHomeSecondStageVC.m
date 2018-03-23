//
//  APHomeSecondStageVC.m
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APHomeSecondStageVC.h"
#import "AppRaiseAppDelegate.h"
#import "APConstants.h"
#import "APCommon.h"
#import "APHomeThirdStageVC.h"

@interface APHomeSecondStageVC (Private)

- (void)prepareSecondStageView;
- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame;
- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view;
- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation;

//- (void)scrollToGivenRectWith:(NSInteger)viewTag;

- (void)initalizeDataObjecs;
- (void)compliancePickerResignAction;
- (void)configureForm;
- (void)fillFormDictionaryWithSwitchData;
- (void)collectHomeSecondViewControlleFormData;
- (BOOL)validateHomeSecondViewControllerFormData;
- (void)resignAllFirstResponders;
- (void)bultYearPickerResignAction;


@end


@implementation APHomeSecondStageVC
@synthesize secondStageScrollView;
@synthesize secondStageView;
@synthesize builtYearTxtField;
@synthesize vinNoTxtField;
@synthesize exteriorColourTxtField;
@synthesize interiorColourTxtField;
@synthesize engineSizeTxtField;
@synthesize cylindersTxtField;
@synthesize compliancePickerView;
@synthesize complianceYearPicker;
@synthesize pickerDisplayLabel;
@synthesize builtYearPickerView;
@synthesize builtYearCustomPicker;

@synthesize extraHeightIfItIsIPhone5Device;
@synthesize extraYPossitionForTextFieldVisibility;
@synthesize bgImageView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        dataCollection2DictionaryStatus = NO;
    }
    return self;
}

- (void)dealloc
{
    [secondStageScrollView release];
    [secondStageView release];
    [vinNoTxtField release];
    [exteriorColourTxtField release];
    [interiorColourTxtField release];
    [engineSizeTxtField release];
    [cylindersTxtField release];
    [builtYearTxtField release];
    [compliancePickerView release];
    [complianceYearPicker release];
    [pickerDisplayLabel release];
    [builtYearPickerView release];
    [builtYearCustomPicker release];
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
    self.builtYearTxtField.text  = nil;
    self.pickerDisplayLabel.text = nil;
    self.vinNoTxtField.text = nil;
    self.exteriorColourTxtField.text  = nil;
    self.interiorColourTxtField.text = nil;
    self.engineSizeTxtField.text = nil;
    self.cylindersTxtField.text = nil;
}

- (void)resignAllFirstResponders
{
    [self.builtYearTxtField resignFirstResponder];
    [self.vinNoTxtField resignFirstResponder];
    [self.exteriorColourTxtField resignFirstResponder];
    [self.interiorColourTxtField resignFirstResponder];
    [self.engineSizeTxtField resignFirstResponder];
    [self.cylindersTxtField resignFirstResponder];
    [self settingScrollviewFrame:YES withAnimation:YES];
}

- (void)showFormData
{
    self.builtYearTxtField.text  = [homeSecondVCFormDataDict objectForKey:BUILT_YEAR_TXTFIELD];
    self.pickerDisplayLabel.text = [homeSecondVCFormDataDict objectForKey:COMPLIANCE_YEAR_TXTFIELD];
    self.vinNoTxtField.text = [homeSecondVCFormDataDict objectForKey:VIN_NO_TXTFIELD];
    self.exteriorColourTxtField.text  = [homeSecondVCFormDataDict objectForKey:EXTERIOR_COLOR_TXTFIELD];
    self.interiorColourTxtField.text = [homeSecondVCFormDataDict objectForKey:INTERIOR_COLOR_TXTFIELD];
    self.engineSizeTxtField.text = [homeSecondVCFormDataDict objectForKey:ENGINE_SIZE_TXTFIELD];
    self.cylindersTxtField.text = [homeSecondVCFormDataDict objectForKey:CYLINDERS_TXTFIELD];
    
    for (int i = 16; i < 22; i++) 
    {
        //[ homeSecondVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(i)];
    }    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: collectRigCompressorFormDat
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectHomeSecondViewControlleFormData
{
    if ([self validateHomeSecondViewControllerFormData])
    {
        [homeSecondVCFormDataDict setObject:self.builtYearTxtField.text forKey:BUILT_YEAR_TXTFIELD];
        [homeSecondVCFormDataDict setObject:self.pickerDisplayLabel.text forKey:COMPLIANCE_YEAR_TXTFIELD];
        
        /*
        [homeSecondVCFormDataDict setObject:self.vinNoTxtField.text forKey:VIN_NO_TXTFIELD];
        */
        
        [homeSecondVCFormDataDict setObject:self.exteriorColourTxtField.text forKey:EXTERIOR_COLOR_TXTFIELD];
        [homeSecondVCFormDataDict setObject:self.interiorColourTxtField.text forKey:INTERIOR_COLOR_TXTFIELD];
        [homeSecondVCFormDataDict setObject:self.engineSizeTxtField.text forKey:ENGINE_SIZE_TXTFIELD];
        [homeSecondVCFormDataDict setObject:self.cylindersTxtField.text forKey:CYLINDERS_TXTFIELD];
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
- (BOOL)validateHomeSecondViewControllerFormData
{
    BOOL isValid = YES;
    
    //TODO: impliment validation
    if (self.builtYearTxtField.text == nil || [self.builtYearTxtField.text isEqualToString:@""] || [[self.builtYearTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) 
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Year."];
        return isValid;
    }
    if (self.pickerDisplayLabel.text == nil || [self.pickerDisplayLabel.text isEqualToString:@""] || [[self.pickerDisplayLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Month & Year."];
        return isValid;
        
    }
    
    /*
    if (self.vinNoTxtField.text == nil || [self.vinNoTxtField.text isEqualToString:@""] || [[self.vinNoTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Vin Number."];
        return isValid;
    }
    
    */
    
    
    if (self.exteriorColourTxtField.text == nil || [self.exteriorColourTxtField.text isEqualToString:@""] || [[self.exteriorColourTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify exterior color."];
        return isValid;
    }
    if (self.interiorColourTxtField.text == nil || [self.interiorColourTxtField.text isEqualToString:@""] || [[self.interiorColourTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify interior color"];
        return isValid;
    }
    if (self.engineSizeTxtField.text == nil || [self.engineSizeTxtField.text isEqualToString:@""] || [[self.engineSizeTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify engine size."];
        return isValid;
    }
    if (self.cylindersTxtField  .text == nil || [self.cylindersTxtField.text isEqualToString:@""] || [[self.cylindersTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify cylinders."];
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
    homeSecondVCFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];
    
    [self configureForm];
    [self prepareSecondStageView];
    [self fillFormDictionaryWithSwitchData];
    [self initalizeDataObjecs];
    
    //self.secondStageScrollView.contentSize = self.secondStageView.frame.size;
    //[self.secondStageScrollView addSubview:self.secondStageView];

    self.compliancePickerView.frame = CGRectMake(0, 500, 320, 237);
    self.builtYearPickerView.frame = CGRectMake(0, 500, 320, 237);

    [self.view addSubview:self.builtYearPickerView];
    [self.view addSubview:self.compliancePickerView];
    
    [self updateExtrHeightForiPhone5Device];
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
}
- (void)viewDidUnload
{
    [self setSecondStageScrollView:nil];
    [self setSecondStageView:nil];
    [self setVinNoTxtField:nil];
    [self setExteriorColourTxtField:nil];
    [self setInteriorColourTxtField:nil];
    [self setEngineSizeTxtField:nil];
    [self setCylindersTxtField:nil];
    [self setBuiltYearTxtField:nil];
    [self setCompliancePickerView:nil];
    [self setComplianceYearPicker:nil];
    [self setPickerDisplayLabel:nil];
    [self setBuiltYearPickerView:nil];
    [self setBuiltYearCustomPicker:nil];
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
    
    self.secondStageScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(12, 70, 296, 345 + self.extraHeightIfItIsIPhone5Device)] autorelease];
    
    self.secondStageScrollView.contentSize = self.secondStageView.frame.size;
    
    [self.secondStageScrollView addSubview:self.secondStageView];
    [self.secondStageView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.secondStageScrollView];
}

- (void)initalizeDataObjecs
{
    // Custom initialization
    monthsListArray = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil ];
    yearsListArray = [[NSMutableArray alloc] init];
    for (int year = 1975; year <=2300 ; year++) 
    {
        [yearsListArray addObject:[NSString stringWithFormat:@"%d",year]];
    }
}
- (IBAction)nextBtnAction:(id)sender
{
    [self resignAllFirstResponders];
    [self compliancePickerResignAction];

    if ([self validateHomeSecondViewControllerFormData] == YES) 
    {
        APHomeThirdStageVC *thirdStageVc = [[APHomeThirdStageVC alloc] initWithNibName:@"APHomeThirdStageVC" bundle:nil];
        [self collectHomeSecondViewControlleFormData];
        [self.navigationController pushViewController:thirdStageVc animated:YES];
        [thirdStageVc  release];
        
        
        
    }
}

- (IBAction)backBtnAction:(id)sender 
{
    [self resignAllFirstResponders];
    [self compliancePickerResignAction];

    [self collectHomeSecondViewControlleFormData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)builtYearButtonClickedAction:(id)sender 
{
    CGRect pickerRect = CGRectMake(0, 180+ self.extraHeightIfItIsIPhone5Device, 320, 260);
    
    [self.view bringSubviewToFront:self.builtYearPickerView];
    [self resignAllFirstResponders];
    [self compliancePickerResignAction];
    
    [self settingScrollviewFrame:NO withAnimation:NO];
    
    //[self scrollToGivenRectWith:11];
    [self scrollRectToVisible:self.builtYearTxtField.frame];
    
    [self animationForViewToVisable:pickerRect withView:self.builtYearPickerView];
    
}

- (IBAction)complianceYearPickerBtnAction:(id)sender 
{
    CGRect pickerRect = CGRectMake(0, 180+ self.extraHeightIfItIsIPhone5Device, 320, 260);
    
    [self.view bringSubviewToFront:self.compliancePickerView];
    [self resignAllFirstResponders];
    [self bultYearPickerResignAction];
    
    [self settingScrollviewFrame:NO withAnimation:NO];
    
    //[self scrollToGivenRectWith:10];
    [self scrollRectToVisible:self.pickerDisplayLabel.frame];
    
    [self animationForViewToVisable:pickerRect withView:self.compliancePickerView];
}

- (void)prepareSecondStageView
{
    // Reading last updated final switch tag value
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];

    int switchTag = globalSwitchTagValue;
    for (NSString *yValue in kStageTwoSwitchYValue) 
    {
            [self prepareCustomSwith:++switchTag withSwitchValue:YES andFrame:CGRectMake(kStageTwoSwitchXValue, [yValue intValue], 95, 33)];
    }
    
    // Updating final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:switchTag];
}

- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame
{
    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
    APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
    cSwitch.frame           = theFrame;
    cSwitch.tag             = switchTag;
    [cSwitch setSwitchStatus:[[homeSecondVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)] boolValue]];
    cSwitch.delegate        = self;
    [self.secondStageView addSubview:cSwitch];
}

- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag
{
    NSLog(@"switchStatus %d,switchTag %d",switchStatus,switchTag);

    [self resignAllFirstResponders];
    [self bultYearPickerResignAction];
    [self compliancePickerResignAction];
    [homeSecondVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(switchStatus) forKey:SWITCH_DICTIONARY_KEY(switchTag)];

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
    //[secondStageScrollView setBackgroundColor:[UIColor redColor]];
    
    if (isFull) 
    {
        secondStageScrollView.frame = CGRectMake(12, 70, 296, 335+ self.extraHeightIfItIsIPhone5Device);
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        secondStageScrollView.frame = CGRectMake(12, 70, 296, 180+ self.extraHeightIfItIsIPhone5Device);
        [UIView commitAnimations];
    }
}

/*
- (void)scrollToGivenRectWith:(NSInteger)viewTag
{
    CGRect rect = CGRectZero;
    switch (viewTag) 
    {
        case 10:
            rect = CGRectMake(0, 180, 320, 55);
            break;
        case 11:
            rect = CGRectMake(0, 0, 320, 55);
            break;
        case 12:
            rect = CGRectMake(0, 133, 320, 55);
            break;
        case 13:
            rect = CGRectMake(0, 195, 320, 55);
            break;
        case 14:
            rect = CGRectMake(0, 260, 320, 55);
            break;
        case 15:
            rect = CGRectMake(0, 463, 320, 55);
            break;
        case 16:
            rect = CGRectMake(0, 520, 320, 55);
            break;
    }
    
    [secondStageScrollView scrollRectToVisible:rect animated:YES];
}
 
 */

#pragma mark .........
#pragma mark UITextField Delegate
#pragma mark .........

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       
{
    [self compliancePickerResignAction];
    [self bultYearPickerResignAction];
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
    
    if (textField == builtYearTxtField)
    {
        [builtYearTxtField resignFirstResponder];
    }
    
	if(textField == vinNoTxtField)
	{
		[vinNoTxtField resignFirstResponder];
		[exteriorColourTxtField becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == exteriorColourTxtField)
	{
		[exteriorColourTxtField resignFirstResponder];
		[interiorColourTxtField becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == interiorColourTxtField)
	{
		[interiorColourTxtField resignFirstResponder];
        pressedReturnKey = YES;     returnValue	= YES;
	}
    
    if(textField == engineSizeTxtField)
	{
		[engineSizeTxtField resignFirstResponder];
        [cylindersTxtField becomeFirstResponder];
        pressedReturnKey = NO;  returnValue	= NO;
	}
    else if(textField == cylindersTxtField)
	{
		[cylindersTxtField resignFirstResponder];
        pressedReturnKey = YES;     returnValue	= YES;
	}
    if (pressedReturnKey) [self settingScrollviewFrame:returnValue withAnimation:pressedReturnKey];
    return returnValue;
}



#pragma mark ......
#pragma mark PICKER DATA SOURCE & DELEGATE _ METHODES
#pragma mark ......

///////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: locationPicker Delegate
// Parameters	: 		 
// Return type	: 
// Comments     : 
////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)pickerDoneButtonAction:(id)sender 
{    
    NSString *monthString = [NSString stringWithFormat:@"%@",[monthsListArray objectAtIndex:[complianceYearPicker selectedRowInComponent:0]]];
    
    NSString *yearString = [NSString stringWithFormat:@"%@",[yearsListArray objectAtIndex:[complianceYearPicker selectedRowInComponent:1]]];
    
    self.pickerDisplayLabel.text    = [NSString stringWithFormat:@"%@/%@",monthString,yearString];
    [self compliancePickerResignAction];
}

- (IBAction)builtYearPickerDoneButtonClickedAction:(id)sender 
{
    NSString *yearString = [NSString stringWithFormat:@"%@",[yearsListArray objectAtIndex:[builtYearCustomPicker selectedRowInComponent:0]]];
    self.builtYearTxtField.text    = [NSString stringWithFormat:@"%@",yearString];
    [self bultYearPickerResignAction];
}

- (void)compliancePickerResignAction
{
    CGRect pickerHideRect = CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260);
    [self settingScrollviewFrame:YES    withAnimation:YES];
    [self animationForViewToVisable:pickerHideRect withView:self.compliancePickerView];
}

- (void)bultYearPickerResignAction
{
    CGRect pickerHideRect = CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260);

    [self settingScrollviewFrame:YES    withAnimation:YES];
    [self animationForViewToVisable:pickerHideRect withView:self.builtYearPickerView];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    NSInteger numberOfcomponents = 0;
    
    if (pickerView.tag == 21) 
    {
        numberOfcomponents=1;
    }
    else if (pickerView.tag == 22) 
    {
        numberOfcomponents=2;
    }

    return numberOfcomponents;
}

- (NSInteger) pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger) component
{
    NSInteger pickerDataCount = 0;
    if (pickerView.tag == 21) 
    {
        pickerDataCount = [yearsListArray count];
    }
    else if (pickerView.tag == 22) 
    {
        if (component == 0) 
        {
            pickerDataCount = [monthsListArray count];
        }
        else
        {
            pickerDataCount = [yearsListArray count];
        }
    }

    return pickerDataCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSString *pickerData = @"";
    
    if (pickerView.tag == 21) 
    {
        pickerData = [yearsListArray objectAtIndex:row];
    }
    else if (pickerView.tag == 22) 
    {
        if (component == 0) 
        {
            pickerData = [monthsListArray objectAtIndex:row];
        }
        else
        {
            pickerData = [yearsListArray objectAtIndex:row];
        }
    }

    return pickerData;
}

- (void) pickerView:(UIPickerView *) pickerView didSelectRow:(NSInteger) row inComponent:(NSInteger) component
{
    
    if (pickerView.tag == 21) 
    {
        NSString *yearString = [NSString stringWithFormat:@"%@",[yearsListArray objectAtIndex:[builtYearCustomPicker selectedRowInComponent:0]]];
        self.builtYearTxtField.text    = [NSString stringWithFormat:@"%@",yearString];
    }
    else if (pickerView.tag == 22) 
    {
        NSString *monthString = [NSString stringWithFormat:@"%@",[monthsListArray objectAtIndex:[complianceYearPicker selectedRowInComponent:0]]];
        
        NSString *yearString = [NSString stringWithFormat:@"%@",[yearsListArray objectAtIndex:[complianceYearPicker selectedRowInComponent:1]]];
        self.pickerDisplayLabel.text    = [NSString stringWithFormat:@"%@/%@",monthString,yearString];
    }
}

- (UIView *) pickerView:(UIPickerView *) pickerView viewForRow:(NSInteger) row forComponent:(NSInteger) component reusingView:(UIView *) view
{

    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(100, 246, 200, 30)] autorelease];

    if (pickerView.tag == 21) 
    {
        if (component == 0) 
        {
            label.text = [yearsListArray objectAtIndex:row];
            label.font = [UIFont boldSystemFontOfSize:20];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
        }
    }
    else if (pickerView.tag == 22) 
    {
        if (component == 0) 
        {
            label.text = [monthsListArray objectAtIndex:row];
            label.font = [UIFont boldSystemFontOfSize:20];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
        }
        else if (component == 1) 
        {
            label.text = [yearsListArray objectAtIndex:row];
            label.font = [UIFont boldSystemFontOfSize:20];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
        }
    }

    return label;
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

- (void)preSetDatePickerVCFrame{
    
    [self.builtYearPickerView setFrame:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 237)];
    [self.compliancePickerView setFrame:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 237)];

}

- (void)moveScrollViewToOffset:(CGPoint)offsetPoint withAnimation:(BOOL)animation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self.secondStageScrollView setContentOffset:offsetPoint];
    [UIView commitAnimations];
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}



- (void)scrollRectToVisible:(CGRect)targetRect{
    
    [self.secondStageScrollView scrollRectToVisible:targetRect animated:YES];
    
}

@end
