//
//  APReportViewController.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APReportViewController.h"
#import "APPDFDisplayViewController.h"
#import "APCoreDataHelper.h"
#import "Vehicle.h"
#import "APCommon.h"
#import "APConstants.h"

@interface APReportViewController ()

- (void)preparingMailViewContrller:(Vehicle*)theVehicle;
- (void)activityIndicatorAlertViewWithMessage:(NSString*)message;
- (void)configureReachability;
- (void)updateInterfaceWithReachability:(Reachability*)curReach;

@end

@implementation APReportViewController
@synthesize hometab;
@synthesize acuraTab;
@synthesize selectedMonthLbl;
@synthesize savedRecordsTbl;
@synthesize vehicleRecordsArray;
@synthesize selectedMothRecords;
@synthesize selectedMonth;
@synthesize monthString;
@synthesize bgImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [selectedMonthLbl release];
    [savedRecordsTbl release];
    [hometab release];
    [acuraTab release];
    self.vehicleRecordsArray = nil;
    self.selectedMothRecords = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.selectedMonthLbl.text = self.monthString;
    [self updateBgImageForIPhone5];
}

- (void)viewDidLoad
{
    self.vehicleRecordsArray = [[APCoreDataHelper sharedCoreDataHelper] listAllVehicleRecords];
    NSMutableArray *tempList = [[NSMutableArray alloc] init];
    self.selectedMothRecords = tempList;
    [tempList release];
    [self getSelctedMonthRecords:self.selectedMonth];
    [self.savedRecordsTbl reloadData];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;

        [self.savedRecordsTbl setContentInset:UIEdgeInsetsMake(-30, 0, 0, 0)];
    }
}

- (void)viewDidUnload
{
    [self setSelectedMonthLbl:nil];
    [self setSavedRecordsTbl:nil];
    [self setHometab:nil];
    [self setAcuraTab:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)deleteRecordsBtnAction:(id)sender 
{
    [[APCoreDataHelper sharedCoreDataHelper] deleteLastOneMonthrecords];
}

#pragma mark ......
#pragma mark TABLE VIEW DATA SOURCE & DELEGATE _ METHODES
#pragma mark ......

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: numberOfSectionsInTableView.
// Parameters	: tableView		 
// Return type	: NSInteger
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: numberOfRowsInSection.
// Parameters	: tableView, section		 
// Return type	: NSInteger
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.selectedMothRecords count];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: cellForRowAtIndexPath.
// Parameters	: tableView,indexPath		 
// Return type	: UITableViewCell
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ResendCellIdntifier";
    
    APResendTableViewCell *resendCell = (APResendTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (resendCell == nil)
    {
        NSArray *nibViews   = [[NSBundle mainBundle] loadNibNamed:@"APResendTableViewCell" owner:self options:nil];
        resendCell          = (APResendTableViewCell*)[nibViews lastObject];
        resendCell.delegate = self;
    }
    Vehicle *thevehicle             = [self.selectedMothRecords objectAtIndex:indexPath.row];
    resendCell.reSendText.text      =  thevehicle.modifiedFileName;
    resendCell.cellIndex            = indexPath.row;
   
   return resendCell;
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: didSelectRowAtIndexPath.
// Parameters	: tableView,indexPath		 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    APPDFDisplayViewController *pdfDisplayVC = [[APPDFDisplayViewController alloc] initWithNibName:@"APPDFDisplayViewController" bundle:nil];
    pdfDisplayVC.pdfFileName     = [(Vehicle *)[self.selectedMothRecords objectAtIndex:indexPath.row] pdfFileName];
    [self.navigationController pushViewController:pdfDisplayVC animated:YES];
    [pdfDisplayVC release];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(tabBar.selectedItem == self.hometab)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acuramultimedia.com"]];
    }
}

- (IBAction)onHomeButtonAction:(id)sender{

     [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAcuraButtonAction:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.acuramultimedia.com"]];
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getSelctedMonthRecords.
// Parameters	: selectedMonth 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)getSelctedMonthRecords:(NSInteger)_selectedMonth
{    
    if ([self.selectedMothRecords count] > 0) 
    {
        [self.selectedMothRecords removeAllObjects];
    }
    
    
    for (Vehicle *object in self.vehicleRecordsArray) 
    {
        // NSLog(@"all records: %@ and count is:%d" ,self.recordsList ,[self.recordsList count] );
        
        if ([[APCommon getMonthFromDate:object.recordCreatedDate] intValue] == _selectedMonth) 
        {
            [self.selectedMothRecords addObject:object];
        }
    }
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

- (void)reSendBtnDelegateAction:(APResendTableViewCell*)selectedCell
{
    NSLog(@"reSendBtnDelegateAction");
    [self configureReachability];
    if (netStatus != NotReachable)  //(1 == 1)//
    {
        Vehicle *thevehicle             = [self.selectedMothRecords objectAtIndex:selectedCell.cellIndex];
        [self preparingMailViewContrller:thevehicle];
    }
    else
    {
        UIAlertView *alert  =   [[UIAlertView alloc] initWithTitle:APP_NAME message:NETWORK_ERROR_MSG delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag           =   NETWORK_ERROR_MSG_TAG;
        [alert show];
        [alert release];
    }

}

- (void)preparingMailViewContrller:(Vehicle*)theVehicle
{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.navigationBar.barStyle       = UIBarStyleBlack;
    
    if([MFMailComposeViewController canSendMail])
    {
        mailController.mailComposeDelegate = self;
                
        if([APCommon emailDictionaryCount] > 0)
        {
            [mailController setToRecipients:[APCommon emailsDictionaryValues]];
        }
        
        NSString *fileTitle = theVehicle.modifiedFileName;
        
        [mailController setSubject:[NSString stringWithFormat:@"New %@ Submission", fileTitle]];
        [mailController setMessageBody:[NSString stringWithFormat:@"New %@ Submission", fileTitle] isHTML:NO];
        
        // NSString *mailFilePath = [saveDirectory stringByAppendingPathComponent:MAIL_SHORT_PDF];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *saveDirectory = [paths objectAtIndex:0];
        
        NSString *saveFileName = theVehicle.pdfFileName;
        
        NSString *filePath = [saveDirectory stringByAppendingPathComponent:saveFileName];
        // NSString *filePath = [NDGlobal getFilePathForMAil:saveFileName];
        
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        
        [mailController addAttachmentData:fileData mimeType:@"Application/PDF" fileName:[NSString stringWithFormat:@"%@.pdf",fileTitle]];
		
        //[self presentModalViewController:mailController animated:YES];
        [self presentViewController:mailController animated:YES completion:nil];
        
    }
    [mailController release];
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


- (BOOL)isThisIPhone5Device{
    
    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"viewAllrecordsBg-568h.png"]];
    }
}


@end
