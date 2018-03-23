//
//  APCommon.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PI 3.14159265358979323846
#define EDGE_SIZE_DRAW  15
#define EDGE_SIZE_TOUCH 40

@interface APCommon : NSObject
{
    
}

+ (APCommon*)sharedCommon;
+ (UIImage *)loadImageFromResourcePath:(NSString *)path ofType: (NSString *) type;
+ (NSString*)UUIDString;
+ (void)showNotImplementedAlert;
+ (NSString*)formattedStringFromNormalDate:(NSDate*)date;
+ (NSString*)formattedStringFromDate:(NSDate*)date;
+ (void)showAlertWithMessage:(NSString*)message;
+ (NSString*)fullFormatedStringFromDate:(NSDate*)date;
+ (UIImage*)createThumbnailFromImage:(UIImage *)originalImage thumbnailSize:(CGRect)targetSize;
+ (void)showProgressAlertView;
+ (void)dismissProgressAlertView;
+ (BOOL) createDirectory: (NSString *) directoryPath;
+ (NSString*)getFilePathForMAil:(NSString*)fileName;
+ (BOOL)validateEmail: (NSString *) email;
+ (void)addObject:(NSString*)object forKey:(NSString*)key;
- (void)removeObjectForKey:(NSString*)key;
+ (NSInteger)emailDictionaryCount;
+ (NSArray*)emailsDictionaryValues;
+ (void)removeAllemailObjects;
- (void)addAllEmailObjects;
+ (NSString*)formattedStringFromEmailFileDate:(NSDate*)date;
+ (NSString*)getMonthFromDate:(NSDate*)date;
+ (NSString*) getYearFromDate:(NSDate*)date;
+ (CGRect)edgeRectForPoint:(CGPoint)aPoint forDrawing:(BOOL)statusDrawing;
+ (CGPoint)scalePoint:(CGPoint)aPoint scale:(CGFloat)scale;
+ (NSDictionary*)getUnCompressedData:(NSData*)data;
+ (NSData*)getCompressedData:(NSDictionary*)dataDict;
- (NSInteger) getMonthFromDate:(NSDate*)date;
+ (BOOL)iSEmpty:(NSString *)str;
@end
