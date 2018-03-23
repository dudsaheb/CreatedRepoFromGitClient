//
//  APPDFGenerator.h
//  AppRaise
//
//  Created by anilOruganti on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface APPDFGenerator : UIView 
{
    
}
+ (void) CreatePDFFile: (CGRect)pageRect andFileName: (const char *)filename andInputParameters: (NSDictionary *)inputParameters filetype:(BOOL)isLhFile withFileData:(NSMutableDictionary*)fileData andSignature:(UIImage*)image withFileName:(NSString*)thefileName withPhotos:(NSMutableDictionary*)photosDict;

@end
