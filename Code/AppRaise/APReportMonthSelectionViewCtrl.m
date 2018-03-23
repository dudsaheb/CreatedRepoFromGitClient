//
//  APReportMonthSelectionViewCtrl.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APReportMonthSelectionViewCtrl.h"
#import "APReportViewController.h"
#import "APCommon.h"
#import "APConstants.h"

@interface APReportMonthSelectionViewCtrl ()

- (void)initalizeDataObjecs;

@end

@implementation APReportMonthSelectionViewCtrl
@synthesize monthPicker;
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
    [monthPicker release];
    [super dealloc];
}

- (void)initalizeDataObjecs
{
    // Custom initialization
    monthsListArray = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil ];
    yearsListArray = [[NSMutableArray alloc] init];
    for (int year = 2001; year <=2300 ; year++) 
    {
        [yearsListArray addObject:[NSString stringWithFormat:@"%d",year]];
    }
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
    [self updateBgImageForIPhone5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initalizeDataObjecs];
    
    [monthPicker selectRow:[[APCommon getMonthFromDate:[NSDate date]] intValue] - 1 inComponent:0 animated:YES];
    [monthPicker selectRow:[yearsListArray indexOfObject:[APCommon getYearFromDate:[NSDate date]]] inComponent:1 animated:YES];


    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMonthPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    return 2;
}

- (NSInteger) pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger) component
{
    NSInteger pickerDataCount;
    if (component == 0) 
    {
        pickerDataCount = [monthsListArray count];
    }
    else
    {
        pickerDataCount = [yearsListArray count];
    }
    return pickerDataCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSString *pickerData;
    if (component == 0) 
    {
        pickerData = [monthsListArray objectAtIndex:row];
    }
    else
    {
        pickerData = [yearsListArray objectAtIndex:row];
    }
    
    return pickerData;
}

- (void) pickerView:(UIPickerView *) pickerView didSelectRow:(NSInteger) row inComponent:(NSInteger) component
{
    
}

- (IBAction)doneBtnAction:(id)sender 
{
    APReportViewController *reportVC = [[APReportViewController alloc] initWithNibName:@"APReportViewController" bundle:nil];
    reportVC.selectedMonth             = [monthPicker selectedRowInComponent:0] + 1;
    reportVC.hidesBottomBarWhenPushed = YES;
    
    reportVC.monthString = [NSString stringWithFormat:@"%@ %@",[monthsListArray objectAtIndex:[monthPicker selectedRowInComponent:0]],[yearsListArray objectAtIndex:[monthPicker selectedRowInComponent:1]]];

    
    [self.navigationController pushViewController:reportVC animated:YES];
    
    /*
    reportVC.selectedMonthLbl.text = [NSString stringWithFormat:@"%@ %@",[monthsListArray objectAtIndex:[monthPicker selectedRowInComponent:0]],[yearsListArray objectAtIndex:[monthPicker selectedRowInComponent:1]]];
     */
    
    [reportVC release];
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

- (void)updateBgImageForIPhone5{
    
    if ([self isThisIPhone5Device]) {
        [self.bgImageView setImage:[UIImage imageNamed:@"PickerBg-568h.png"]];
    }
}


@end
