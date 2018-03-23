//
//  APConstants.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#define APP_NAME                                 @"App Raise"

//file extension

#define EXT_PNG                                  @"png"	
#define EXT_JPG                                  @"jpg"
#define EXT_HTML                                 @"html"
#define PHOTO_KEY(KEY)                           [NSString stringWithFormat:@"Photo_%d",KEY]

#define EMAIL_DICTIONARY_KEY(KEY)                [NSString stringWithFormat:@"Email_%d",KEY]


#define SWITCH_STAGE_WISE_KEY(STAGE,KEY)            [NSString stringWithFormat:@"STAGE_%d_SWITCH_%d",STAGE,KEY]

#define SWITCH_DICTIONARY_KEY(KEY)               [NSString stringWithFormat:@"%d",KEY]
#define SWITCH_DICTIONARY_VALUE(KEY)             [NSNumber numberWithBool:KEY]

#define FILTER_DICTIONARY_KEY(KEY)               [NSString stringWithFormat:@"Filter %d",KEY]
#define FILTER_DICTIONARY_VALUE(KEY)             [NSNumber numberWithBool:KEY]

#define TYRES_DICTIONARY_KEY                     @"TyresNeeded"
#define TYRES_DICTIONARY_VALUE(KEY)             [NSNumber numberWithInt:KEY]


#define AP_HOST_NAME                              @"www.google.com"
#define NETWORK_ERROR_MSG_TAG                     9999
#define NETWORK_ERROR_MSG                   @"Your data saved. \n You are not in WIFI range at present. You can resend this from view all screen when you are in WIFI range,"

#define VEHICLE_ENTITY_NAME                      @"Vehicle"

#define DATA_COMPRESSOR_KEY                     @"DataCompressor"

#define VEHICLE_RECORD_ID                        @"RecordID"
#define VEHICLE_FILE_SEND                        @"FileSend"
#define VEHICLE_MODIFIED_FILE_NAME               @"ModifiedPDFFileName"
#define VEHICLE_RECORD_CREATED_DATE              @"RecordCreatedDate"
#define VEHICLE_RECORD_DATA                      @"RecordData"
#define VEHICLE_PDF_FILENAME                     @"PdfFileName"

#define VEHICLEPDF_FILENAME(MODIFIED_FNAME,DATE,UUID,RECORDID) [NSString stringWithFormat:@"Vechile_%@_%@_%@_%d.pdf",MODIFIED_FNAME,DATE,UUID,RECORDID]


// First Stage
#define MAKE_TXTFIELD                             @"Make"
#define MODEL_TXTFIELD                            @"Model"
#define TYPE_TXTFIELD                             @"Type"
#define REGO_NO_TXTFIELD                          @"RegoNumber"
#define EXPIRY_DATE_TXTFIELD                      @"ExpiryDate"
#define ODOMETER_READING_TXTFIELD                 @"OdometerReading"

// Second Stage
#define BUILT_YEAR_TXTFIELD                       @"BuiltYear"
#define COMPLIANCE_YEAR_TXTFIELD                  @"ComplianceYear"
#define EXTERIOR_COLOR_TXTFIELD                   @"ExteriorColor"
#define INTERIOR_COLOR_TXTFIELD                   @"InteriorColor"
#define ENGINE_SIZE_TXTFIELD                      @"EngineSize"
#define CYLINDERS_TXTFIELD                        @"Cylinders"

// Third Stage
#define GEARS_TXTFIELD                            @"Gears"
#define LAST_SERVICE_DATE_TXTFIELD                @"LastServiceDate"



// Fincance Stage
#define FINANCE_DATE_TEXTFIELD                      @"FinanceDateTextField"
#define FINANCE_OWNERS_NAME_TEXTFIELD                       @"OwnersNameTextField"
#define FINANCE_PHONE_NO_TEXTFIELD                          @"PhoneNoTextField"
#define FINANCE_EMAIL_TEXTFIELD                             @"EmailTextField"

#define FINANCE_OWING_SWITCH                        @"FinanceOwingSwitch"

#define FINANCE_FINANCIER_NAME_TEXTFIELD                    @"FinancierNameTextField"
#define FINANCE_CURRENT_REPAYMENTS_TEXTFIELD                @"CurrentRepaymentTextFields"
#define FINANCE_PAYOUT_TEXTFIELD                    @"FinancePayoutTextFields"
#define FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD         @"NewPyamnetsAffordabilityTextField"





// Fourth Stage & Final Stage

#define VIN_NO_TXTFIELD                           @"VinNo"
#define MECHANICALS_TXTVIEW                       @"Mechanicals"
#define PANEL_WORK_TXTVIEW                        @"PanelWork"

#define APPRAISED_BY_TXTFIELD                     @"AppraisedBy"
#define APPRAISAL_DATE_TXTFIELD                   @"AppraisalDate"
#define APPRAISED_SCORE_FIELD                     @"AppraisedScore"
#define OTHER_INFO_TXTVIEW                        @"OtherInfoTxtView"

#define OUTRIGHT_PURCHASES_SWITCH                 @"OutrightPurchasesSwitch"


// total switches
#define TOTAL_SWITCHES_COUNT                           @"TotalSwitchesCount"









#define kStageoneSwitchXValue                    [NSArray arrayWithObjects:@"0",@"100",@"200", nil]
#define kStageoneSwitchYValue                    [NSArray arrayWithObjects:@"227",@"306",@"382",@"457",@"526", nil]

#define kStageTwoSwitchXValue                     196
#define kStageTwoSwitchYValue                    [NSArray arrayWithObjects:@"260",@"303",@"346", @"426", @"468", @"510", @"549", @"590", @"632", @"811",@"851",@"892",@"933", nil]

#define kStageThirdSwitchX1Value                  205
#define kStageThirdSwitchX2Value                  160
#define kStageThirdFilterXValue                   264

#define kStageThirdSwitchYValue                  [NSArray arrayWithObjects:@"19",@"66",@"112",@"159",@"329",@"376",@"422",@"465",@"515",@"562",@"608",@"651",@"695",@"739",@"854", nil]
#define kStageThirdFilterYValue                  [NSArray arrayWithObjects:@"330",@"378",@"422",@"467",@"515",@"564",@"609",@"653",@"697", nil]

#define kStageFinanceSwitchXValue                     196
#define kStageFinanceSwitchYValue                    [NSArray arrayWithObjects:@"275", nil]

#define kStageFinalStageOutrightPurchaseSwitchXValue                     196
#define kStageFinalStageOutrightPurchaseSwitchYValue                    [NSArray arrayWithObjects:@"220", nil]


#define DRAWING_MAKEFIELD_ORIGIN                   CGPointMake(85,617)
#define DRAWING_MODELFIELD_ORIGIN                  CGPointMake(85,567)
#define DRAWING_TYPEFIELD_ORIGIN                   CGPointMake(85,512)
#define DRAWING_REGONOFIELD_ORIGIN                 CGPointMake(85,157)
#define DRAWING_EXPIRYDATEFIELD_ORIGIN             CGPointMake(85,106)
#define DRAWING_ODOMETERFIELD_ORIGIN               CGPointMake(85,52)

#define DRAWING_BUILTYEARFIELD_ORIGIN              CGPointMake(415,617)
#define DRAWING_COMPLIANCEYEARFIELD_ORIGIN         CGPointMake(415,562)
#define DRAWING_VINNOFIELD_ORIGIN                  CGPointMake(390,512)
#define DRAWING_EXTERIORCOLORFIELD_ORIGIN          CGPointMake(390,460)
#define DRAWING_INTERIORCOLORFIELD_ORIGIN          CGPointMake(390,407)
#define DRAWING_ENGINESIZEFIELD_ORIGIN             CGPointMake(390,232)
#define DRAWING_CYLINDERSFIELD_ORIGIN              CGPointMake(390,182)

#define DRAWING_GEARSFIELD_ORIGIN                 CGPointMake(75,464)

#define DRAWING_MECHANICALSTVIEW_ORIGIN            CGPointMake(338,302)
#define DRAWING_PANELWORKTVIEW_ORIGIN              CGPointMake(338,12)

#define DRAWING_APPRAISEDBYFIELD_ORIGIN            CGPointMake(88,652)
#define DRAWING_APPRAISALDATEFIELD_ORIGIN          CGPointMake(88,597)
#define DRAWING_APPRAISALSCOREFIELD_ORIGIN         CGPointMake(148,527)
#define DRAWING_APPRAISALFINALVALUEFIELD_ORIGIN    CGPointMake(40,47)
#define DRAWING_OTHERINFOTVIEW_ORIGIN              CGPointMake(320,542)

#define kStageOneSwitchXValue_drawing             [NSArray arrayWithObjects:@"20",@"108",@"196", nil]
#define kStageoneSwitchYValue_drawing             [NSArray arrayWithObjects:@"438",@"378",@"322",@"258",@"202", nil]

#define kStageTwoSwitchXValue_drawing            494
#define kStageTwoSwitchYValue_drawing            [NSArray arrayWithObjects:@"362",@"323",@"282",@"132",@"92",@"50", nil]

#define kStageThirdSwitchX1Value_drawing          190
#define kStageThirdSwitchY1Value_drawing          [NSArray arrayWithObjects:@"657",@"612",@"570",@"522", nil]

#define kStageThirdSwitchX2Value_drawing          140
#define kStageThirdSwitchY2Value_drawing          [NSArray arrayWithObjects:@"362",@"322",@"277",@"235",@"192",@"147",@"102",@"62",@"22", nil]

#define kStageThirdFilterXValue_drawing           245
#define kStageThirdFilterYValue_drawing          [NSArray arrayWithObjects:@"362",@"322",@"277",@"235",@"192",@"147",@"102",@"62",@"22", nil]

#define kTyresNeededXValues_drawing              [NSArray arrayWithObjects:@"336",@"411",@"456",@"502",@"549", nil]
#define kTyresNeededYValues_drawing               615

#define kPhotsYValues_drawing                   [NSArray arrayWithObjects:@"372",@"202",@"32", nil]
#define kPhotsXValues_drawing                   360





