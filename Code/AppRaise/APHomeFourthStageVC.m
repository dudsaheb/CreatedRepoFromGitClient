//
//  APHomeFourthStageVC.m
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APHomeFourthStageVC.h"
#import "AppRaiseAppDelegate.h"
#import "APHomeFinalStageVC.h"
#import "APCommon.h"
#import "APConstants.h"

@interface APHomeFourthStageVC (Private)

- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view;
- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation;
//- (void)scrollToGivenRectWith:(NSInteger)viewTag;
- (void)setNumbersButtonDefaultBackGround;
- (void)numberButtonBackGroundChangeAction:(NSInteger)buttonTag WithButtonStatus:(BOOL)buttonStatus;
- (void)configureForm;
- (void)showFormData;
- (void)collectHomeFourthViewControlleFormData;
- (BOOL)validateHomeFourthViewControllerFormData;
- (void)textViewResignAction;
- (void)showHidePlaceHolderLbl;

@end

@implementation APHomeFourthStageVC
@synthesize fourthStageView;
@synthesize mechanicalTxtView;
@synthesize panelWorkTxtView;
@synthesize keyboardNavBar;
@synthesize fourthStageScrollView;
@synthesize btnNone;
@synthesize btnOne;
@synthesize btnTwo;
@synthesize btnThree;
@synthesize btnFour;

@synthesize extraHeightIfItIsIPhone5Device;
@synthesize extraYPossitionForTextFieldVisibility;
@synthesize keyboardAccessaryView;
@synthesize bgImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        //dataCollection2DictionaryStatus = NO;
    }
    return self;
}

- (void)dealloc
{
    [fourthStageView release];
    [mechanicalTxtView release];
    [panelWorkTxtView release];
    [fourthStageScrollView release];
    [keyboardNavBar release];
    [btnNone release];
    [btnOne release];
    [btnTwo release];
    [btnThree release];
    [btnFour release];
    [mechanicalPlaceHolderLbl release];
    [panelWorkPlaceHolderLbl release];
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

    
    homeFourthVCFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];
    
    [self configureForm];
    
    //self.fourthStageScrollView.contentSize = self.fourthStageView.frame.size;
    //[self.fourthStageScrollView addSubview:self.fourthStageView];

    btnFourStatus = NO;
    btnThreeStatus = NO;
    btnTwoStatus = NO;
    btnOneStatus = NO;
    btnNoneStatus = NO;
    
    [self.mechanicalTxtView setInputAccessoryView:self.keyboardAccessaryView];
    [self.panelWorkTxtView setInputAccessoryView:self.keyboardAccessaryView];
    
    [self updateExtrHeightForiPhone5Device];
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
    [self setFourthStageView:nil];
    [self setMechanicalTxtView:nil];
    [self setPanelWorkTxtView:nil];
    [self setFourthStageScrollView:nil];
    [self setKeyboardNavBar:nil];
    [self setBtnNone:nil];
    [self setBtnOne:nil];
    [self setBtnTwo:nil];
    [self setBtnThree:nil];
    [self setBtnFour:nil];
    [mechanicalPlaceHolderLbl release];
    mechanicalPlaceHolderLbl = nil;
    [panelWorkPlaceHolderLbl release];
    panelWorkPlaceHolderLbl = nil;
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
    
    self.fourthStageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, 320, 335 + self.extraHeightIfItIsIPhone5Device)];
    
    self.fourthStageScrollView.contentSize = self.fourthStageView.frame.size;
    
    [self.fourthStageScrollView addSubview:self.fourthStageView];
    [self.fourthStageView setBackgroundColor:[UIColor clearColor]];

    
    [self.view addSubview:self.fourthStageScrollView];
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
    self.mechanicalTxtView.text  = nil;
    self.panelWorkTxtView.text = nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: collectRigCompressorFormDat
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectHomeFourthViewControlleFormData
{
    if ([self validateHomeFourthViewControllerFormData])
    {
        NSString *mechanicalTxtViewStr = ([APCommon iSEmpty:self.mechanicalTxtView.text]) ? @"NA" : self.mechanicalTxtView.text;
        NSString *panelTxtViewStr = ([APCommon iSEmpty:self.panelWorkTxtView.text]) ? @"NA" : self.panelWorkTxtView.text;

        [homeFourthVCFormDataDict setObject:mechanicalTxtViewStr forKey:MECHANICALS_TXTVIEW];
        [homeFourthVCFormDataDict setObject:panelTxtViewStr forKey:PANEL_WORK_TXTVIEW];
    }
}

- (void)showFormData
{
    self.mechanicalTxtView.text = [homeFourthVCFormDataDict objectForKey:MECHANICALS_TXTVIEW];
    self.panelWorkTxtView.text  = [homeFourthVCFormDataDict objectForKey:PANEL_WORK_TXTVIEW];
    if ([self.mechanicalTxtView.text isEqualToString:@"NA"]) self.mechanicalTxtView.text = @"";
    if ([self.panelWorkTxtView.text isEqualToString:@"NA"]) self.panelWorkTxtView.text = @"";
    [self showHidePlaceHolderLbl];
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
- (BOOL)validateHomeFourthViewControllerFormData
{
    BOOL isValid = YES;
    
    //TODO: impliment validation
    if (self.mechanicalTxtView.text == nil || [self.mechanicalTxtView.text isEqualToString:@""] || [[self.mechanicalTxtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
//        isValid = NO;
//        [APCommon showAlertWithMessage:@"Specify mechanical issues."];
        return isValid;
    }
    if (self.panelWorkTxtView.text == nil || [self.panelWorkTxtView.text isEqualToString:@""] || [[self.panelWorkTxtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
//        isValid = NO;
//        [APCommon showAlertWithMessage:@"Specify pannel work issues."];
        return isValid;
    }
    return isValid;
}
- (IBAction)backButtonAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    [self collectHomeFourthViewControlleFormData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    if ([self validateHomeFourthViewControllerFormData] == YES) 
    {
        APHomeFinalStageVC *finalStageVc = [[APHomeFinalStageVC alloc] initWithNibName:@"APHomeFinalStageVC" bundle:nil];
        [self collectHomeFourthViewControlleFormData];
        [self.navigationController pushViewController:finalStageVc animated:YES];
        [finalStageVc  release];
    }
}

- (void)setNumbersButtonDefaultBackGround
{
    [self.btnOne setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
    [self.btnTwo setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
    [self.btnThree setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
    [self.btnFour setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
    [self.btnNone setBackgroundImage:[UIImage imageNamed:@"noneNoBtn.png"] forState:UIControlStateNormal];
}

- (void)numberButtonBackGroundChangeAction:(NSInteger)buttonTag WithButtonStatus:(BOOL)buttonStatus
{
    switch (buttonTag) 
    {
        case 10:
        {
            if (btnNoneStatus == buttonStatus) 
            {
                btnNoneStatus = YES;
                [self setNumbersButtonDefaultBackGround];
                [self.btnNone setBackgroundImage:[UIImage imageNamed:@"noneYesBtn.png"] forState:UIControlStateNormal];
            }
            else
            {
                btnNoneStatus = NO;
                [self.btnNone setBackgroundImage:[UIImage imageNamed:@"noneNoBtn.png"] forState:UIControlStateNormal];
            }
        }
            break;
            
        case 11:
        {
            if (btnOneStatus == buttonStatus) 
            {
                btnOneStatus = YES;
                [self setNumbersButtonDefaultBackGround];
                [self.btnOne setBackgroundImage:[UIImage imageNamed:@"noteYesBtn.png"] forState:UIControlStateNormal];
            }
            else
            {
                btnOneStatus = NO;
                [self.btnOne setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
            }
        }
            break;
      
        case 12:
        {
            if (btnTwoStatus == buttonStatus) 
            {
                btnTwoStatus = YES;
                [self setNumbersButtonDefaultBackGround];
                [self.btnTwo setBackgroundImage:[UIImage imageNamed:@"noteYesBtn.png"] forState:UIControlStateNormal];
            }
            else
            {
                btnTwoStatus = NO;
                [self.btnTwo setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
            }
        }

            break;
        
        case 13:
        {
            if (btnThreeStatus == buttonStatus) 
            {
                btnThreeStatus = YES;
                [self setNumbersButtonDefaultBackGround];
                [self.btnThree setBackgroundImage:[UIImage imageNamed:@"noteYesBtn.png"] forState:UIControlStateNormal];
            }
            else
            {
                btnThreeStatus = NO;
                [self.btnThree setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
            }
        }

            break;
        
        case 14:
        {
            if (btnFourStatus == buttonStatus) 
            {
                btnFourStatus = YES;
                [self setNumbersButtonDefaultBackGround];
                [self.btnFour setBackgroundImage:[UIImage imageNamed:@"noteYesBtn.png"] forState:UIControlStateNormal];
            }
            else
            {
                btnFourStatus = NO;
                
                [self.btnFour setBackgroundImage:[UIImage imageNamed:@"noteNoBtn.png"] forState:UIControlStateNormal];
            }
        }
            break;
       
        default:
            break;
    }
}

- (IBAction)btnNoneAction:(id)sender
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];
    
    if (btnNoneStatus == NO) 
    {
        [self numberButtonBackGroundChangeAction:10 WithButtonStatus:NO];
    }
    else
    {
        [self numberButtonBackGroundChangeAction:10 WithButtonStatus:YES];
    }
    [homeFourthVCFormDataDict setObject:TYRES_DICTIONARY_VALUE(0) forKey:TYRES_DICTIONARY_KEY];

}

- (IBAction)btnOneAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    if (btnOneStatus == NO) 
    {
        [self numberButtonBackGroundChangeAction:11 WithButtonStatus:NO];
    }
    else
    {
        [self numberButtonBackGroundChangeAction:11 WithButtonStatus:YES];
    }
    [homeFourthVCFormDataDict setObject:TYRES_DICTIONARY_VALUE(1) forKey:TYRES_DICTIONARY_KEY];

}

- (IBAction)btnTwoAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    if (btnTwoStatus == NO) 
    {
        [self numberButtonBackGroundChangeAction:12 WithButtonStatus:NO];
    }
    else
    {
        [self numberButtonBackGroundChangeAction:12 WithButtonStatus:YES];
    }
    [homeFourthVCFormDataDict setObject:TYRES_DICTIONARY_VALUE(2) forKey:TYRES_DICTIONARY_KEY];

}

- (IBAction)btnThreeAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    if (btnThreeStatus == NO) 
    {
        [self numberButtonBackGroundChangeAction:13 WithButtonStatus:NO];
    }
    else
    {
        [self numberButtonBackGroundChangeAction:13 WithButtonStatus:YES];
    }
    [homeFourthVCFormDataDict setObject:TYRES_DICTIONARY_VALUE(3) forKey:TYRES_DICTIONARY_KEY];

}

- (IBAction)btnFourthAction:(id)sender 
{
//    [self.mechanicalTxtView resignFirstResponder];
//    [self.panelWorkTxtView resignFirstResponder];

    if (btnFourStatus == NO) 
    {
        [self numberButtonBackGroundChangeAction:14 WithButtonStatus:NO];
    }
    else
    {
        [self numberButtonBackGroundChangeAction:14 WithButtonStatus:YES];
    }
    [homeFourthVCFormDataDict setObject:TYRES_DICTIONARY_VALUE(4) forKey:TYRES_DICTIONARY_KEY];

}

- (IBAction)keyBoardResignButtonAction:(id)sender 
{
    [self settingScrollviewFrame:YES withAnimation:YES];
    [self textViewResignAction];
}

- (void)textViewResignAction
{
    [self.mechanicalTxtView resignFirstResponder];
    [self.panelWorkTxtView resignFirstResponder];
    [self animationForViewToVisable:CGRectMake(0, 500+self.extraHeightIfItIsIPhone5Device, 320, 44) withView:keyboardNavBar];
}
- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view
{
    
    [self.view bringSubviewToFront:keyboardNavBar];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [view setFrame:rectValue];
    [UIView commitAnimations];
    
}

- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation
{
    if (isFull) 
    {
        fourthStageScrollView.frame = CGRectMake(0, 70, 320, 340+ self.extraHeightIfItIsIPhone5Device);
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        fourthStageScrollView.frame = CGRectMake(0, 70, 320, 200+ self.extraHeightIfItIsIPhone5Device);
        [UIView commitAnimations];
    }
}

/*
- (void)scrollToGivenRectWith:(NSInteger)viewTag
{
    CGRect rect = CGRectZero;
    
    switch (viewTag) 
    {
        case 11:
            rect = CGRectMake(0, 180, 320, 138);
            break;
        case 12:
            rect = CGRectMake(0, 420, 320, 138);
            break;
    }
    
    [fourthStageScrollView scrollRectToVisible:rect animated:YES];
}

*/

#pragma mark .........
#pragma mark UITextView Delegate
#pragma mark .........

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView       
{
    
    [self animationForViewToVisable:CGRectMake(0, 100, 320, 44) withView:keyboardNavBar];
    [self settingScrollviewFrame:NO withAnimation:NO];

    //[self scrollToGivenRectWith:textView.tag];
    [self scrollRectToVisible:textView.frame];
    
    if (textView == mechanicalTxtView) 
    {
        [self.mechanicalTxtView setInputAccessoryView:self.keyboardAccessaryView];
        mechanicalPlaceHolderLbl.hidden = YES;
    }
    
    if (textView == panelWorkTxtView) 
    {
        [self.panelWorkTxtView setInputAccessoryView:self.keyboardAccessaryView];
        panelWorkPlaceHolderLbl.hidden = YES;
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{	
    [self showHidePlaceHolderLbl];
	return YES;
}

- (IBAction)appRaiseButtonAction:(id)sender 
{
    APAppraiseView *apRaise = (APAppraiseView*)[[[NSBundle mainBundle] loadNibNamed:@"APAppraiseView" owner:self options:nil] lastObject];
    apRaise.delgate = self;
    [apRaise adjustFrameAsPerDeviceScreenSize];
    [self.view addSubview:apRaise];
}

- (void)showHidePlaceHolderLbl
{
    if ([APCommon iSEmpty:mechanicalTxtView.text])
    {
        mechanicalPlaceHolderLbl.hidden = NO;
    }
    else
    {
        mechanicalPlaceHolderLbl.hidden = YES;
    }
    
    if ([APCommon iSEmpty:panelWorkTxtView.text])
    {
        panelWorkPlaceHolderLbl.hidden = NO;
    }
    else
    {
        panelWorkPlaceHolderLbl.hidden = YES;
    }
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


- (void)scrollRectToVisible:(CGRect)targetRect{
    
    [self.fourthStageScrollView scrollRectToVisible:targetRect animated:YES];
    
}


@end
