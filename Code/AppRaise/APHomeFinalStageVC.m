//
//  APHomeFinalStageVC.m
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APHomeFinalStageVC.h"
#import "AppRaiseAppDelegate.h"
#import "APConstants.h"
#import "APCommon.h"
#import "APCoreDataHelper.h"
#import "APPhotosViewConroller.h"
#import "APPDFGenerator.h"
#import "UIImage+Resize.h"

#define kMaximumPhotos 6

static UIImagePickerController *imagePickerController = nil;

@interface APHomeFinalStageVC (Private)

- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view;
- (void)settingScrollviewFrame:(BOOL)isFull withAnimation:(BOOL)isAnimation;

//- (void)scrollToGivenRectWith:(NSInteger)viewTag;

- (void)pickerResignAction;
- (void)keyBoardNavigationBarResignAction;
- (void)preparingMailViewContrller;
- (void)activityIndicatorAlertViewWithMessage:(NSString*)message;
- (void)configureForm;
- (void)showFormData;
- (void)collectHomeFinalViewControlleFormData;
- (BOOL)validateHomeFinalViewControllerFormData;
- (void)configureReachability;
- (void)updateInterfaceWithReachability:(Reachability*)curReach;
- (void)resignAllFirstResponders;
- (NSString*)getModifiedFileName:(NSInteger)theRecordID;
- (void)resetAllFormData;
- (void)showHidePlaceHolderLbl;
- (void)loadAppRaiseDatePicker;
- (void)datePickerResignAction;

@end

@implementation APHomeFinalStageVC
@synthesize appraisedByTxtField;
@synthesize appraisedScore;
@synthesize appraisalDateTxtField;
@synthesize finalStageScrollView;
@synthesize finalStageView;
@synthesize otherInfoTxtView;
@synthesize keyBoardNavBar;
@synthesize appraisedScorePicker;
@synthesize appraisedScorePickerView;
@synthesize appraisedScoreLabel;

@synthesize extraHeightIfItIsIPhone5Device;
@synthesize extraYPossitionForTextFieldVisibility;
@synthesize keyboardAccessaryView;
@synthesize bgImageView;
//@synthesize PDFCreator;

@synthesize pdfFromHtml;
@synthesize outrightPurchasesSwitch;
@synthesize mailController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        appraisedScoreArray = [[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil] retain];
    }
    return self;
}

- (void)dealloc
{
    [otherInfoTxtView release];
    [appraisalDateTxtField release];
    [appraisedByTxtField release];
    [appraisedScore release];
    [finalStageScrollView release];
    [finalStageView release];
    [keyBoardNavBar release];
    [appraisedScorePicker release];
    [appraisedScorePickerView release];
    [appraisedScoreLabel release];
    [appraisedScoreArray release];
     imagePickerController = nil;
    [otherInfoPlaceHolderLbl release];
    [mailController release];
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

    if (nil == imagePickerController)
    {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.navigationBar.barStyle = UIBarStyleBlack;
    }
    

    homeFinalVCFormDataDict    = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] vehicleFormDataDictionary];
    photoCollectDict = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]delegate] photosCollectionDict];
    [self configureForm];
    
    //self.finalStageScrollView.contentSize = self.finalStageView.frame.size;
    //[self.finalStageScrollView addSubview:self.finalStageView];
    
    appraisedScorePickerView.frame = CGRectMake(0, 590, 320, 260);
    [self.view addSubview:appraisedScorePickerView];
    [self.view bringSubviewToFront:self.appraisedScorePickerView];
    [self loadAppRaiseDatePicker];
    
    [self.otherInfoTxtView setInputAccessoryView:self.keyboardAccessaryView];
    
    [self updateExtrHeightForiPhone5Device];
    [self setupScrollView];
    
    
    [self prepareFinalStageView];
    
    [self initializeMailViewController];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateBgImageForIPhone5];
    [self showFormData];
}

- (void)viewDidUnload
{
    [self setOtherInfoTxtView:nil];
    [self setAppraisalDateTxtField:nil];
    [self setAppraisedByTxtField:nil];
    [self setAppraisedScore:nil];
    [self setFinalStageScrollView:nil];
    [self setFinalStageView:nil];
    [self setKeyBoardNavBar:nil];
    [self setAppraisedScorePicker:nil];
    [self setAppraisedScorePickerView:nil];
    [self setAppraisedScoreLabel:nil];
    [otherInfoPlaceHolderLbl release];
    otherInfoPlaceHolderLbl = nil;
    self.mailController = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)initializeMailViewController{
    self.mailController = [[MFMailComposeViewController alloc] init];
    mailController.navigationBar.barStyle       = UIBarStyleBlack;
    mailController.mailComposeDelegate = self;
}

- (void)prepareFinalStageView
{
    // Reading last updated final switch tag value
    int globalSwitchTagValue = [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] switchTagValue];
    
    int switchTag = globalSwitchTagValue;

    
    CGFloat yValue = [[kStageFinalStageOutrightPurchaseSwitchYValue objectAtIndex:0] intValue];
    CGRect theFrame = CGRectMake(kStageFinalStageOutrightPurchaseSwitchXValue, yValue, 95, 33);
    
    self.outrightPurchasesSwitch = [self createOutRightPurchasesSwitchWithTag:++switchTag
                                                            andStatus:NO
                                                              forRect:theFrame];
    
    // Updating final switch tag value
    [(AppRaiseAppDelegate*)[[UIApplication sharedApplication]  delegate] setSwitchTagValue:switchTag];
}

- (void)setupScrollView{
    
    self.finalStageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, 350 + self.extraHeightIfItIsIPhone5Device)];
    
    self.finalStageScrollView.contentSize = self.finalStageView.frame.size;
 
    [self.finalStageScrollView addSubview:self.finalStageView];
    [self.finalStageView setBackgroundColor:[UIColor clearColor]];

    
    [self.view addSubview:self.finalStageScrollView];
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
    self.appraisalDateTxtField.text  = nil;
    self.appraisedByTxtField.text = nil;
    self.appraisedScoreLabel.text = nil;
    self.otherInfoTxtView.text  = nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: collectRigCompressorFormDat
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)collectHomeFinalViewControlleFormData
{
    if ([self validateHomeFinalViewControllerFormData])
    {
        [homeFinalVCFormDataDict setObject:self.appraisalDateTxtField.text forKey:APPRAISAL_DATE_TXTFIELD];
        [homeFinalVCFormDataDict setObject:self.appraisedByTxtField.text forKey:APPRAISED_BY_TXTFIELD];
        [homeFinalVCFormDataDict setObject:self.appraisedScoreLabel.text forKey:APPRAISED_SCORE_FIELD];
        [homeFinalVCFormDataDict setObject:self.otherInfoTxtView.text forKey:OTHER_INFO_TXTVIEW];
    }
}

- (void)showFormData
{
    self.appraisalDateTxtField.text = [APCommon formattedStringFromDate:[homeFinalVCFormDataDict objectForKey:APPRAISAL_DATE_TXTFIELD]];
    self.appraisedByTxtField.text  = [homeFinalVCFormDataDict objectForKey:APPRAISED_BY_TXTFIELD];
    self.appraisedScore.text = [homeFinalVCFormDataDict objectForKey:APPRAISED_SCORE_FIELD];
    self.otherInfoTxtView.text  = [homeFinalVCFormDataDict objectForKey:OTHER_INFO_TXTVIEW];
    if ([self.otherInfoTxtView.text isEqualToString:@"NA"]) self.otherInfoTxtView.text = @"";
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
- (BOOL)validateHomeFinalViewControllerFormData{
    BOOL isValid = YES;
    
    //TODO: impliment validation
   
    if (self.appraisalDateTxtField.text == nil || [self.appraisalDateTxtField.text isEqualToString:@""] || [[self.appraisalDateTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Appraisal Date."];
        return isValid;
    }
    if (self.appraisedByTxtField.text == nil || [self.appraisedByTxtField.text isEqualToString:@""] || [[self.appraisedByTxtField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify AppraisedBy"];
        return isValid;
        
    }
    if (self.appraisedScoreLabel.text == nil || [self.appraisedScoreLabel.text isEqualToString:@""] || [[self.appraisedScoreLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
        isValid = NO;
        [APCommon showAlertWithMessage:@"Specify Appraise score"];
        return isValid;
    }

    return isValid;
}

- (IBAction)dropDownBtnAction:(id)sender 
{
    [self.view bringSubviewToFront:self.appraisedScorePickerView];
    [self resignAllFirstResponders];
    [self datePickerResignAction];
    [self animationForViewToVisable:CGRectMake(0, 178+self.extraHeightIfItIsIPhone5Device, 320, 260) withView:appraisedScorePickerView];

    [self animationForViewToVisable:CGRectMake(0, 60, 320, 148+self.extraHeightIfItIsIPhone5Device) withView:finalStageScrollView];
    
    //[self scrollToGivenRectWith:13];
    [self scrollRectToVisible:self.appraisedScoreLabel.frame];
}

- (void)resignAllFirstResponders
{
    [appraisedByTxtField resignFirstResponder];
    [appraisalDateTxtField resignFirstResponder];
    [otherInfoTxtView resignFirstResponder];
}
- (IBAction)otherInfoBtnAction:(id)sender 
{
}

- (IBAction)takePhotoBtnAction:(id)sender 
{
    [self resignAllFirstResponders];
    [self pickerResignAction];
    [self datePickerResignAction];
    
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    NSString *deviceModel = [UIDevice currentDevice].model;
    
    NSString *maxPhotosAlertStr= @"Maximum Six Photos per report.";
    
    if (isCameraAvailable == YES ||[deviceModel isEqualToString:@"iPhone"])
    {
        if ([photoCollectDict count] < kMaximumPhotos)
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            //[self presentModalViewController:imagePickerController animated:YES];
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:APP_NAME  message:maxPhotosAlertStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            alert.tag           = 12345;
            alert.delegate      = self;
            [alert show];
            [alert release];
        }
    }
    else
    {
        if ([photoCollectDict count] < kMaximumPhotos)
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:imagePickerController animated:YES completion:nil];

        }
        else
        {
            UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:APP_NAME  message:maxPhotosAlertStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            alert.tag           = 12345;
            alert.delegate      = self;
            [alert show];
            [alert release];
        }
    }
}

#pragma mark .........
#pragma mark UIImagePickerView Delegate
#pragma mark .........

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if (nil != image)
    {
        UIImage *newImage = [UIImage imageWithData:UIImageJPEGRepresentation(image,1)];
        
//        CGSize targetSize = CGSizeMake(263, 147);
        CGSize targetSize = CGSizeMake(163, 97);

        
        UIImage *modifiedImage = [newImage resizedImageToFitInSize:targetSize scaleIfSmaller:NO];
        int key = (int)[photoCollectDict count]+1;
        NSString* photoKeyStr = PHOTO_KEY(key);
        [photoCollectDict setObject:modifiedImage forKey:photoKeyStr];
    }
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)viewPhotoBtnAction:(id)sender 
{
    [self resignAllFirstResponders];
    [self pickerResignAction];
    [self datePickerResignAction];
    
    
    APPhotosViewConroller *photosVc = [[APPhotosViewConroller alloc] initWithNibName:@"APPhotosViewConroller" bundle:nil];
    [self.navigationController pushViewController:photosVc animated:YES];
    [photosVc  release];

}

- (IBAction)submitBtnAction:(id)sender
{
    
    // Store Total Switches
    AppRaiseAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    [homeFinalVCFormDataDict setObject:[NSString stringWithFormat:@"%d",appdelegate.switchTagValue] forKey:TOTAL_SWITCHES_COUNT];
    
    
    [self resignAllFirstResponders];
    [self pickerResignAction];
    [self datePickerResignAction];
    if ([self validateHomeFinalViewControllerFormData] == YES) 
    {
            [APCommon showProgressAlertView];
            [self collectHomeFinalViewControlleFormData];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *saveDirectory = [paths objectAtIndex:0];
            [homeFinalVCFormDataDict setObject:[NSDate date] forKey:VEHICLE_RECORD_CREATED_DATE];
            NSString *fullDate = [APCommon fullFormatedStringFromDate:[homeFinalVCFormDataDict objectForKey:VEHICLE_RECORD_CREATED_DATE]];
            NSString *uniqueId = [APCommon UUIDString];
            NSInteger recordId = 1;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:VEHICLE_RECORD_ID]) 
            {
                recordId = [[[NSUserDefaults standardUserDefaults] objectForKey:VEHICLE_RECORD_ID] intValue];
            }
            NSString *modifiedFileName = [self getModifiedFileName:recordId];
            [homeFinalVCFormDataDict setObject:modifiedFileName forKey:VEHICLE_MODIFIED_FILE_NAME];
            NSString *saveFileName = VEHICLEPDF_FILENAME(modifiedFileName,fullDate,uniqueId,recordId);
            [homeFinalVCFormDataDict setObject:saveFileName forKey:VEHICLE_PDF_FILENAME];
            
            [homeFinalVCFormDataDict setObject:[NSNumber numberWithInteger:recordId] forKey:VEHICLE_RECORD_ID];
            
            NSString *newFilePath   = [saveDirectory stringByAppendingPathComponent:saveFileName];
            const char *filename    = [newFilePath UTF8String];
            NSLog(@"filename %@",[NSString stringWithUTF8String:filename]);
            
            // write pDF code here.
            
            const char *p = "PreStart";
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSValue valueWithPointer: p], @"name", nil];
        
        
        /*
        // pdf implemettation should be done here. 
        [APPDFGenerator CreatePDFFile:CGRectMake(0, 0 , 595/2.0, 842.0/2.0) andFileName:filename andInputParameters:dict filetype:NO withFileData:homeFinalVCFormDataDict andSignature:nil withFileName:nil withPhotos:photoCollectDict];
        */
        
        /*
        [self CreatePDFFile:CGRectMake(0, 0 , 595/2.0, 842.0/2.0) andFileName:filename andInputParameters:dict filetype:NO withFileData:homeFinalVCFormDataDict andSignature:nil withTargetPdfFileName:newFilePath withPhotos:photoCollectDict];
         */
        
        
        // Target Html Page Name
        NSString *htmlPageName = @"AppraiseHtml.html";
        
        //int totalPhotos = [photoCollectDict count];
        
        // Target PDF File name
        NSString *pdfFileName = [[newFilePath componentsSeparatedByString:@"/"] lastObject];
        self.pdfFromHtml = [[SACreatePDFFromHTML alloc] init];
        self.pdfFromHtml.delegate = self;
        [self.pdfFromHtml createPDFFileWithFileDataDic:homeFinalVCFormDataDict
                                 withTargetPdfFileName:pdfFileName
                                            withPhotos:photoCollectDict andTargetHtmlPage:htmlPageName];
        
        [dict release];

        /*
        [APCommon dismissProgressAlertView];
        [self configureReachability];
        if (netStatus != NotReachable)  //(1 == 1)//
        {
            [self preparingMailViewContrller];
            [homeFinalVCFormDataDict setObject:[NSNumber numberWithBool:YES] forKey:VEHICLE_FILE_SEND];
        }
        else
        {
            [homeFinalVCFormDataDict setObject:[NSNumber numberWithBool:NO] forKey:VEHICLE_FILE_SEND];
            UIAlertView *alert  =   [[UIAlertView alloc] initWithTitle:APP_NAME message:NETWORK_ERROR_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag           =   NETWORK_ERROR_MSG_TAG;
            [alert show];
            [alert release];
        }
        
        */
        
        [[APCoreDataHelper sharedCoreDataHelper] addVehicleRecord:homeFinalVCFormDataDict];
    }
    
}

#pragma mark -
#pragma mark NETWORK REACHABLITY CHECKING _ METHODES
#pragma mark -

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: NetWorkReachability - configureReachability
// Parameters	: 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)configureReachability
{
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called. 
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifier];
	[self updateInterfaceWithReachability: wifiReach];
    
    //Change the host name here to change the server your monitoring
	hostReach = [[Reachability reachabilityWithHostName:AP_HOST_NAME] retain];
	[hostReach startNotifier];
	[self updateInterfaceWithReachability: hostReach];
	
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: NetWorkReachability - updateInterfaceWithReachability
// Parameters	: curReach
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)updateInterfaceWithReachability: (Reachability*) curReach
{
    if(curReach == hostReach)
	{
        netStatus = [curReach currentReachabilityStatus];
    }
	if(curReach == internetReach)
	{
        netStatus = [curReach currentReachabilityStatus];
	}
	if(curReach == wifiReach)
	{
        netStatus = [curReach currentReachabilityStatus];
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: NetWorkReachability - reachabilityChanged (//Called by Reachability whenever status changes.)
// Parameters	: note
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}


- (IBAction)keyBoardResignButtonAction:(id)sender 
{
    [self settingScrollviewFrame:YES    withAnimation:YES];
    [homeFinalVCFormDataDict setObject:self.otherInfoTxtView.text forKey:OTHER_INFO_TXTVIEW];
    [self.otherInfoTxtView resignFirstResponder];
    [self keyBoardNavigationBarResignAction];
}

- (void)keyBoardNavigationBarResignAction
{
    [self animationForViewToVisable:CGRectMake(0, 480, 320, 44) withView:keyBoardNavBar];
}

- (void)animationForViewToVisable:(CGRect)rectValue withView:(UIView *)view
{
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
        finalStageScrollView.frame = CGRectMake(0, 60, 320, 350 + self.extraHeightIfItIsIPhone5Device);
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        finalStageScrollView.frame = CGRectMake(0, 60, 320, 200 + self.extraHeightIfItIsIPhone5Device);
        [UIView commitAnimations];
    }
}

/*
- (void)scrollToGivenRectWith:(NSInteger)viewTag
{
    CGRect rect = CGRectZero;
    
    switch (viewTag) 
    {
        case 12: 
            rect = CGRectMake(0, 160, 320, 55);
            break;
        case 13:
            rect = CGRectMake(0, 160, 320, 55);
            break;
        case 14:
            rect = CGRectMake(0, 280, 320, 138);
            break;
    }
    
    [finalStageScrollView scrollRectToVisible:rect animated:YES];

}
*/

#pragma mark .........
#pragma mark UITextField Delegate
#pragma mark .........

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField       
{
    [self pickerResignAction];
    [self datePickerResignAction];
    [self keyBoardNavigationBarResignAction];
    [self settingScrollviewFrame:NO withAnimation:NO];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{	
    if(textField == appraisedByTxtField)
	{
        [homeFinalVCFormDataDict setObject:self.appraisedByTxtField.text forKey:APPRAISED_BY_TXTFIELD];
    }
    else if(textField == appraisalDateTxtField)
	{
        [homeFinalVCFormDataDict setObject:self.appraisalDateTxtField.text forKey:APPRAISAL_DATE_TXTFIELD];
    }
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL pressedReturnKey	= YES;
    
    BOOL returnValue	= YES;
    
    if(textField == appraisedByTxtField)
	{
		[appraisedByTxtField resignFirstResponder];
        [homeFinalVCFormDataDict setObject:self.appraisedByTxtField.text forKey:APPRAISED_BY_TXTFIELD];
        pressedReturnKey = YES;     returnValue	= YES;
	}
    
    if (pressedReturnKey) [self settingScrollviewFrame:returnValue withAnimation:pressedReturnKey];
    return returnValue;
}

#pragma mark .........
#pragma mark UITextView Delegate
#pragma mark .........

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView       
{
    [self pickerResignAction];
    [self datePickerResignAction];
    [self animationForViewToVisable:CGRectMake(0, 202, 320, 44) withView:keyBoardNavBar];
    [self animationForViewToVisable:CGRectMake(0, 60, 320, 200+self.extraHeightIfItIsIPhone5Device) withView:finalStageScrollView];
    
//    [self scrollToGivenRectWith:textView.tag];
    [self scrollRectToVisible:textView.frame];
    
    if (textView == otherInfoTxtView)
    {
        otherInfoPlaceHolderLbl.hidden = YES;
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{	
    [self showHidePlaceHolderLbl];
	return YES;
}


- (void)showHidePlaceHolderLbl
{
    if ([APCommon iSEmpty:otherInfoTxtView.text])
    {
        otherInfoPlaceHolderLbl.hidden = NO;
    }
    else
    {
        otherInfoPlaceHolderLbl.hidden = YES;
    }
}

#pragma mark .........
#pragma mark Preparing Mail
#pragma mark .........

- (void)preparingMailViewContrller
{

    
    if([MFMailComposeViewController canSendMail])
    {

        
        if([APCommon emailDictionaryCount] > 0)
        {
            [mailController setToRecipients:[APCommon emailsDictionaryValues]];
        }
        
        NSString *fileTitle = [homeFinalVCFormDataDict objectForKey:VEHICLE_MODIFIED_FILE_NAME];

        [mailController setSubject:[NSString stringWithFormat:@"New %@ Submission", fileTitle]];
        [mailController setMessageBody:[NSString stringWithFormat:@"New %@ Submission", fileTitle] isHTML:NO];
        
        
        
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         
         NSString *saveDirectory = [paths objectAtIndex:0];

         NSString *saveFileName = [homeFinalVCFormDataDict objectForKey:VEHICLE_PDF_FILENAME];
        
        NSString *filePath = [saveDirectory stringByAppendingPathComponent:saveFileName];
        // NSString *filePath = [NDGlobal getFilePathForMAil:saveFileName];
        
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        
        [mailController addAttachmentData:fileData mimeType:@"Application/PDF" fileName:[NSString stringWithFormat:@"%@.pdf",fileTitle]];
		
        
        [self presentViewController:mailController animated:YES completion:nil];


    }
    
    
}

#pragma mark .........
#pragma mark Mail delegate methods
#pragma mark .........

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    NSString *msg = @"";
    
	if (result == MFMailComposeResultSent) 
	{
        msg = @"Mail sent";
	}
    else if (result == MFMailComposeResultCancelled)
    {
        msg =@"Mail sent cancelled.";
        
	}
    else if (result == MFMailComposeResultSaved)
    {
        msg =@"Mail saved in Draft.";
	}
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self activityIndicatorAlertViewWithMessage:msg];
}

#pragma mark ......
#pragma mark ALERT VIEW ACTIVITY INDICATOR _ METHODES
#pragma mark ......

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: activityIndicatorAlertViewWithMessage
// Parameters	: message
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)activityIndicatorAlertViewWithMessage:(NSString*)message
{
    UIAlertView *alertView = [[[UIAlertView alloc]initWithTitle:APP_NAME message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
    UIActivityIndicatorView *indicatorView              = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame                                 = CGRectMake(125, 80, 40, 40);
    indicatorView.tag                                   = 300;
    [indicatorView startAnimating];
    [alertView addSubview:indicatorView];
    [indicatorView release];    
    [alertView show];
    [self performSelector:@selector(popController:) withObject:alertView afterDelay:1.0];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: popController
// Parameters	: sender
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) popController:(id) sender
{
    [sender dismissWithClickedButtonIndex:0 animated:YES];
    [self resetAllFormData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark .........
#pragma mark AlertView delegate methods
#pragma mark .........

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 12345) 
    {
        if (buttonIndex == 0) 
        {
            //[self dismissModalViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];

        }
    }
    else if (alertView.tag == NETWORK_ERROR_MSG_TAG ) 
    {
        [self resetAllFormData];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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

- (IBAction)appraisedScorePickerDoneBtnAction:(id)sender 
{
    [self datePickerResignAction];
    
    self.appraisedScoreLabel.text    = [NSString stringWithFormat:@"%@",[appraisedScoreArray objectAtIndex:[appraisedScorePicker selectedRowInComponent:0]] ];
    [homeFinalVCFormDataDict setObject:self.appraisedScoreLabel.text forKey:APPRAISED_SCORE_FIELD];
    [self pickerResignAction];
    //[self keyBoardNavigationBarResignAction];
}

- (void)loadAppRaiseDatePicker
{
    customDatePicker = [[PSDatePickerViewController alloc]initWithNibName:@"PSDatePickerViewController" bundle:nil];
    customDatePicker.delegate = self;
    customDatePicker.view.frame = CGRectMake(0, 580, 320, 260);
    [self.view addSubview:customDatePicker.view];
    [self.view bringSubviewToFront:customDatePicker.view];

}

- (IBAction)appRaiseDateButtonClickedAction:(id)sender 
{
    [self.view bringSubviewToFront:customDatePicker.view];
    [self resignAllFirstResponders];
    [self pickerResignAction];
    
    [self settingScrollviewFrame:NO withAnimation:NO];
    
    //[self scrollToGivenRectWith:12];
    [self scrollRectToVisible:self.appraisalDateTxtField.frame];

    
    [self animationForViewToVisable:CGRectMake(0, 170+self.extraHeightIfItIsIPhone5Device, 320, 260) withView:customDatePicker.view];
}

- (void)onDateDoneButtonClicked:(NSDate*)date
{
    appraisalDateTxtField.text = [APCommon formattedStringFromDate:date];
    [homeFinalVCFormDataDict setObject:date forKey:APPRAISAL_DATE_TXTFIELD];
    [self settingScrollviewFrame:YES withAnimation:YES];
    [self datePickerResignAction];
}

- (void)datePickerResignAction
{
    [self animationForViewToVisable:CGRectMake(0, 590, 320, 260) withView:customDatePicker.view];
}

- (void)pickerResignAction
{
    [self keyBoardNavigationBarResignAction];
    [self settingScrollviewFrame:YES    withAnimation:YES];
    [self animationForViewToVisable:CGRectMake(0, 590, 320, 237) withView:self.appraisedScorePickerView];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger) component
{
    NSInteger pickerDataCount = 0;
   
    if (component == 0) 
    {
        pickerDataCount = [appraisedScoreArray count];
    }
    return pickerDataCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSString *pickerData = @"";
    if (component == 0) 
    {
        pickerData = [appraisedScoreArray objectAtIndex:row];
    }
    return pickerData;
}

- (UIView *) pickerView:(UIPickerView *) pickerView viewForRow:(NSInteger) row forComponent:(NSInteger) component reusingView:(UIView *) view
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(100, 246, 200, 30)] autorelease];

    if (component == 0) 
    {
        label.text = [appraisedScoreArray objectAtIndex:row];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    return label;
}

- (void) pickerView:(UIPickerView *) pickerView didSelectRow:(NSInteger) row inComponent:(NSInteger) component
{
    self.appraisedScoreLabel.text    = [NSString stringWithFormat:@"%@",[appraisedScoreArray objectAtIndex:[appraisedScorePicker selectedRowInComponent:0]] ];

}

- (NSString*)getModifiedFileName:(NSInteger)theRecordID
{
    return [NSString stringWithFormat:@"%@,%@ - %d", [homeFinalVCFormDataDict objectForKey:MAKE_TXTFIELD],[homeFinalVCFormDataDict objectForKey:MODEL_TXTFIELD],theRecordID];
}

- (void)resetAllFormData
{
    /*
    [homeFinalVCFormDataDict setObject:@"" forKey:MAKE_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:MODEL_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:REGO_NO_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:TYPE_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:EXPIRY_DATE_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:ODOMETER_READING_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:BUILT_YEAR_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:COMPLIANCE_YEAR_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:VIN_NO_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:EXTERIOR_COLOR_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:INTERIOR_COLOR_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:ENGINE_SIZE_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:CYLINDERS_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:GEARS_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:MECHANICALS_TXTVIEW];
    [homeFinalVCFormDataDict setObject:@"" forKey:PANEL_WORK_TXTVIEW];
    [homeFinalVCFormDataDict setObject:@"" forKey:APPRAISAL_DATE_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:APPRAISED_BY_TXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:APPRAISED_SCORE_FIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:OTHER_INFO_TXTVIEW];
    [homeFinalVCFormDataDict setObject:@"" forKey:LAST_SERVICE_DATE_TXTFIELD];
    
    // Finance Stage
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_DATE_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_OWNERS_NAME_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_PHONE_NO_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_EMAIL_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_PAYOUT_TEXTFIELD];
    [homeFinalVCFormDataDict setObject:@"" forKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];

    
    AppRaiseAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    
    int totalSwitches = [appdelegate switchTagValue];
    for (int i = 1; i < totalSwitches; i++)
    {
        [ homeFinalVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(NO) forKey:SWITCH_DICTIONARY_KEY(i)];
    }
    
    for (int j =1; j < 10; j++) 
    {
        [ homeFinalVCFormDataDict setObject:FILTER_DICTIONARY_VALUE(YES) forKey:FILTER_DICTIONARY_KEY(j)];
    }
    
    [photoCollectDict removeAllObjects];
    
    // Again updating to zero
    [appdelegate setSwitchTagValue:0];
    
    */
    

    
    // Resetting all the switches to NO and data values to @""
    // And restting the Photos dictionary
    APAppController *appController = [APAppController sharedAppController];
    [appController resetAllTheFormValues];
    

    
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


- (void)scrollRectToVisible:(CGRect)targetRect{
    
    [self.finalStageScrollView scrollRectToVisible:targetRect animated:YES];
    
}

#pragma mark - Custom Switch -

- (APCustomSwitch*)createOutRightPurchasesSwitchWithTag:(int)switchTag andStatus:(BOOL)status forRect:(CGRect)theFrame{
    
    NSArray *nibViews       = [[NSBundle mainBundle] loadNibNamed:@"APCustomSwitch" owner:self options:nil];
    APCustomSwitch *cSwitch = (APCustomSwitch*)[nibViews lastObject];
    cSwitch.frame           = theFrame;
    cSwitch.tag             = switchTag;
    [cSwitch setSwitchStatus:[[homeFinalVCFormDataDict objectForKey:SWITCH_DICTIONARY_KEY(switchTag)] boolValue]];
    cSwitch.delegate        = self;
    [self.finalStageView addSubview:cSwitch];
    
    return cSwitch;
}


- (void)onOffButtonActionDelegate:(BOOL)switchStatus withSwitchTag:(NSInteger)switchTag
{
    NSLog(@"switchStatus %d,switchTag %d",switchStatus,(int)switchTag);
    
    [self resignAllFirstResponders];
    [self datePickerResignAction];
    [self settingScrollviewFrame:YES withAnimation:NO];

    
    [homeFinalVCFormDataDict setObject:SWITCH_DICTIONARY_VALUE(switchStatus) forKey:SWITCH_DICTIONARY_KEY(switchTag)];
    
    NSString *switchStatusStr = (self.outrightPurchasesSwitch.isSwitchStatusOn)?@"YES":@"NO";
    [homeFinalVCFormDataDict setObject:switchStatusStr forKey:OUTRIGHT_PURCHASES_SWITCH];
    
}

#pragma mark- PDF - Delegate -

- (void)didSucssessFullInDrawingOfPDFFromHtml:(id)anyObject{
    [self showEmailViewController];
}

- (void)didFailedInDrawingOfPDFFromHtml:(id)anyObject{
    NSLog(@"Failed in drawing PDF");
}


- (void)showEmailViewController{
    [APCommon dismissProgressAlertView];
    [self configureReachability];
    if (netStatus != NotReachable)  //(1 == 1)//
    {
        // Preparing Email view controller
        [self preparingMailViewContrller];
        
        [homeFinalVCFormDataDict setObject:[NSNumber numberWithBool:YES] forKey:VEHICLE_FILE_SEND];
    }
    else
    {
        [homeFinalVCFormDataDict setObject:[NSNumber numberWithBool:NO] forKey:VEHICLE_FILE_SEND];
        UIAlertView *alert  =   [[UIAlertView alloc] initWithTitle:APP_NAME message:NETWORK_ERROR_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag           =   NETWORK_ERROR_MSG_TAG;
        [alert show];
        [alert release];
    }
}

@end
