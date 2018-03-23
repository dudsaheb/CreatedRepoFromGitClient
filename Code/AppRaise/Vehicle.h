//
//  Vehicle.h
//  AppRaise
//
//  Created by anilOruganti on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Vehicle : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * appraisedScore;
@property (nonatomic, retain) NSString * gears;
@property (nonatomic, retain) NSString * cylinders;
@property (nonatomic, retain) NSString * appraisalDate;
@property (nonatomic, retain) NSString * odometerReading;
@property (nonatomic, retain) NSString * builtYear;
@property (nonatomic, retain) NSString * pdfFileName;
@property (nonatomic, retain) NSString * engineSize;
@property (nonatomic, retain) NSString * otherInfo;
@property (nonatomic, retain) NSString * regoNumber;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * exteriorColor;
@property (nonatomic, retain) NSString * interiorColor;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * appraisedBy;
@property (nonatomic, retain) NSNumber * fileSend;
@property (nonatomic, retain) NSString * modifiedFileName;
@property (nonatomic, retain) NSString * vinNo;
@property (nonatomic, retain) NSString * panelWork;
@property (nonatomic, retain) NSString * mechanicals;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * recordID;
@property (nonatomic, retain) NSData * recordData;
@property (nonatomic, retain) NSString * expiryDate;
@property (nonatomic, retain) NSString * complianceYear;
@property (nonatomic, retain) NSDate * recordCreatedDate;
@property (nonatomic, retain) NSNumber * tyresNeeded;

@end
