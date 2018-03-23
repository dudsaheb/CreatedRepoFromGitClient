//
//  SACreatePDFFromHTML.h
//  AppRaise
//
//  Created by dud saheb on 06/06/14.
//
//

#import <Foundation/Foundation.h>
#import "NDHTMLtoPDF.h"

@protocol SACreatePDFFromHTMLDelegate <NSObject>

- (void)didSucssessFullInDrawingOfPDFFromHtml:(id)anyObject;
- (void)didFailedInDrawingOfPDFFromHtml:(id)anyObject;

@end

@interface SACreatePDFFromHTML : NSObject <NDHTMLtoPDFDelegate>

@property (nonatomic, retain) NDHTMLtoPDF *PDFCreator;
@property (nonatomic,assign) id <SACreatePDFFromHTMLDelegate> delegate;
@property (nonatomic,retain) NSString *htmlPageName;


- (void) createPDFFileWithFileDataDic:(NSMutableDictionary*)fileData
                withTargetPdfFileName:(NSString*)theTargetPdfFileName
                           withPhotos:(NSMutableDictionary*)photosDict andTargetHtmlPage:(NSString*)htmlPage;
@end
