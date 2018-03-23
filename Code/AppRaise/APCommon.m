//
//  APCommon.m
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APCommon.h"
#import "APConstants.h"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]

static APCommon *sharedGlobal = nil;
static UIAlertView *progressAlertView = nil;
static NSMutableDictionary *emailDict = nil;

@implementation APCommon

+ (APCommon*)sharedCommon
{
    if (nil == sharedGlobal) 
    {
        sharedGlobal = [[APCommon alloc] init];
        emailDict = [[NSMutableDictionary alloc] init];
    }
    return sharedGlobal;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose      :   Loads image from Resource bundle
// Parameters   :   image path name, image file type
// Return type  :   loaded image
// Comments     :   nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIImage *)loadImageFromResourcePath:(NSString *)path ofType: (NSString *) type
{
	NSString *imagePath = [[NSBundle mainBundle] pathForResource:path ofType:type];
	UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
	return img;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: showAlert - NotImplemented
//// Parameters     :   
//// Return type	: void
//// Comments       : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)showNotImplementedAlert
{
    UIAlertView *alert  =   [[UIAlertView alloc] initWithTitle:APP_NAME message:@"NotImplemented" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: showAlertWithMessage. 
//// Parameters     : message  
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)showAlertWithMessage:(NSString*)message
{
    UIAlertView *alert  =   [[UIAlertView alloc] initWithTitle:APP_NAME message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: formattedStringFromDate. 
//// Parameters     : date  
//// Return type	: NSString
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*)formattedStringFromDate:(NSDate*)date
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: fullFormatedStringFromDate. 
//// Parameters     : date  
//// Return type	: NSString
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*)fullFormatedStringFromDate:(NSDate*)date
{
    NSString *dateString = nil;
	if(date != nil)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateStyle:kCFDateFormatterFullStyle];
		[dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
		dateString = [dateFormatter stringFromDate:date];
        [dateFormatter release];

	}
	return dateString;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: formattedStringFromNormalDate. 
//// Parameters     : date  
//// Return type	: NSString
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*) formattedStringFromNormalDate:(NSDate*)date
{
	NSString *dateString = nil;
    
	if(date != nil)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateStyle:kCFDateFormatterShortStyle];
		[dateFormatter setDateFormat:@"dd/MM/yy"];
		dateString = [dateFormatter stringFromDate:date];
        [dateFormatter release];
	}
	return dateString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: formattedStringFromEmailFileDate. 
//// Parameters     : date  
//// Return type	: NSString
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*) formattedStringFromEmailFileDate:(NSDate*)date
{
	NSString *dateString = nil;
    
	if(date != nil)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateStyle:kCFDateFormatterShortStyle];
		[dateFormatter setDateFormat:@"dd-MM-yy"];
		dateString = [dateFormatter stringFromDate:date];
        [dateFormatter release];
	}
	return dateString;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getMonthFromDate 
// Parameters	: date
// Return type	: NSInteger
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*) getMonthFromDate:(NSDate*)date
{
	NSString *dateString = nil;
    
	if(date != nil)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateFormat:@"MM"];
		dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
    }
    
	return dateString;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getMonthFromDate 
// Parameters	: date
// Return type	: NSInteger
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*)getYearFromDate:(NSDate*)date
{
	NSString *dateString = nil;
    
	if(date != nil)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateFormat:@"YYYY"];
		dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
	}
	return dateString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: UUIDString. 
//// Parameters     :   
//// Return type	: NSString
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*)UUIDString
{
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
	return([(NSString *) uuidStringRef autorelease]);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: createThumbnailFromImage. 
//// Parameters     : originalImage,targetSize
//// Return type	: UIImage
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (UIImage*)createThumbnailFromImage:(UIImage *)originalImage thumbnailSize:(CGRect)targetSize
{
	// no original image, use a default "image not available" thumbnail image
	if(originalImage == nil)
    {
		return nil;
	}
    
    //Otherwise generate thumbnail image from the original image
	CGRect thumbnailBounds = CGRectInset(targetSize, 0,0); // bounds rect and padding
    //	CGFloat width =  originalImage.size.width;
    //	CGFloat height = originalImage.size.height;
	float aspectRatio = 1 ;
	CGRect boundsWithAspect;
	
	//Fit image within the thumbnail bounds while still maintaining the original aspect ratio
	if(originalImage.size.width <= originalImage.size.height)	{
		boundsWithAspect = CGRectMake(0, 0, thumbnailBounds.size.width * aspectRatio, thumbnailBounds.size.height);
	}else{
		boundsWithAspect = CGRectMake(0, 0, thumbnailBounds.size.width, thumbnailBounds.size.height/aspectRatio);
	}
	
	UIGraphicsBeginImageContext(thumbnailBounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//fill the entire thumbnail image with black color
	CGContextSetRGBFillColor(context, 0, 0, 0, 0);
	CGContextFillRect(context, thumbnailBounds);
	
	//Draw the image in the center of the thumbnail bounds with aspect scaling makes it smaller
	float dx = thumbnailBounds.size.width - boundsWithAspect.size.width;
	float dy = thumbnailBounds.size.height - boundsWithAspect.size.height;
	
	boundsWithAspect.origin.x += dx/2;
	boundsWithAspect.origin.y += dy/2;
	
	//UIImage *orientedImage=[self scaleAndRotateImage:originalImage];
	//Draw the image maintaining the aspect ratio
	[originalImage drawInRect:boundsWithAspect];
	//[orientedImage drawInRect:boundsWithAspect];
	UIImage	*thumb = UIGraphicsGetImageFromCurrentImageContext();
	//CFRelease(context);
	UIGraphicsEndImageContext();
	return thumb;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: showProgressAlertView. 
//// Parameters     : 
//// Return type	: void
//// Comments       : Nil
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)showProgressAlertView
{
    progressAlertView                                   = [[UIAlertView alloc] initWithTitle:APP_NAME message:@"Data Saving..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *indicatorView              = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.frame                                 = CGRectMake(125, 80, 40, 40);
    indicatorView.tag                                   = 300;
    [indicatorView startAnimating];
    [progressAlertView addSubview:indicatorView];
    [indicatorView release];    
    [progressAlertView show];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: dismissProgressAlertView. 
//// Parameters     : 
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (void)dismissProgressAlertView
{
    [progressAlertView dismissWithClickedButtonIndex:0 animated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: createDirectory. 
//// Parameters     : directoryPath
//// Return type	: BOOL
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (BOOL) createDirectory: (NSString *) directoryPath 
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL dir = YES;
	BOOL retValue = [fileManager fileExistsAtPath:directoryPath isDirectory:&dir];
	if (!retValue) {
		
		retValue |= [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	return retValue;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: getFilePathForMAil. 
//// Parameters     : fileName
//// Return type	: BOOL
//// Comments       : Nil
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSString*)getFilePathForMAil:(NSString*)fileName
{
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *saveDirectory = [paths objectAtIndex:0];
    //    NSString *mailFilePath = [saveDirectory stringByAppendingPathComponent:MAIL_SHORT_PDF];
    //    
    //    return [mailFilePath stringByAppendingPathComponent:fileName];
    return [NSString string];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: Validates the email. 
//// Parameters     : email  
//// Return type	: BOOL
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (BOOL) validateEmail: (NSString *) email 
{	
	BOOL isValid = YES;
	
	NSRange rangeAt = [email rangeOfString:@"@"];
	if (0 == rangeAt.length)
		isValid = NO;
	else  
	{
		NSString *domainName = [email substringFromIndex:rangeAt.location + 1];
		rangeAt = [domainName rangeOfString:@"@"];
		if (0 != rangeAt.length)
			isValid = NO;
		else{	
			NSInteger dotCount = [[domainName componentsSeparatedByString:@"."] count];
			if(dotCount < 2 || dotCount > 3)
				isValid = NO;
			else if(1 != [[email componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"$!~+`/{}?%^*\\=&'#| "]] count])
                isValid = NO;
		}
	}
	
	return isValid;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: addAllEmailObjects. 
//// Parameters     : 
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)addAllEmailObjects
{
    for (int i = 0; i  < 3;  i++) 
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:EMAIL_DICTIONARY_KEY(i)]) 
        {
            [emailDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:EMAIL_DICTIONARY_KEY(i)] forKey:EMAIL_DICTIONARY_KEY(i)];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: addObject forKey. 
//// Parameters     : object,key
//// Return type	: void
//// Comments       : Nil
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)addObject:(NSString*)object forKey:(NSString*)key
{
    [emailDict setObject:object forKey:key];
    //NSLog(@"%@",emailDict);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: removeObjectForKey forKey. 
//// Parameters     : key
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)removeObjectForKey:(NSString*)key
{
    [emailDict removeObjectForKey:key];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: removeAllemailObjects. 
//// Parameters     : 
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+(void)removeAllemailObjects
{
    for (int i = 0; i  < 3;  i++) 
    {
        [emailDict removeObjectForKey:EMAIL_DICTIONARY_KEY(i)];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:EMAIL_DICTIONARY_KEY(i)];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: emailDictionaryCount
//// Parameters     :  
//// Return type	: NSInteger
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSInteger)emailDictionaryCount
{
    return [emailDict count];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: emailsDictionaryValues
//// Parameters     : 
//// Return type	: NSArray
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (NSArray*)emailsDictionaryValues
{
    return [emailDict allValues];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: dealloc. 
//// Parameters     : 
//// Return type	: void
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Purpose     :  Draws the rectangle at the edge  and returns rect
// Parameters :	aPoint, statusDrawing
// Return type: CGRect
// Comments   :	nil

+ (CGRect)edgeRectForPoint:(CGPoint)aPoint forDrawing:(BOOL)statusDrawing
{
    NSInteger size = (YES == statusDrawing) ? EDGE_SIZE_DRAW : EDGE_SIZE_TOUCH;
    return CGRectMake(aPoint.x - size / 2, 
                      aPoint.y - size / 2, 
                      size, 
                      size);
}

// Purpose     :  Scales the point 
// Parameters :	aPoint, scale
// Return type: CGPoint
// Comments   :	nil

+ (CGPoint)scalePoint:(CGPoint)aPoint scale:(CGFloat)scale
{
    return CGPointMake(aPoint.x * scale, aPoint.y * scale);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: getUnCompressedData. 
//// Parameters     : data
//// Return type	: NSDictionary
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSDictionary*)getUnCompressedData:(NSData*)data
{
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dataDict        = [unArchiver decodeObjectForKey:DATA_COMPRESSOR_KEY];
    [unArchiver finishDecoding];
    [unArchiver release];
    return dataDict;
    return [NSDictionary dictionary];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Purpose		: getCompressedData. 
//// Parameters     : dataDict
//// Return type	: NSData
//// Comments       : Nil
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSData*)getCompressedData:(NSDictionary*)dataDict
{
    NSMutableData *data         = [[[NSMutableData alloc] init] autorelease];
    NSKeyedArchiver *archiver   = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dataDict forKey:DATA_COMPRESSOR_KEY];
    [archiver finishEncoding];
    [archiver release];
    return data;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getMonthFromDate 
// Parameters	: date
// Return type	: NSInteger
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) getMonthFromDate:(NSDate*)date
{
	NSString *dateString = nil;
    
	if(date != nil)
	{
		NSDate *formattedDate = nil;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
		[dateFormatter setDateFormat:@"MM"];
		dateString = [dateFormatter stringFromDate:date];
		formattedDate = [dateFormatter dateFromString:dateString];
		dateString = [dateFormatter stringFromDate:formattedDate];
		[dateFormatter release];
	}
	return [dateString intValue];
}

/********************************************************************************************
 @Method Name  : iSEmpty
 @Param        : 
 @Return       : 
 @Description  : empty validation check
 ********************************************************************************************/
+ (BOOL)iSEmpty:(NSString *)str
{
    if ( [allTrim( str ) length] == 0 ) 
    {
        return YES;
    }else{
        return NO;
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
