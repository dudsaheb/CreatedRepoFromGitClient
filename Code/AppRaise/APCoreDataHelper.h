//
//  APCoreDataHelper.h
//  AppRaise
//
//  Created by anilOruganti on 26/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vehicle.h"

@interface APCoreDataHelper : NSObject {
    
}

+(APCoreDataHelper*)sharedCoreDataHelper;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (BOOL)addVehicleRecord:(NSMutableDictionary*)dataDict;
- (void)updateVehicleRecord:(NSInteger)recordId;
- (NSArray*)listAllVehicleRecords;
- (NSArray*)listAllVehicleRecordsByDate:(NSDate*)fromDate;
- (void)deleteLastOneMonthrecords;
- (NSDate*)getPreviousDate:(NSInteger)month;
- (void)deleteFileFromDocuments:(NSString*)name;

@end
