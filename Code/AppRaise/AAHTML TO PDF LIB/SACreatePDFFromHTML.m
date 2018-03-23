//
//  SACreatePDFFromHTML.m
//  AppRaise
//
//  Created by dud saheb on 06/06/14.
//
//

#import "SACreatePDFFromHTML.h"

#import "APConstants.h"

@interface SACreatePDFFromHTML ()
@property (nonatomic,retain) NSMutableArray *photosNamesArray;
@end

@implementation SACreatePDFFromHTML
@synthesize PDFCreator;
@synthesize htmlPageName;




#pragma mark NDHTMLtoPDFDelegate

- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *targetPdfAndPath = [NSString stringWithFormat:@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath];
    //NSLog(@"%@",targetPdfAndPath);
    
 
    
    if ([self.delegate respondsToSelector:@selector(didSucssessFullInDrawingOfPDFFromHtml:)]) {
        [self.delegate didSucssessFullInDrawingOfPDFFromHtml:targetPdfAndPath];
    }
    
    // Deletingsaved Photos
    [self deletePhotosFromDocumentsDir:self.photosNamesArray];
    
    // Removing Html file , if exists and we recreate with new values
    NSError *error = nil;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    BOOL isFileRemoved = [filemgr removeItemAtPath:[self filePathFromDocumentDir:self.htmlPageName]
                                             error:&error];
    NSLog(@"Htmlpage removed status = %@",((isFileRemoved)?@"YES":@"NO"));
    
}

- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did fail (%@)", htmlToPDF];
    NSLog(@"%@",result);
}

#pragma mark - PDF creation -
- (void) createPDFFileWithFileDataDic:(NSMutableDictionary*)fileData
                withTargetPdfFileName:(NSString*)theTargetPdfFileName
                           withPhotos:(NSMutableDictionary*)photosDict
                    andTargetHtmlPage:(NSString*)htmlPage{
    
    

    
    // Copy Html page supported files to Documents Dir
    [self copyHtmlPageSupportItemsToDocumentsFolder];
    
    // Write Photos to Documents Dir
    self.photosNamesArray = [self createPhotosToDocumentsDir:photosDict];
    
    // Adding Values to Html page
    NSString *htmlFileContent = [self targetHtmlFile:htmlPage
                               withUpdatedDictValues:fileData];
    
    // Target Html Page Name
    self.htmlPageName = [NSString stringWithFormat:@"file_%@_%@",[[NSDate date] description],htmlPage];
    self.htmlPageName = [self.htmlPageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"Target Html file name : %@",self.htmlPageName);
    
    // Copying Modified html page to Documents Dir
    NSString *targetPathForHtmlFileToDocumentsDir = [[NSString stringWithFormat:@"~/Documents/%@",self.htmlPageName] stringByExpandingTildeInPath];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSData *contentData = [htmlFileContent dataUsingEncoding:NSUTF8StringEncoding];
    [filemgr createFileAtPath:targetPathForHtmlFileToDocumentsDir
                     contents:contentData
                   attributes:nil];
    
    
    // Creating PDF from Targetted HTML Page
    NSURL *url = [self fileURLFromDocumentsDir:htmlPageName];
    NSString *pdfPath = [NSString stringWithFormat:@"~/Documents/%@",theTargetPdfFileName];
    self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:url
                                         pathForPDF:[pdfPath stringByExpandingTildeInPath]
                                           delegate:self
                                           pageSize:kPaperSizeA4_Appraise
                                            margins:UIEdgeInsetsMake(10, 5, 10, 5)];
}


#pragma mark - Documents Dir path -
- (NSURL*)fileURLFromDocumentsDir:(NSString*)fileName{
    
    NSString *filePath = [self filePathFromDocumentDir:fileName];
    
    NSURL *fileURL = nil;
    fileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];
    return fileURL;
}

#pragma mark - Get Documents Dir file path -
- (NSString *)filePathFromDocumentDir:(NSString*)fileName{

    NSString *filePath = nil;
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return filePath;
}

#pragma mark - Copying Html page Images to Documents folder -
- (void)copyHtmlPageSupportItemsToDocumentsFolder{
    
    NSURL *sourceUrl = nil;
    NSURL *destinationUrl = nil;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:
                            @"2.png",
                            @"3.png",
                           @"4.png",
                           @"5.png",
                            @"appraise1.png",
                           @"appraise2.png",
                           @"appraise3.png",
                           @"greenbutton.png",
                           @"HelveticaNeue-BoldCond.otf",
                           @"layer_1.png",
                           @"Layer20.png",
                           @"Layer23.png",
                           @"mechanicals.png",
                           @"noswitch.png",
                           @"notfitted.png",
                           @"otherinfo.png",
                           @"Panelwork.png",
                           @"reconditioning.png",
                           @"redbutton.png",
                           @"Regent~Motors~Log187.png",
                            @"yesswitch.png",
                           @"workPanel.png",
                           @"switchYes.png",
                            
                            nil];
    
    // Copying Files
    
    for (NSString *itemName in itemsArray) {
        
        NSString *filePath = [self filePathFromDocumentDir:itemName];
        BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (isFileExists == NO) {
            NSString *fileExtension = [itemName pathExtension];
            NSString *fileName = [itemName stringByDeletingPathExtension];
            sourceUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileExtension];
            
            if (sourceUrl!=nil) {
                destinationUrl = [self fileURLFromDocumentsDir:itemName];
                [filemgr copyItemAtURL:sourceUrl toURL:destinationUrl error:nil];
            } else {
                NSLog(@"Source URL is Nil for Item - %@ ",fileName);
            }
            
        }
        
    }
    

}

#pragma  mark - Create Photos to Documents Dir -
- (NSMutableArray*)createPhotosToDocumentsDir:(NSDictionary*)photosDictionary{
    NSMutableArray *namesArray = nil;
    
    int count = 1;
    namesArray = [[NSMutableArray alloc] init];
    for (UIImage *photoImg in [photosDictionary allValues]) {
        NSString *photoName = [NSString stringWithFormat:@"Photo_%@_%d.png",[[NSDate date] description],count];
        photoName = [photoName stringByReplacingOccurrencesOfString:@" " withString:@"_"];

        NSString *filePathFromDocumentsDirPath = [self filePathFromDocumentDir:photoName];
        NSData *imgData = UIImagePNGRepresentation(photoImg);
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        [fileMgr createFileAtPath:filePathFromDocumentsDirPath
                         contents:imgData
                       attributes:nil];
        
        [namesArray addObject:photoName];
        count ++;
    }
    
    return namesArray;
}

#pragma mark - Delete Photos From Documents Dir -
- (void)deletePhotosFromDocumentsDir:(NSArray*)photosNamesArray{

    for (NSString *photoName in photosNamesArray) {
        NSString *filePathFromDocumentsDirPath = [self filePathFromDocumentDir:photoName];
        
        NSError *error = nil;
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        [fileMgr removeItemAtPath:filePathFromDocumentsDirPath error:&error];
        
        if (error) {
            NSLog(@"Error - %@",[error localizedDescription]);
        }
    }

}

#pragma mark - Updating HTML with Target Dict Values -
- (NSString *)targetHtmlFile:(NSString*)htmlFile withUpdatedDictValues:(NSDictionary*)fileDataDict{
    
    NSError *error = nil;
    
    NSString *fileNameWithOutExtension = [htmlFile stringByDeletingPathExtension];
    NSString *fileExtension = [htmlFile pathExtension];

    NSString *localPath = [[NSBundle mainBundle] pathForResource:fileNameWithOutExtension ofType:fileExtension];
    
    // reading Html file data in to string Value
    NSString *htmlFileContent = [NSString stringWithContentsOfFile:localPath encoding:NSUTF8StringEncoding error:&error];
    
    
    // Collecting final values
    
    // First Stage
    NSString * make = [fileDataDict objectForKey:MAKE_TXTFIELD];
    NSString * model = [fileDataDict objectForKey:MODEL_TXTFIELD];
    NSString * type = [fileDataDict objectForKey:TYPE_TXTFIELD];
    NSString * regoNo = [fileDataDict objectForKey:REGO_NO_TXTFIELD];
    NSString * expiryDate = [fileDataDict objectForKey:EXPIRY_DATE_TXTFIELD];
    NSString * odometer = [fileDataDict objectForKey:ODOMETER_READING_TXTFIELD];
    
    
    // Second Stage
    NSString * builtYear = [fileDataDict objectForKey:BUILT_YEAR_TXTFIELD];
    NSString *complainceYear = [fileDataDict objectForKey:COMPLIANCE_YEAR_TXTFIELD];
    NSString * exteriorColor = [fileDataDict objectForKey:EXTERIOR_COLOR_TXTFIELD];
    NSString * interiorColor = [fileDataDict objectForKey:INTERIOR_COLOR_TXTFIELD];
    NSString * engineSize = [fileDataDict objectForKey:ENGINE_SIZE_TXTFIELD];
    NSString * cylinders = [fileDataDict objectForKey:CYLINDERS_TXTFIELD];
    
    
    // Third Stage
    NSString * noOfGears = [fileDataDict objectForKey:GEARS_TXTFIELD];
    NSDate * lastServiceDateObject = [fileDataDict objectForKey:LAST_SERVICE_DATE_TXTFIELD];
    NSString *lastServiceDateStr = [self formattedStringFromDate:lastServiceDateObject];

    // Fourth Stage
    NSString * mechanicalTextView = [fileDataDict objectForKey:MECHANICALS_TXTVIEW];
    NSString * pannelWorkTextView = [fileDataDict objectForKey:PANEL_WORK_TXTVIEW];
    
    // Finance Stage
    NSString *financeOwnersName = [fileDataDict objectForKey:FINANCE_OWNERS_NAME_TEXTFIELD];
    NSString * financePhoneNo = [fileDataDict objectForKey:FINANCE_PHONE_NO_TEXTFIELD];
    NSString * financeEmail = [fileDataDict objectForKey:FINANCE_EMAIL_TEXTFIELD];
    NSString *financeOwing = [fileDataDict objectForKey:FINANCE_OWING_SWITCH];
    NSString * financeFinancierName = [fileDataDict objectForKey:FINANCE_FINANCIER_NAME_TEXTFIELD];
    NSString * financeCurrentPayments = [fileDataDict objectForKey:FINANCE_CURRENT_REPAYMENTS_TEXTFIELD];
    NSString * financePayout = [fileDataDict objectForKey:FINANCE_PAYOUT_TEXTFIELD];
    NSString * financeNewPaymentsAfordability = [fileDataDict objectForKey:FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD];
    
    
    // Final Stage
    NSString * appraisedByName = [fileDataDict objectForKey:APPRAISED_BY_TXTFIELD];
    NSString * appraisedByDate = [fileDataDict objectForKey:APPRAISAL_DATE_TXTFIELD];
    NSString * appraisedScore = [fileDataDict objectForKey:APPRAISED_SCORE_FIELD];
    NSString * otherInfoTextView = [fileDataDict objectForKey:OTHER_INFO_TXTVIEW];
    
    
    
    
    
    //=================== Configuring No of Tyres Needed =======================
    NSNumber *tyresSelected = [fileDataDict objectForKey:TYRES_DICTIONARY_KEY];
    int selectedTyreIndex = [tyresSelected intValue];
    for (int j=0; j<5; j++) {
        NSString *tyresString = [NSString stringWithFormat:@"[TYRES_%d]",j];
        if (selectedTyreIndex == j) {
            htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:tyresString withString:@"checked"];
        } else {
            htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:tyresString withString:@""];
        }
    }

    
    
    
    
    //============================= Writing Photos =============================
    NSString *page3AndPhotosHtml = @"";
    NSString *page4HtmlStart = @"<div id=\"page4_html\">";
    NSString *page4HtmlEnd = @"</div>";
    NSString *page4AndPhotosHtml = @"";

    int i=0;
    for (NSString *photoName in self.photosNamesArray) {
        
        NSString *idString = [NSString stringWithFormat:@"Layer23copy%d",i];
        NSString *imgHtml = [NSString stringWithFormat:@"<div id=\"%@\"><img src=\"%@\"></div>",idString,photoName];
        page3AndPhotosHtml = [page3AndPhotosHtml stringByAppendingString:imgHtml];
        
        /*
        if(i<6){
            NSString *idString = [NSString stringWithFormat:@"Layer23copy%d",i];
           NSString *imgHtml = [NSString stringWithFormat:@"<div id=\"%@\"><img src=\"%@\"></div>",idString,photoName];
          page3AndPhotosHtml = [page3AndPhotosHtml stringByAppendingString:imgHtml];
        }
        else {
            NSString *idString = [NSString stringWithFormat:@"Page4Html_Layer23copy%d",i];
            NSString *imgHtml = [NSString stringWithFormat:@"<div id=\"%@\"><img src=\"%@\"></div>",idString,photoName];
            page4AndPhotosHtml = [page4AndPhotosHtml stringByAppendingString:imgHtml];
        }
        */
        
        i++;
    }
    
    
    page4AndPhotosHtml = [NSString stringWithFormat:@"%@ %@ %@",page4HtmlStart,page4AndPhotosHtml,page4HtmlEnd];
    
    
    // Configuring Photos
    if ([self.photosNamesArray count]) {
        
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PHOTOS_HTML]" withString:page3AndPhotosHtml];
        
        /*
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PAGE_4_AND_PHOTOS_HTML]" withString:page4AndPhotosHtml];
         */
        
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PAGE_4_AND_PHOTOS_HTML]" withString:@""];

        
    } else {
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PHOTOS_HTML]" withString:@""];
        
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PAGE_4_AND_PHOTOS_HTML]" withString:@""];

    }
    
    
    
    //==========================================================================
    
    
    
    
   
    
    // Configuring Values For First Stage
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[MAKE_TXTFIELD]" withString:make];
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[MODEL_TXTFIELD]" withString:model];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[TYPE_TXTFIELD]" withString:type];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[REGO_NO_TXTFIELD]" withString:regoNo];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[EXPIRY_DATE_TXTFIELD]" withString:expiryDate];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[ODOMETER_READING_TXTFIELD]" withString:odometer];

    
    
    // Configuring Values For Second Stage
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[BUILT_YEAR_TXTFIELD]" withString:builtYear];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[COMPLIANCE_YEAR_TXTFIELD]" withString:complainceYear];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[EXTERIOR_COLOR_TXTFIELD]" withString:exteriorColor];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[INTERIOR_COLOR_TXTFIELD]" withString:interiorColor];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[ENGINE_SIZE_TXTFIELD]" withString:engineSize];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[CYLINDERS_TXTFIELD]" withString:cylinders];

    
    
    
    // Configure for Third Stage

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[GEARS_TXTFIELD]" withString:noOfGears];
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[LAST_SERVICE_DATE_TXTFIELD]" withString:lastServiceDateStr];
    
    
    
    // Configure for Fourth Stage
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[MECHANICALS_TXTVIEW]" withString:mechanicalTextView];
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[PANEL_WORK_TXTVIEW]" withString:pannelWorkTextView];

    
    // Configure for Finance Stage
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_OWNERS_NAME_TEXTFIELD]" withString:financeOwnersName];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_PHONE_NO_TEXTFIELD]" withString:financePhoneNo];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_EMAIL_TEXTFIELD]" withString:financeEmail];

    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_OWING_SWITCH]" withString:financeOwing];

    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_FINANCIER_NAME_TEXTFIELD]" withString:financeFinancierName];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_CURRENT_REPAYMENTS_TEXTFIELD]" withString:financeCurrentPayments];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_PAYOUT_TEXTFIELD]" withString:financePayout];
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[FINANCE_NEWPAYMENTS_AFFARDABILITY_TEXTFIELD]" withString:financeNewPaymentsAfordability];
    
    
    // Configure for  Final Stage
    
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[APPRAISED_BY_TXTFIELD]" withString:appraisedByName];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[APPRAISAL_DATE_TXTFIELD]" withString:appraisedByDate];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[APPRAISED_SCORE_FIELD]" withString:appraisedScore];

    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[OTHER_INFO_TXTVIEW]" withString:otherInfoTextView];

    // Configuring Finalstage Outrightpurchases Switch
    NSString *outrightPurchaseSwitchImg = @"noswitch.png";
    BOOL outrightPurchaseSwitchStatus = [[fileDataDict objectForKey:OUTRIGHT_PURCHASES_SWITCH] boolValue];
    if (outrightPurchaseSwitchStatus==YES) {
        outrightPurchaseSwitchImg = @"switchYes.png";
    } else{
        outrightPurchaseSwitchImg = @"noswitch.png";
    }
    htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:@"[OUT_RIGHT_PURCHASES_SWITCH]" withString:outrightPurchaseSwitchImg];

    
    
    // Configuring Switches
    
    int totalSwitchesCount = [[fileDataDict objectForKey:TOTAL_SWITCHES_COUNT] intValue];
    for (int k=1; k<totalSwitchesCount; k++) {
        
        NSString *switchStr = [NSString stringWithFormat:@"[SWITCH_%d]",k];
        
        NSArray *keysArray = [fileDataDict allKeys];
        BOOL status = [keysArray containsObject:SWITCH_DICTIONARY_KEY(k)];
        
        NSString *switchImgStr = @"";

        if (status) {
            NSNumber* statusNumber = [fileDataDict objectForKey:SWITCH_DICTIONARY_KEY(k)];
            BOOL isYesSwitch = [statusNumber boolValue];
            if (isYesSwitch) {
                switchImgStr = @"switchYes.png";
            } else {
                switchImgStr = @"noswitch.png";
            }
            
            //htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:switchStr withString:switchImgStr];
        } else {
            switchImgStr = @"noswitch.png";
        }
        
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:switchStr withString:switchImgStr];


    }
    
    
    
  // Configure Filter Switches
    
    int totalFilterRadioButtonsCount = 10;
    for (int z=1; z<totalFilterRadioButtonsCount; z++) {
        
        NSString *switchStr = [NSString stringWithFormat:@"[FILTER_%d]",z];
        
        NSArray *keysArray = [fileDataDict allKeys];
        BOOL status = [keysArray containsObject:FILTER_DICTIONARY_KEY(z)];
        
        NSString *radioButtonImgStr = @"";
        
        if (status) {
            NSNumber* statusNumber = [fileDataDict objectForKey:FILTER_DICTIONARY_KEY(z)];
            BOOL isGreenRadioButton = [statusNumber boolValue];
            if (isGreenRadioButton) {
                radioButtonImgStr = @"greenbutton.png";
            } else {
                radioButtonImgStr = @"notfitted.png";
            }
            
        } else {
            radioButtonImgStr = @"notfitted.png";
        }
        
        htmlFileContent = [htmlFileContent stringByReplacingOccurrencesOfString:switchStr withString:radioButtonImgStr];
        
        
    }

    
    
    return htmlFileContent;
}


- (NSString*)formattedStringFromDate:(NSDate*)date
{
    
    NSString *dateStrng = nil;
    
    if (date != nil)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateStyle:kCFDateFormatterShortStyle];
		[dateFormatter setDateFormat:@"dd MMM, yyyy"];
		dateStrng = [dateFormatter stringFromDate:date];
        [dateFormatter release];
    }
    return dateStrng;
    
}



@end
