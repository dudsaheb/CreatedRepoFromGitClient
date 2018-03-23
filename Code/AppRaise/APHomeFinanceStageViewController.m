//
//  APHomeFinanceStageViewController.m
//  AppRaise
//
//  Created by Shaik Dud Saheb on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#define kKeyboardHeight 216

#import "APHomeFinanceStageViewController.h"
#import "APCommon.h"
#import "AppRaiseAppDelegate.h"
#import "APConstants.h"
#import "APHomeFourthStageVC.h"


@interface APHomeFinanceStageViewController (Private)

@end

@implementation APHomeFinanceStageViewController
@synthesize financeStageScrollView;
@synthesize financeStageView;

@synthesize dateTextField;
@synthesize dateButton;

@synthesize ownersNameTextField;
@synthesize phoneNoTextField;
@synthesize emailTextField;

@synthesize financierNameTextField;
@synthesize currentRepaymentTextField;
@synthesize financePayoutTextField;
@synthesize paymentsAffordabilityTextField;

@synthesize backButton;
@synthesize nextButton;

@synthesize bgImageView;
@synthesize financeStageFormDataDict;
@synthesize activeTextField;
@synthesize customDatePicker;
@synthesize extraHeightIfItIsIPhone5Device;

@synthesize bottomScrollViewConstraint;
@synthesize originalBottomConstraintValue;
@synthesize selectedDate;
@synthesize financeOwningSwitch;


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
    self.financeStageScrollView = nil;
    self.financeStageView = nil;
    
    self.dateTextField  = nil;
    self.ownersNameTextField = nil;
    self.phoneNoTextField = nil;
    self.emailTextField  = nil;
    self.financierNameTextField = nil;
    self.currentRepaymentTextField = nil;
    self.financePayoutTextField = nil;
    self.paymentsAffordabilityTextField = nil;
    
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.financeStageFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];

    
    [self setupScroolView];
    [self updateBgImageForIPhone5];
    
    [self configureForm];
    [self updateExtrHeightForiPhone5Device];
    [self loadPickers];

    [self prepareFinanceStageView];
    
    self.originalBottomConstraintValue = self.bottomScrollViewConstraint.constant;
    


}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self makeScrollViewSmall:NO];
    
    [self showFormData];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.financeStageScrollView = nil;
    self.financeStageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)setupScroolView{

    [self.financeStageScrollView addSubview:self.financeStageView];
    [self.financeStageView setBackgroundColor:[UIColor clearColor]];
    [self.financeStageScrollView setContentSize:self.financeStageView.frame.size];
    
    
}

- (void)makeScrollViewSmall:(BOOL)status{

    if (status) {
        CGFloat value =  kKeyboardHeight;
        if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0) {
            self.bottomScrollViewConstraint.constant = value-60;
        } else {
            self.bottomScrollViewConstraint.constant = value;
        }

    } else {
        self.bottomScrollViewConstraint.constant = self.originalBottomConstraintValue;
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self resignDatePicker];
    
    self.activeTextField = textField;
    [self makeScrollViewSmall:YES];
    [self scrollRectToVisible:textField.frame];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[textField resignFirstResponder];
    [self makeScrollViewSmall:NO];
    
    
    BOOL pressedReturnKey	= YES;
    
    BOOL returnValue	= YES;
    
	if(textField == self.ownersNameTextField)
	{
		[self.ownersNameTextField resignFirstResponder];
		[self.phoneNoTextField becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == self.phoneNoTextField)
	{
		[self.phoneNoTextField resignFirstResponder];
		[self.emailTextField becomeFirstResponder];
		returnValue	= NO;        pressedReturnKey = NO;
	}
	else if(textField == self.emailTextField)
	{
		[self.emailTextField resignFirstResponder];
        pressedReturnKey = YES;
		returnValue	= YES;
	}
    
    if(textField == self.financierNameTextField)
	{
		[self.financierNameTextField resignFirstResponder];
        [self.currentRepaymentTextField becomeFirstResponder];
        pressedReturnKey = YES;
		returnValue	= YES;
	}
    else if(textField == self.currentRepaymentTextField)
	{
		[self.currentRepaymentTextField resignFirstResponder];
        [self.financePayoutTextField becomeFirstResponder];
        pressedReturnKey = NO;
		returnValue	= NO;
	}else if(textField == self.financePayoutTextField)
	{
		[self.financePayoutTextField resignFirstResponder];
        [self.paymentsAffordabilityTextField becomeFirstResponder];

        pressedReturnKey = NO;
		returnValue	= NO;
	}else if(textField == self.paymentsAffordabilityTextField)
	{
		[self.paymentsAffordabilityTextField resignFirstResponder];
        
        pressedReturnKey = YES;
		returnValue	= YES;
	}

   
    return returnValue;
    
    
}



- (void)resignDatePicker{

    [self datePickerResignAction];
}

- (IBAction)onNextButtonAction:(id)sender{

    [self resignAllFirstResponders];
    [self resignDatePicker];
    
    if ([self validateFinanceStageFormData] == YES)
    {
         APHomeFourthStageVC *fourthStageVc = [[APHomeFourthStageVC alloc] initWithNibName:@"APHomeFourthStageVC" bundle:nil];
         [self collectFinanceStageFormData];
         [self.navigationController pushViewController:fourthStageVc animated:YES];
         [fourthStageVc  release];

    }
}

- (IBAction)onBackButtonAction:(id)sender{
    
    //[self collectFinanceStageFormData];

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)onDateButtonAction:(id)sender{

    [self resignAllFirstResponders];
    
    [self.view bringSubviewToFront:self.customDatePicker.view];
    
    [self makeScrollViewSmall:YES];
    [self scrollRectToVisible:self.dateTextField.frame];
    [self animationForViewToVisable:CGRectMake(0, 180+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:self.customDatePicker.view];
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}

- (BOOL)isThisIPhone5Device{
    
    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}


- (void)resignAllFirstResponders
{
    [self.activeTextField resignFirstResponder];
    
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
    self.dateTextField.text  = nil;
    self.ownersNameTextField.text = nil;
    self.phoneNoTextField.text = nil;
    self.emailTextField.text  = nil;
    self.financierNameTextField.text = nil;
    self.currentRepaymentTextField.text = nil;
    self.financePayoutTextField.text = nil;
    self.paymentsAffordabilityTextField.text = nil;

}

- (void)showFormData
{
    
    /*
    NSDate *date = [self.financeStageFormDataDict objectForKey:FINANCE_DATE_TEXTFIELD];
    self.selectedDate = date;
    
    self.dateTextField.text  = [APCommon formattedStringFromDate:date];
     */
    
    self.ownersNameTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_OWNERS_NAME_TEXTFIELD];
    self.phoneNoTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_PHONE_NO_TEXTFIELD];
    
   // NSString * email = self.emailTextField.text;
    self.emailTextField.text  = [self.financeStageFormDataDict objectForKey:FINANCE_EMAIL_TEXTFIELD];
    
    self.financierNameTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
    self.currentRepaymentTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
    self.financePayoutTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_PAYOUT_TEXTFIELD];
    self.paymentsAffordabilityTextField.text = [self.financeStageFormDataDict objectForKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];

    
}

- (void)collectFinanceStageFormData
{
    if ([self validateFinanceStageFormData])
    {
        /*
        [self.financeStageFormDataDict setObject:self.selectedDate forKey:FINANCE_DATE_TEXTFIELD];
         */
        
        [self.financeStageFormDataDict setObject:self.ownersNameTextField.text forKey:FINANCE_OWNERS_NAME_TEXTFIELD];
        [self.financeStageFormDataDict setObject:self.phoneNoTextField.text forKey:FINANCE_PHONE_NO_TEXTFIELD];
        
        //NSString * email = self.emailTextField.text;
        [self.financeStageFormDataDict setObject:self.emailTextField.text forKey:FINANCE_EMAIL_TEXTFIELD];
        
        [self.financeStageFormDataDict setObject:self.financierNameTextField.text forKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
        [self.financeStageFormDataDict setObject:self.currentRepaymentTextField.text forKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
        [self.financeStageFormDataDict setObject:self.financePayoutTextField.text forKey:FINANCE_PAYOUT_TEXTFIELD];
        [self.financeStageFormDataDict setObject:self.paymentsAffordabilityTextField.text forKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];

    }
}

- (BOOL)validateFinanceStageFormData{


    BOOL isValid = YES;
    
    /*
    if (self.dateTextField.text == nil || [self.dateTextField.text isEqualToString:@""] || [[self.dateTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Date."];
        return isValid;
    }
     
     */
    
    if (self.ownersNameTextField.text == nil || [self.ownersNameTextField.text isEqualToString:@""] || [[self.ownersNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Owners Name."];
        return isValid;
        
    }
    if (self.phoneNoTextField.text == nil || [self.phoneNoTextField.text isEqualToString:@""] || [[self.phoneNoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Phone Number."];
        return isValid;
    }
    
    
    // Email validation is not mandatory
    // For that reason we commented this code
    /*
    if (self.emailTextField.text == nil || [self.emailTextField.text isEqualToString:@""] || [[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Email."];
        return isValid;
    } else if (self.emailTextField.text != nil){
    
        if ([APCommon validateEmail:self.emailTextField.text])
        {
            BOOL isValidEmail = YES;
            NSString *isValidEmailStatusStr = (isValidEmail)?@"YES":@"NO";
            NSLog(@"isValidEmail - %@",isValidEmailStatusStr);
            
        }else{
            isValid = NO;
            [APCommon showAlertWithMessage:@"Specify valid email."];
        }
    }
    
    */
    
    
    
    if (self.financeOwningSwitch.isSwitchStatusOn) {
        
        if (self.financierNameTextField.text == nil || [self.financierNameTextField.text isEqualToString:@""] || [[self.financierNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        {
            isValid = NO;
            [APCommon showAlertWithMessage:@"Specify Financier Name"];
            return isValid;
        }
        if (self.currentRepaymentTextField.text == nil || [self.currentRepaymentTextField.text isEqualToString:@""] || [[self.currentRepaymentTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        {
            isValid = NO;
            [APCommon showAlertWithMessage:@"Specify Current Repayments."];
            return isValid;
        }
        
        if (self.financePayoutTextField.text == nil || [self.financePayoutTextField.text isEqualToString:@""] || [[self.financePayoutTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        {
            isValid = NO;
            [APCommon showAlertWithMessage:@"Specify Finance Payout."];
            return isValid;
        }
        
        if (self.paymentsAffordabilityTextField.text == nil || [self.paymentsAffordabilityTextField.text isEqualToString:@""] || [[self.paymentsAffordabilityTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
        {
            isValid = NO;
            [APCommon showAlertWithMessage:@"Specify New Payments Affordability."];
            return isValid;
        }
        

    }
    

    
    return isValid;
}


#pragma mark - Date Picker -
- (void)loadPickers
{
    self.customDatePicker = [[PSDatePickerViewController alloc]initWithNibName:@"PSDatePickerViewController" bundle:nil];
    self.customDatePicker.delegate = self;
    self.customDatePicker.view.frame = CGRectMake(0, 480+self.extraHeightIfItIsIPhone5Device, 320, 260);
    [self.view addSubview:self.customDatePicker.view];
}

- (void)onDateDoneButtonClicked:(NSDate*)date
{
    self.selectedDate = date;
    self.dateTextField.text = [APCommon formattedStringFromDate:date];
    [self.financeStageFormDataDict setObject:date forKey:FINANCE_DATE_TEXTFIELD];
    [self datePickerResignAction];
    [self makeScrollViewSmall:NO];
    
}

- (void)datePickerResignAction
{
    [self animationForViewToVisable:CGRectMake(0, 480+ self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
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


- (void)updateExtrHeightForiPhone5Device{
    
    if ([self isThisIPhone5Device]) {
        self.extraHeightIfItIsIPhone5Device = 100;
    } else {
        self.extraHeightIfItIsIPhone5Device = 0;
    }
    
}

- (void)scrollRectToVisible:(CGRect)targetRect{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        self.financeStageScrollView.contentOffset = CGPointMake(0, targetRect.origin.y);
    } else {
        [self.financeStageScrollView scrollRectToVisible:targetRect animated:YES];
    }
    
}


#pragma mark - Custom Switch -

- (void)prepareFinanceStageView
{
    // Reading last updated final switch tag value
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];
    
    int switchTag = globalSwitchTagValue;
    
    /*
    for (NSString *yValue in kStageFinanceSwitchYValue)
    {
        [self prepareCustomSwith:++switchTag withSwitchValue:YES andFrame:CGRectMake(kStageFinanceSwitchXValue, [yValue intValue], 95, 33)];
    }
     */
    
    
    CGFloat yValue = [[kStageFinanceSwitchYValue objectAtIndex:0] intValue];
    CGRect theFrame = CGRectMake(kStageFinanceSwitchXValue, yValue, 95, 33);
    
    self.financeOwningSwitch = [self createFinanceOwningSwitchWithTag:++switchTag
                                                            andStatus:NO
                                                              forRect:theFrame];
    
    // Updating final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:switchTag];
}

- (APCustomSwitch*)createFinanceOwningSwitchWithTag:(int)switchTag andStatus:(BOOL)status forRect:(CGRect)theFrame{

    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
    APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
    cSwitch.frame           = theFrame;
    cSwitch.tag             = switchTag;
    [cSwitch setSwitchStatus:[[self.financeStageFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)] boolValue]];
    cSwitch.delegate        = self;
    [self.financeStageView addSubview:cSwitch];
    
    return cSwitch;
}

/*
- (void)prepareCustomSwith:(NSInteger)switchTag withSwitchValue:(BOOL)switchStatus andFrame:(CGRect)theFrame
{
    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
    APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
    cSwitch.frame           = theFrame;
    cSwitch.tag             = switchTag;
    [cSwitch setSwitchStatus:[[self.financeStageFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)] boolValue]];
    cSwitch.delegate        = self;
    [self.financeStageView addSubview:cSwitch];
}

*/

- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag
{
    NSLog(@"switchStatus %d,switchTag %d",switchStatus,switchTag);
    
    [self resignAllFirstResponders];
    [self resignDatePicker];
    [self makeScrollViewSmall:NO];
    
    [self.financeStageFormDataDict setObject:SWITCH_DICTIONARY_VALUE(switchStatus) forKey:SWITCH_DICTIONARY_KEY(switchTag)];
    
    NSString *switchStatusStr = (self.financeOwningSwitch.isSwitchStatusOn)?@"YES":@"NO";
    [self.financeStageFormDataDict setObject:switchStatusStr forKey:FINANCE_OWING_SWITCH];
    
}

@end
