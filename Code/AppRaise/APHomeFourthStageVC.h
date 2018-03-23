//
//  APHomeFourthStageVC.h
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppraiseView.h"

@interface APHomeFourthStageVC : UIViewController<APAppraiseViewDelegate> 
{
    
    UIView *fourthStageView;
    UITextView *mechanicalTxtView;
    UITextView *panelWorkTxtView;
    UINavigationBar *keyboardNavBar;
    UIScrollView *fourthStageScrollView;
    UIButton *btnNone;
    UIButton *btnOne;
    UIButton *btnTwo;
    UIButton *btnThree;
    UIButton *btnFour;
    NSMutableDictionary *homeFourthVCFormDataDict;
    IBOutlet UILabel *mechanicalPlaceHolderLbl;

    IBOutlet UILabel *panelWorkPlaceHolderLbl;
    BOOL btnOneStatus;
    BOOL btnTwoStatus;
    BOOL btnThreeStatus;
    BOOL btnFourStatus;
    BOOL btnNoneStatus;
    BOOL dataCollection2DictionaryStatus;
}
@property (nonatomic, retain) IBOutlet UIView *fourthStageView;
@property (nonatomic, retain) IBOutlet UITextView *mechanicalTxtView;
@property (nonatomic, retain) IBOutlet UITextView *panelWorkTxtView;
@property (nonatomic, retain) IBOutlet UINavigationBar *keyboardNavBar;
@property (nonatomic, retain) IBOutlet UIScrollView *fourthStageScrollView;
@property (nonatomic, retain) IBOutlet UIButton *btnNone;
@property (nonatomic, retain) IBOutlet UIButton *btnOne;
@property (nonatomic, retain) IBOutlet UIButton *btnTwo;
@property (nonatomic, retain) IBOutlet UIButton *btnThree;
@property (nonatomic, retain) IBOutlet UIButton *btnFour;


- (IBAction)backButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;
- (IBAction)btnOneAction:(id)sender;
- (IBAction)btnTwoAction:(id)sender;
- (IBAction)btnThreeAction:(id)sender;
- (IBAction)btnFourthAction:(id)sender;
- (IBAction)btnNoneAction:(id)sender;
- (IBAction)keyBoardResignButtonAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;

@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,assign) CGFloat extraYPossitionForTextFieldVisibility;
@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

@property (nonatomic, retain) IBOutlet UIView *keyboardAccessaryView;


@end
