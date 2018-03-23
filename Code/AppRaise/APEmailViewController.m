//
//  APEmailViewController.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APEmailViewController.h"
#import "APCommon.h"
#import "APConstants.h"

#define kTotalEmailFields 6
#define kKeyboardHeight 220
#define kRowHeight 50.0

@interface APEmailViewController (Private){

}


- (void)initalizeDataObjecs;
- (void)fillMailAddressIntoDictionary;
- (void)updateUserDefaults;
- (void)tableViewReload;
- (void)moveUpAndDownContentView:(BOOL)isUp;
- (void)insertTableCell;
- (NSString*)getCellTextForRow:(NSInteger)row;
- (void)reloadEmailTable;
- (void)updateEmailTable;
- (BOOL)validateEmailDataAndSave:(NSString*)emailAddress atIndex:(NSInteger)cellIndex;

@end

@implementation APEmailViewController
@synthesize emailTableview;
@synthesize delegate;
@synthesize cellCount;
@synthesize currentEmail;
@synthesize currentCellId;

@synthesize bgImageView;
@synthesize tableViewOriginalContentSize;
@synthesize currentEmailCell;
@synthesize bottomContraintForTableView;

@synthesize originalBottomContraintValueForTableView;
@synthesize enterPrestartButton;


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
    [emailTableview release];
    [emailDictionary release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)initalizeDataObjecs
{
    self.cellCount = 1;
    emailDictionary =[[NSMutableDictionary alloc] init];
    [self fillMailAddressIntoDictionary];
    [APCommon sharedCommon]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initalizeDataObjecs];
    // Do any additional setup after loading the view from its nib.
    
    //self.enterPrestartButton.layer.cornerRadius =
    //[self.enterPrestartButton.layer setBorderWidth:1.5f];
    //[self.enterPrestartButton.layer setCornerRadius:30.0f];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.emailTableview setBackgroundColor:[UIColor clearColor]];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.originalBottomContraintValueForTableView = self.bottomContraintForTableView.constant;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isEditEmail = YES; // default YES
    [self updateBgImageForIPhone5];
}

- (void)viewDidUnload
{
    [self setEmailTableview:nil];
    [editAddressBtn release];
    editAddressBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private Methods

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: fillMailAddressIntoDictionary.
// Parameters	: 		 
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fillMailAddressIntoDictionary
{
    if ([emailDictionary count] > 0) 
    {
        [emailDictionary removeAllObjects];
    }
    
    
    /*
     self.cellCount = 1;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isInORder = YES;
    int key = 0;
    
    if ([defaults objectForKey:EMAIL_DICTIONARY_KEY(0)] != nil) 
    {
        [emailDictionary setObject:[defaults objectForKey:EMAIL_DICTIONARY_KEY(0)] forKey:EMAIL_DICTIONARY_KEY(key)];
        key++;
    }
    else
    {
        isInORder = NO;
    }
    
    if ([defaults objectForKey:EMAIL_DICTIONARY_KEY(1)] != nil) 
    {
        [emailDictionary setObject:[defaults objectForKey:EMAIL_DICTIONARY_KEY(1)] forKey:EMAIL_DICTIONARY_KEY(key)];
        key++;
    }
    else
    {
        isInORder = NO;
    }
    
    if ([defaults objectForKey:EMAIL_DICTIONARY_KEY(2)] != nil) 
    {
        [emailDictionary setObject:[defaults objectForKey:EMAIL_DICTIONARY_KEY(2)] forKey:EMAIL_DICTIONARY_KEY(key)];
        key++;
    }
    
    if (key != 0) 
    {
        self.cellCount = ([emailDictionary count] < kTotalEmailFields) ? [emailDictionary count]+1 : kTotalEmailFields;
        
    }
    
    if (!isInORder) 
    {
        [self updateUserDefaults];
    }
    
  */
    
    
    self.cellCount = 1;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isInORder = YES;
    int key = 0;
    
    for (int i=0; i< kTotalEmailFields; i++) {
        
        if ([defaults objectForKey:EMAIL_DICTIONARY_KEY(i)] != nil)
        {
            [emailDictionary setObject:[defaults objectForKey:EMAIL_DICTIONARY_KEY(i)] forKey:EMAIL_DICTIONARY_KEY(key)];
            key++;
        }
        else
        {
            isInORder = NO;
        }
        
    }
    
    
    if (key != 0)
    {
        self.cellCount = ([emailDictionary count] < kTotalEmailFields) ? [emailDictionary count]+1 : kTotalEmailFields;
        
    }
    
    if (!isInORder)
    {
        [self updateUserDefaults];
    }
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: updateUserDefaults
// Parameters	: 		 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)updateUserDefaults
{
    [APCommon removeAllemailObjects];
    
    for ( int j = 0;  j < [emailDictionary count]; j++ ) 
    {
        [[NSUserDefaults standardUserDefaults] setObject:[emailDictionary objectForKey:EMAIL_DICTIONARY_KEY(j)] forKey:EMAIL_DICTIONARY_KEY(j)];
        [APCommon addObject:[emailDictionary objectForKey:EMAIL_DICTIONARY_KEY(j)] forKey:EMAIL_DICTIONARY_KEY(j)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellCount;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celIdentifier = @"emailCellIdentifier";
    
    APEmailTableViewCell *emailCell = (APEmailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:celIdentifier];
    
    if (emailCell == nil)
    {
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"APEmailTableViewCell" owner:self options:nil];
        emailCell = (APEmailTableViewCell*)[nibViews lastObject];
        emailCell.delegate = self;
    }
    
    if ([emailDictionary count] > indexPath.row) 
    {
        emailCell.emailTextField.text = [emailDictionary objectForKey:EMAIL_DICTIONARY_KEY(indexPath.row)];
        [APCommon addObject:[emailDictionary objectForKey:EMAIL_DICTIONARY_KEY(indexPath.row)] forKey:EMAIL_DICTIONARY_KEY(indexPath.row)];
    }
    else
    {
        emailCell.emailTextField.text = @"";
    }
    if (isEditEmail) 
    {
        emailCell.emailTextField.userInteractionEnabled = isEditEmail;
    }else
    {
        emailCell.emailTextField.userInteractionEnabled = ([emailCell.emailTextField.text length] > 0) ? NO : YES;
    }   
    emailCell.cellIndex = indexPath.row;
    return emailCell;
}

- (IBAction)editAddressBtnAction:(id)sender 
{
    isEditEmail = YES;
    [self tableViewReload];
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

- (IBAction)enterPreStartBtnAction:(id)sender 
{
    if (iskeyBoardUp)
    {
        [self.view endEditing:YES];
        return;

    }
    if ([APCommon emailDictionaryCount] > 0)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
        if ([delegate respondsToSelector:@selector(loadViewWithTabBar)])
        {
            [delegate loadViewWithTabBar];
        }
    }
    else
    {
        [APCommon showAlertWithMessage:@"Specify minimum one email to proceed.."];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: tableViewReload
// Parameters	: 
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewReload
{
    [self.emailTableview reloadData];
}

#pragma mark ......
#pragma mark SAVE BUTTONA DELEGATE IMPLIMENTATION _ METHODE
#pragma mark ......

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: saveBtnActionDelegate fromSave
// Parameters	: emailcell, isFromSave
// Return type	: void
// Comments     : 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)saveBtnActionDelegate:(APEmailTableViewCell*)emailcell fromSave:(BOOL)isFromSave
{
    self.currentEmailCell   = emailcell;
    self.currentEmail       = emailcell.emailTextField.text;
    self.currentCellId      =  emailcell.cellIndex;
    
    if (isFromSave) 
    {
        if([self validateEmailDataAndSave:emailcell.emailTextField.text atIndex:emailcell.cellIndex]) 
        {
            emailcell.emailTextField.userInteractionEnabled = NO;
            [self updateEmailTable];
        }
        else if ([emailcell.emailTextField.text length] == 0 && [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)];
            [[APCommon sharedCommon] removeObjectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)];
            [self fillMailAddressIntoDictionary];
            [self reloadEmailTable];
        }
    }
    else
    {
        if ([emailcell.emailTextField.text length] == 0 && [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)]) 
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)];
            [[APCommon sharedCommon] removeObjectForKey:EMAIL_DICTIONARY_KEY(emailcell.cellIndex)];
            [self fillMailAddressIntoDictionary];
            [self reloadEmailTable];
        } 
        else
        {
            UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"Data modified. Do u want to save changes ?" delegate:self cancelButtonTitle:@"YES"otherButtonTitles:@"NO", nil];
            saveAlert.tag = 99999;
            [saveAlert show];
            [saveAlert release];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: validateEmailDataAndSave atIndex
// Parameters	: emailAddress,cellIndex
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)validateEmailDataAndSave:(NSString*)emailAddress atIndex:(NSInteger)cellIndex
{
    BOOL isSuccess = NO;
    if ([emailAddress length] > 0)
    {
        if ([APCommon validateEmail:emailAddress]) 
        {
            [[NSUserDefaults standardUserDefaults] setObject:emailAddress forKey:EMAIL_DICTIONARY_KEY(cellIndex)];
            [APCommon addObject:emailAddress forKey:EMAIL_DICTIONARY_KEY(cellIndex)];
            isSuccess = YES;
            
        }else
        {
            [APCommon showAlertWithMessage:@"Specify valid email."];
        }
    }
    else
    {
        [APCommon showAlertWithMessage:@"Specify email."];
    }
    return  isSuccess;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: moveUpAndDownContentView
// Parameters	: isUp
// Return type	: Void
// Comments     : 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)moveUpAndDownContentView:(BOOL)isUp
{
    
    //self.tableViewOriginalContentSize = self.emailTableview.contentSize;

    CGFloat variableHeight = kKeyboardHeight;
    
    if (isUp) {
        
        /*
         
        self.emailTableview.contentSize = CGSizeMake(self.tableViewOriginalContentSize.width, self.tableViewOriginalContentSize.height+variableHeight);

        NSInteger index = self.currentEmailCell.cellIndex;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.emailTableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        */
        
        self.bottomContraintForTableView.constant = variableHeight;
        
        [self.emailTableview scrollRectToVisible:self.currentEmailCell.emailTextField.frame animated:YES];
        
    } else {
    
        //self.emailTableview.contentSize = CGSizeMake(self.tableViewOriginalContentSize.width, self.tableViewOriginalContentSize.height-variableHeight);
        
        self.bottomContraintForTableView.constant = self.originalBottomContraintValueForTableView;
    }
    
    /*
    if ([self isThisIPhone5Device]) {
        return;
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.view.frame = (isUp)? CGRectMake(self.view.frame.origin.x, -100, self.view.frame.size.width, self.view.frame.size.height) : CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    */
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: reloadEmailTable.
// Parameters	: 
// Return type	: VOID
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadEmailTable
{
    if (self.cellCount == 0) 
    {
        self.cellCount = 1;
    }
    [self.emailTableview reloadData];
}


#pragma mark ......
#pragma mark TEXTFIELD _ DELIGATE METHODES
#pragma mark ......

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: TextFields Delegate Methodes
// Parameters	: textField,,textField
// Return type	: BOOL,Void,Void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)textFieldBeginDelegate:(APEmailTableViewCell*)emailcell
{
    iskeyBoardUp = YES;
    [self moveUpAndDownContentView:YES];

}

- (void)textFieldEndDelegate:(APEmailTableViewCell*)emailcell
{
    iskeyBoardUp = NO;
    [self moveUpAndDownContentView:NO];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: updateEmailTable
// Parameters	: 
// Return type	: void
// Comments     : 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateEmailTable
{
    if(editAddressBtn.enabled == NO)
    {
        editAddressBtn.enabled = YES;
    }
    
    /*
     
    if(self.cellCount < kTotalEmailFields)
    {
        switch (self.currentCellId) 
        {
            case 0:
                if (self.currentCellId < 2) 
                {
                    self.cellCount = 2;
                    [self insertTableCell];
                }
                break;
                
            case 1:
                self.cellCount = 3;
                [self insertTableCell];
                break;
        }
    }
    
    */
    
    if(self.cellCount < kTotalEmailFields)
    {
        if (self.currentCellId+1 < kTotalEmailFields) {
            self.cellCount ++;
            [self insertTableCell];
        }
    }
    
    [self fillMailAddressIntoDictionary];
    [self performSelector:@selector(tableViewReload) withObject:nil afterDelay:0.5];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: insertTableCell
// Parameters	: 
// Return type	: VOID
// Comments     : 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)insertTableCell
{
    [self.emailTableview setEditing:YES];
    if ([emailTableview numberOfRowsInSection:0] == 1)
    {
        self.cellCount = 2;
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:1 inSection:0];
        NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
        [self.emailTableview insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else if ([emailTableview numberOfRowsInSection:0] == 2 && ![[self getCellTextForRow:1] isEqualToString:@"" ] && [self getCellTextForRow:1] != nil)
    {
        self.cellCount = 3;
        NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:2 inSection:0];
        NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
        [self.emailTableview insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.emailTableview setEditing:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getCellTextForRow
// Parameters	: row
// Return type	: NSString
// Comments     : 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)getCellTextForRow:(NSInteger)row
{
    return [(APEmailTableViewCell*)[emailTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]] emailTextField].text;
}

#pragma mark ......
#pragma mark ALERVIEW DELIGATE _ METHODE
#pragma mark ......

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: alertView:(UIAlertView *) clickedButtonAtIndex:(NSInteger) (alertViewDelegate)
// Parameters	: alertView,buttonIndex
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  //  NSInteger cellindex = self.currentEmailCell.cellIndex;
    
    if (alertView.tag == 99999)
    {
        if (buttonIndex == 0) 
        {
            if ([self validateEmailDataAndSave:self.currentEmail atIndex:self.currentCellId])
            {
                //[self.currentEmailCell setIsEmailSave:YES];
                [self updateEmailTable];
            }
        }
        else
        {
            if (self.cellCount == 0) 
            {
                self.cellCount = 1;
            }
            
            //[self.emailTableview reloadData];
        }
    }
}

- (BOOL)isThisIPhone5Device{
    
    BOOL isThisIPhone5 = ([[UIScreen mainScreen] bounds].size.height>480);
    
    return isThisIPhone5;
}

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"APPRaiseBg-568h.png"]];
    }
}

@end
