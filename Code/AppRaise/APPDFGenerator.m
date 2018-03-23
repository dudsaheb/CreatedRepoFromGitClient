//
//  APPDFGenerator.m
//  AppRaise
//
//  Created by anilOruganti on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APPDFGenerator.h"
#import "APCommon.h"
#import "APConstants.h"
#import <CoreText/CoreText.h>

#define kfontNameForTextFieldValues "Verdana"
#define kFontSizeForTextFieldValues 12/CONVERSION_NUMBER
#define kTextColor [UIColor colorWithRed:102.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]
#define  kFillColor [UIColor whiteColor].CGColor
#define kFontNameForLabelValues "Arial Black"
#define kFontSizeForLabelValues  8.0/CONVERSION_NUMBER
#define kLabelTextColor [UIColor whiteColor]

#define CONVERSION_NUMBER   2
#define kImageWidth         595.0/CONVERSION_NUMBER
#define kImageHeight        842.0/CONVERSION_NUMBER


@interface APPDFGenerator (Private)

+ (void)drawMultiTextCategoryHeading:(NSString*)textBoxtext inRect:(CGRect)rect;

+ (void)   drawMultiText:(NSString*)textBoxtext inRect:(CGRect)rect;

+ (void)   drawMultiTextHeading:(NSString*)textBoxtext inRect:(CGRect)rect ; 

+ (void)   drawText         : (const char *)theText 
           withFont         : (const char *)theFont
           withFontSize     : (int) theFontSize
           withXCoordinate  : (int) theXCoordinate
           withYCoordinate  : (int) theYCoordinate
           withColor        : (UIColor *) theColor;

+ (void) drawRectangleWithFrame: (CGRect) theFrame andLineWidth: (CGFloat) theLineWidth andLineColor: (CGColorRef) theLineColor;

+ (void) createImageWithName: (const char *)theImageName ofType: (CFStringRef) imageType andSize: (CGRect) theImageRect;

+ (void)drawFirstPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName;
+ (void)drawSecondPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName;
+ (void)drawThirdPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName;

+ (void)drawFirstPdfPageSwitches:(NSMutableDictionary*)fileData;
+ (void)drawSecondPdfPageSwitches:(NSMutableDictionary*)fileData;

+ (void)fillRectWithColor:(CGRect)frame;
+ (CGRect)getFaultHeadingDrawingRect:(NSInteger)prevHeight withFaultHeading:(NSString*)faultHeading andPageHeight:(NSInteger)pageHeight;
+ (CGRect)getFaultReasonDrawingRect:(NSInteger)prevHeight withFaultReason:(NSString*)faultReason andPageHeight:(NSInteger)pageHeight;
+ (CGRect)getFaultCategoryHeadingDrawingRect:(NSInteger)prevHeight withFaultHeading:(NSString*)faultHeading andPageHeight:(NSInteger)pageHeight;
+ (NSInteger)getTotalPagesCount:(BOOL)isLhData andFormData:(NSMutableDictionary*)formData;

@end

CGRect kNitroDrillPdfOuterRect;

@implementation APPDFGenerator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
CGContextRef pdfContext;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: CreatePDFFile andFileName andInputParameters filetype withFileData andSignature withFileName
// Parameters	: pageRect, filename, inputParameters, isLhFile, fileData, image, fileName  		 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void) CreatePDFFile: (CGRect)pageRect andFileName: (const char *)filename andInputParameters: (NSDictionary *)inputParameters filetype:(BOOL)isLhFile withFileData:(NSMutableDictionary*)fileData andSignature:(UIImage*)image withFileName:(NSString*)thefileName withPhotos:(NSMutableDictionary*)photosDict
{
    kNitroDrillPdfOuterRect =  CGRectMake(50/CONVERSION_NUMBER, 50/CONVERSION_NUMBER, pageRect.size.width - 100/CONVERSION_NUMBER, pageRect.size.height - 100/CONVERSION_NUMBER);
	// This code block sets up our PDF Context so that we can draw to it
    
	CFStringRef path;
	CFURLRef url;
	CFMutableDictionaryRef myDictionary = NULL;
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename, kCFStringEncodingUTF8);
    
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
	CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, CFSTR("My PDF File"));
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, CFSTR("My Name"));
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	// Cleanup our mess
	CFRelease(myDictionary);
	CFRelease(url);
	// Done creating our PDF Context, now it's time to draw to it
    
    // Starts our first page
    CGContextBeginPage (pdfContext, &pageRect);
    
        CGRect imageRect = CGRectMake(0, 0 , kImageWidth, kImageHeight);
        [self createImageWithName: "AppraisePDF-Page1" ofType: CFSTR("png") andSize: imageRect];
        [self drawFirstPdfPageTextValues:fileData withFileName:nil];
        [self drawFirstPdfPageSwitches:fileData];
    
    CGContextEndPage (pdfContext);

    // Starts our second page
    CGContextBeginPage (pdfContext, &pageRect);
    
     imageRect = CGRectMake(0, 0 , kImageWidth, kImageHeight);
    [self createImageWithName: "AppraisePDF-Page02" ofType: CFSTR("png") andSize: imageRect];
    [self drawSecondPdfPageTextValues:fileData withFileName:nil];
    [self drawSecondPdfPageSwitches:fileData];
    
    CGContextEndPage (pdfContext);

    // Starts our third page   
    
    CGContextBeginPage (pdfContext, &pageRect);
    
    imageRect = CGRectMake(0, 0 , kImageWidth, kImageHeight);
    [self createImageWithName: "AppraisePDF-Page3" ofType: CFSTR("png") andSize: imageRect];
    [self drawThirdPdfPageTextValues:fileData withFileName:nil];
    int idx = 0;
    for (NSString *yValue in kPhotsYValues_drawing) 
    {
        imageRect = CGRectMake(kPhotsXValues_drawing/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 160/CONVERSION_NUMBER, 160/CONVERSION_NUMBER);
        UIImage *theImage = [APCommon createThumbnailFromImage:(UIImage*)[photosDict objectForKey:PHOTO_KEY(++idx)] thumbnailSize:CGRectMake(0,0,160, 160)];

        CGContextDrawImage (pdfContext, imageRect, [theImage CGImage]);


    }
    CGContextEndPage (pdfContext);

    // We are done drawing to this page, let's end it
	// We could add as many pages as we wanted using CGContextBeginPage/CGContextEndPage
    	
	CGContextRelease (pdfContext);
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawText withFont withFontSize withXCoordinate withYCoordinate withColor       
// Parameters	: theText, theFont, theFontSize, theXCoordinate, theYCoordinate, theColor
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)   drawText         : (const char *)theText 
           withFont         : (const char *)theFont
           withFontSize     : (int) theFontSize
           withXCoordinate  : (int) theXCoordinate
           withYCoordinate  : (int) theYCoordinate
           withColor        : (UIColor *) theColor
{
    CGContextSelectFont (pdfContext, theFont, theFontSize, kCGEncodingMacRoman);
	CGContextSetTextDrawingMode (pdfContext, kCGTextFill);
    CGContextSetFillColorWithColor(pdfContext, theColor.CGColor);
	const char *text = theText;
	CGContextShowTextAtPoint (pdfContext, theXCoordinate, theYCoordinate, text, strlen(text));
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawRectangleWithFrame andLineWidth andLineColor
// Parameters	: theFrame, theLineWidth, theLineColor
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void) drawRectangleWithFrame: (CGRect) theFrame andLineWidth: (CGFloat) theLineWidth andLineColor: (CGColorRef) theLineColor
{
    CGContextSetStrokeColorWithColor(pdfContext, theLineColor);
    CGContextSetLineWidth(pdfContext, theLineWidth);
	CGContextStrokeRect(pdfContext, theFrame);
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: createImageWithName ofType andSize
// Parameters	: theImageName, imageType, theImageRect
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void) createImageWithName: (const char *)theImageName ofType: (CFStringRef) imageType andSize: (CGRect) theImageRect
{
    // This code block will create an image that we then draw to the page
	const char *picture = theImageName;
	CGImageRef image;
    CGDataProviderRef provider;
    
    CFStringRef picturePath = CFStringCreateWithCString (NULL, picture, kCFStringEncodingUTF8);
    CFURLRef pictureURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), picturePath, imageType, NULL);
    
    CFRelease(picturePath);
    
    provider = CGDataProviderCreateWithURL (pictureURL);
    
    CFRelease (pictureURL);
    
    image = CGImageCreateWithPNGDataProvider (provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease (provider);
    
    CGContextDrawImage (pdfContext, theImageRect, image);
    
    CGImageRelease (image);
	// End image code    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawFirstPdfPageTextValues withFileName
// Parameters	: fileData fileName
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawFirstPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName
{
    
    [self drawText: [[fileData objectForKey:MAKE_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:85.0/CONVERSION_NUMBER withYCoordinate:(617.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:MODEL_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:85.0/CONVERSION_NUMBER withYCoordinate:(567.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawText: [[fileData objectForKey:TYPE_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:85.0/CONVERSION_NUMBER withYCoordinate:(512.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:REGO_NO_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:87.0/CONVERSION_NUMBER withYCoordinate:(157.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawText: [[fileData objectForKey:EXPIRY_DATE_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:87.0/CONVERSION_NUMBER withYCoordinate:(106.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:ODOMETER_READING_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:87.0/CONVERSION_NUMBER withYCoordinate:(52.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawText: [[fileData objectForKey:BUILT_YEAR_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:415.0/CONVERSION_NUMBER withYCoordinate:(617.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:COMPLIANCE_YEAR_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:415.0/CONVERSION_NUMBER withYCoordinate:(562/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:VIN_NO_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:390.0/CONVERSION_NUMBER withYCoordinate:(512.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:EXTERIOR_COLOR_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:390.0/CONVERSION_NUMBER withYCoordinate:(460.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:INTERIOR_COLOR_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:390.0/CONVERSION_NUMBER withYCoordinate:(407.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:ENGINE_SIZE_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:390.0/CONVERSION_NUMBER withYCoordinate:(232.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawText: [[fileData objectForKey:CYLINDERS_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:390.0/CONVERSION_NUMBER withYCoordinate:(182.0/CONVERSION_NUMBER) withColor: kTextColor];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawSecondPdfPageTextValues withFileName
// Parameters	: fileData fileName
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawSecondPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName
{

    [self drawText: [[fileData objectForKey:GEARS_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:78.0/CONVERSION_NUMBER withYCoordinate:(464.0/CONVERSION_NUMBER) withColor: kTextColor];
    
    [self drawMultiText:[fileData objectForKey:MECHANICALS_TXTVIEW] inRect:CGRectMake(338.0/CONVERSION_NUMBER, 302.0/CONVERSION_NUMBER, 240.0/CONVERSION_NUMBER, 235.0/CONVERSION_NUMBER)];
    
    [self drawMultiText:[fileData objectForKey:PANEL_WORK_TXTVIEW] inRect:CGRectMake(338.0/CONVERSION_NUMBER, 12.0/CONVERSION_NUMBER, 240.0/CONVERSION_NUMBER, 235.0/CONVERSION_NUMBER)];

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawThirdPdfPageTextValues withFileName
// Parameters	: fileData fileName
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawThirdPdfPageTextValues:(NSMutableDictionary*)fileData withFileName:(NSString*)fileName
{

    [self drawText: [[fileData objectForKey:APPRAISED_BY_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:88.0/CONVERSION_NUMBER withYCoordinate:(652.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawText: [[fileData objectForKey:APPRAISAL_DATE_TXTFIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:88.0/CONVERSION_NUMBER withYCoordinate:(597.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawText: [[fileData objectForKey:APPRAISED_SCORE_FIELD] UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:kFontSizeForTextFieldValues withXCoordinate:165.0/CONVERSION_NUMBER withYCoordinate:(545.0/CONVERSION_NUMBER) withColor: kTextColor];

    [self drawMultiText:[fileData objectForKey:OTHER_INFO_TXTVIEW] inRect:CGRectMake(320/CONVERSION_NUMBER, 542.0/CONVERSION_NUMBER, 265.0/CONVERSION_NUMBER, 147.0/CONVERSION_NUMBER)];

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawFirstPdfPageSwitches
// Parameters	: fileData 
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawFirstPdfPageSwitches:(NSMutableDictionary*)fileData
{
    int i = 0;
    
    
    for (NSString *yValue in kStageoneSwitchYValue_drawing) 
    {
        for (NSString *xValue in kStageOneSwitchXValue_drawing) 
        {
            NSString *btnName = nil;
            
            CGRect imageRect = CGRectMake([xValue intValue]/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 84.0/CONVERSION_NUMBER, 30.0/CONVERSION_NUMBER);

            if ([[fileData objectForKey:SWITCH_DICTIONARY_KEY(++i)] boolValue]) 
            {
                btnName = @"yesSwitch";
            }
            else
            {
                btnName = @"noSwitch";
            }
            
            [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];

        }
    }
    
    for (NSString *yValue in kStageTwoSwitchYValue_drawing) 
    {
            NSString *btnName = nil;
            
            CGRect imageRect = CGRectMake(kStageTwoSwitchXValue_drawing/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 84.0/CONVERSION_NUMBER, 30.0/CONVERSION_NUMBER);
            
            if ([[fileData objectForKey:SWITCH_DICTIONARY_KEY(++i)] boolValue]) 
            {
                btnName = @"yesSwitch";
            }
            else
            {
                btnName = @"noSwitch";
            }
            
            [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];
            
    }

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawSecondPdfPageSwitches
// Parameters	: fileData 
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawSecondPdfPageSwitches:(NSMutableDictionary*)fileData
{
    int i = 21;
    
    for (NSString *yValue in kStageThirdSwitchY1Value_drawing) 
    {
        NSString *btnName = nil;
        
        CGRect imageRect = CGRectMake(kStageThirdSwitchX1Value_drawing/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 92.0/CONVERSION_NUMBER, 32.0/CONVERSION_NUMBER);
        
        if ([[fileData objectForKey:SWITCH_DICTIONARY_KEY(++i)] boolValue]) 
        {
            btnName = @"yesSwitch";
        }
        else
        {
            btnName = @"noSwitch";
        }
        
        [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];
        
    }

    for (NSString *yValue in kStageThirdSwitchY2Value_drawing) 
    {
        NSString *btnName = nil;
        
        CGRect imageRect = CGRectMake(kStageThirdSwitchX2Value_drawing/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 92.0/CONVERSION_NUMBER, 32.0/CONVERSION_NUMBER);
        
        if ([[fileData objectForKey:SWITCH_DICTIONARY_KEY(++i)] boolValue]) 
        {
            btnName = @"yesSwitch";
        }
        else
        {
            btnName = @"noSwitch";
        }
        
        [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];
    }

    int j = 0;
    for (NSString *yValue in kStageThirdFilterYValue_drawing) 
    {
        NSString *btnName = nil;
        
        CGRect imageRect = CGRectMake(kStageThirdFilterXValue_drawing/CONVERSION_NUMBER, [yValue intValue]/CONVERSION_NUMBER , 28.0/CONVERSION_NUMBER, 28.0/CONVERSION_NUMBER);
        
        if ([[fileData objectForKey:FILTER_DICTIONARY_KEY(++j)] boolValue]) 
        {
            btnName = @"filteredBtn";
        }
        else
        {
            btnName = @"notFilteredBtn";
        }
        
        [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];
    }

    //TODO : tyres neede btn implemetion
    int tyre = 0;
    for (NSString *xValue in kTyresNeededXValues_drawing) 
    {
        NSString *btnName = nil;
        NSString *btnNumber = nil;
        CGRect imageRect = CGRectMake(([xValue intValue] - 8 )/CONVERSION_NUMBER,(kTyresNeededYValues_drawing - 8)/CONVERSION_NUMBER , 39.0/CONVERSION_NUMBER, 28.0/CONVERSION_NUMBER);
        BOOL isTyreSelected = (tyre == [[fileData objectForKey:TYRES_DICTIONARY_KEY] intValue]) ? YES : NO;
        
        if (tyre == 0)
        {
            btnName = (isTyreSelected) ? @"noneYesBtn" : @"noneNoBtn";
            imageRect = CGRectMake(([xValue intValue] - 8 )/CONVERSION_NUMBER,(kTyresNeededYValues_drawing - 8)/CONVERSION_NUMBER , 67.0/CONVERSION_NUMBER, 29.0/CONVERSION_NUMBER);
            btnNumber   = @"NONE";
        }
        else
        {
            btnName = (isTyreSelected) ? @"noteYesBtn" : @"noteNoBtn";
            btnNumber   = [NSString stringWithFormat:@"%d",tyre];

        }
        
        [self createImageWithName: [btnName UTF8String] ofType: CFSTR("png") andSize: imageRect];
        
        [self drawText: [btnNumber UTF8String]  withFont:kfontNameForTextFieldValues withFontSize:6 withXCoordinate:([xValue intValue] + 6 )/CONVERSION_NUMBER withYCoordinate:((kTyresNeededYValues_drawing + 5)/CONVERSION_NUMBER) withColor: [UIColor whiteColor]];
        tyre++;
    }

}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: fillRectWithColor
// Parameters	: frame 
// Return type	: void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)fillRectWithColor:(CGRect)frame
{
    //Begin Context Path
    CGContextBeginPath(pdfContext);
    CGContextSetFillColorWithColor(pdfContext, kFillColor);
    CGContextSetStrokeColorWithColor(pdfContext, kFillColor);
    
    CGContextFillRect(pdfContext, frame);
    
    CGContextSetFillColorWithColor(pdfContext, kFillColor);
    CGContextClosePath(pdfContext);
    
    CGContextDrawPath(pdfContext, kCGPathFillStroke);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: drawMultiText inRect
// Parameters	: textBoxtext, rect 
// Return type	: void
// Comments     : 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)drawMultiText:(NSString*)textBoxtext inRect:(CGRect)rect  
{
    // Initialize a graphics context and set the text matrix to a known value.
    
    CGContextSetTextMatrix(pdfContext, CGAffineTransformIdentity);
    
    // Initialize a rectangular path.
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // CGRect bounds = CGRectMake(100.0, 70.0, 200.0, 200.0);
    
    CGPathAddRect(path, NULL, rect);
    
    // Initialize an attributed string.
    NSString *nsString = textBoxtext;
    
    CFStringRef string = (CFStringRef)nsString;    
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), string);
    
    CTFontRef font = CTFontCreateWithName(CFSTR("Verdana"), 14/CONVERSION_NUMBER, NULL);
    
    // Create a color and add it as an attribute to the string.
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextSelectFont (pdfContext, kfontNameForTextFieldValues, 3.0, kCGEncodingMacRoman);
    
    //    set font attribute
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTFontAttributeName, font);
    
    
    // Create the framesetter with the attributed string.
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    
    CFRelease(attrString);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CFRelease(framesetter);
    
    CTFrameDraw(frame, pdfContext);
    
    CGPathRelease (path);
    CFRelease(font);
    CFRelease(frame);
}

+ (NSInteger)getTotalPagesCount:(BOOL)isLhData andFormData:(NSMutableDictionary*)formData
{
    int pages = 1;
    if ([formData count] > 3 ) 
    {
        pages = 3;
    }
    else if ([formData count] > 0)
    {
        pages = 2;
    }
    
    return pages;
}

- (void)dealloc
{
    [super dealloc];
}

@end




