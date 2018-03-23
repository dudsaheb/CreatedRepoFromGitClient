//
//  APHomeFinalStageVC.h
//  AppRaise
//
//  Created by anilOruganti on 21/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Reachability.h"
#import "PSDatePickerViewController.h"
#import "APAppraiseView.h"
#import "NDHTMLtoPDF.h"
#import "SACreatePDFFromHTML.h"
#import "APCustomSwitch.h"

@interface APHomeFinalStageVC : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate,PSDatePickerViewControllerDelegate,APAppraiseViewDelegate,NDHTMLtoPDFDelegate,APCustomSwitchDelegate,SACreatePDFFromHTMLDelegate>
{
    UITextView *otherInfoTxtView;
    UINavigationBar *keyBoardNavBar;
    UIPickerView *appraisedScorePicker;
    UIView *appraisedScorePickerView;
    UILabel *appraisedScoreLabel;
    UITextField *appraisalDateTxtField;
    UIScrollView *finalStageScrollView;
    UIView *finalStageView;
    UITextField *appraisedByTxtField;
    UILabel *appraisedScore;
    NSArray *appraisedScoreArray;
    NSMutableDictionary *photoCollectDict;
    NSMutableDictionary *homeFinalVCFormDataDict;
    IBOutlet UILabel *otherInfoPlaceHolderLbl;
    PSDatePickerViewController *customDatePicker;

    Reachability                * hostReach;
    Reachability                * internetReach;
    Reachability                * wifiReach;
    NetworkStatus               netStatus;
   // NDHTMLtoPDF *PDFCreator;


    SACreatePDFFromHTML *pdfFromHtml;
    
    APCustomSwitch *outrightPurchasesSwitch;
    
    MFMailComposeViewController *mailController;

}
@property (nonatomic, retain) IBOutlet UITextField *appraisedByTxtField;
@property (nonatomic, retain) IBOutlet UILabel *appraisedScore;
@property (nonatomic, retain) IBOutlet UITextField *appraisalDateTxtField;
@property (nonatomic, retain) IBOutlet UIScrollView *finalStageScrollView;
@property (nonatomic, retain) IBOutlet UIView *finalStageView;
@property (nonatomic, retain) IBOutlet UITextView *otherInfoTxtView;
@property (nonatomic, retain) IBOutlet UINavigationBar *keyBoardNavBar;
@property (nonatomic, retain) IBOutlet UIPickerView *appraisedScorePicker;
@property (nonatomic, retain) IBOutlet UIView *appraisedScorePickerView;
@property (nonatomic, retain) IBOutlet UILabel *appraisedScoreLabel;

- (IBAction)dropDownBtnAction:(id)sender;
- (IBAction)otherInfoBtnAction:(id)sender;
- (IBAction)takePhotoBtnAction:(id)sender;
- (IBAction)viewPhotoBtnAction:(id)sender;
- (IBAction)submitBtnAction:(id)sender;
- (IBAction)keyBoardResignButtonAction:(id)sender;
- (IBAction)appraisedScorePickerDoneBtnAction:(id)sender;
- (IBAction)appRaiseDateButtonClickedAction:(id)sender;
- (IBAction)appRaiseButtonAction:(id)sender;

@property (nonatomic,assign) CGFloat extraHeightIfItIsIPhone5Device;
@property (nonatomic,assign) CGFloat extraYPossitionForTextFieldVisibility;
@property (nonatomic, retain) IBOutlet UIView *keyboardAccessaryView;
@property (nonatomic,retain) IBOutlet UIImageView *bgImageView;

//@property (nonatomic, retain) NDHTMLtoPDF *PDFCreator;

@property (nonatomic, retain) SACreatePDFFromHTML *pdfFromHtml;

@property (nonatomic,retain) APCustomSwitch *outrightPurchasesSwitch;

@property (nonatomic,retain) MFMailComposeViewController *mailController;


@end
