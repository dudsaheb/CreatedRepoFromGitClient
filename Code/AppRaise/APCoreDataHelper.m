//
//  APCoreDataHelper.m
//  AppRaise
//
//  Created by anilOruganti on 26/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "APCoreDataHelper.h"
#import "APCommon.h"
#import "APConstants.h"


@implementation APCoreDataHelper

static APCoreDataHelper *coreDataHelper = nil;

@synthesize managedObjectContext =__managedObjectContext;

@synthesize managedObjectModel =__managedObjectModel;

@synthesize persistentStoreCoordinator =__persistentStoreCoordinator;


#pragma mark ......
#pragma mark INTIALIZER _ METHODE
#pragma mark ......

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: init
// Parameters	: 	 
// Return type	: id
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (id)init
{
    self = [super init];
    if (self) 
    {
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: sharedCoreDataHelper
// Parameters	: 	 
// Return type	: APCoreDataHelper
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+ (APCoreDataHelper*)sharedCoreDataHelper
{
    if (coreDataHelper == nil) 
    {
        coreDataHelper = [[APCoreDataHelper alloc] init];
    }
    return coreDataHelper;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: addVehicleRecord
// Parameters	: dataDict	 
// Return type	: BOOL
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)addVehicleRecord:(NSMutableDictionary*)dataDict
{    
    BOOL isSuccess = YES;
    
    NSError *error;
	
	Vehicle *vehicleObj = [NSEntityDescription insertNewObjectForEntityForName:VEHICLE_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:VEHICLE_RECORD_ID]) 
    {
        vehicleObj.recordID        = [[NSUserDefaults standardUserDefaults] objectForKey:VEHICLE_RECORD_ID];
    }
    else
    {
        vehicleObj.recordID        = [NSNumber numberWithInt:1];
    }
    
    //todo complianceYear,modifiedFileName to be verified these are not ading to DB
    
    vehicleObj.recordCreatedDate    =   [dataDict objectForKey:VEHICLE_RECORD_CREATED_DATE];
    vehicleObj.fileSend             =   [dataDict objectForKey:VEHICLE_FILE_SEND];
    vehicleObj.recordData           =   [APCommon getCompressedData:dataDict];
    vehicleObj.modifiedFileName     =   [dataDict objectForKey:VEHICLE_MODIFIED_FILE_NAME];
    vehicleObj.pdfFileName          =   [dataDict objectForKey:VEHICLE_PDF_FILENAME];

    vehicleObj.make                 =   [dataDict objectForKey:MAKE_TXTFIELD];
    vehicleObj.model                =   [dataDict objectForKey:MODEL_TXTFIELD];
    vehicleObj.type                 =   [dataDict objectForKey:TYPE_TXTFIELD];
    vehicleObj.regoNumber           =   [dataDict objectForKey:REGO_NO_TXTFIELD];
    vehicleObj.expiryDate           =   [dataDict objectForKey:EXPIRY_DATE_TXTFIELD];
    vehicleObj.odometerReading      =   [dataDict objectForKey:ODOMETER_READING_TXTFIELD];
    vehicleObj.builtYear            =   [dataDict objectForKey:BUILT_YEAR_TXTFIELD];
    vehicleObj.complianceYear       =   [dataDict objectForKey:COMPLIANCE_YEAR_TXTFIELD];
    vehicleObj.vinNo                =   [dataDict objectForKey:VIN_NO_TXTFIELD];
    vehicleObj.exteriorColor        =   [dataDict objectForKey:EXTERIOR_COLOR_TXTFIELD];
    vehicleObj.interiorColor        =   [dataDict objectForKey:INTERIOR_COLOR_TXTFIELD];
    vehicleObj.engineSize           =   [dataDict objectForKey:ENGINE_SIZE_TXTFIELD];
    vehicleObj.cylinders            =   [dataDict objectForKey:CYLINDERS_TXTFIELD];
    vehicleObj.gears                =   [dataDict objectForKey:GEARS_TXTFIELD];
    vehicleObj.mechanicals          =   [dataDict objectForKey:MECHANICALS_TXTVIEW];
    vehicleObj.panelWork            =   [dataDict objectForKey:PANEL_WORK_TXTVIEW];
    vehicleObj.appraisalDate        =   [dataDict objectForKey:APPRAISAL_DATE_TXTFIELD];
    vehicleObj.appraisedBy          =   [dataDict objectForKey:APPRAISED_BY_TXTFIELD];
    vehicleObj.appraisedScore       =   [dataDict objectForKey:APPRAISED_SCORE_FIELD];
    vehicleObj.otherInfo            =   [dataDict objectForKey:OTHER_INFO_TXTVIEW];
        
    if (![self.managedObjectContext save:&error]) 
	{
        ///NSLog(@"Sorry, couldn't save: %@", [error localizedDescription]);
		isSuccess = NO;
	}
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[vehicleObj.recordID intValue] + 1] forKey:VEHICLE_RECORD_ID];
    }
    
    return isSuccess;
    return isSuccess;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: listAllVehicleRecords
// Parameters	: 	 
// Return type	: NSArray
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray*)listAllVehicleRecords
{
    NSArray *vehicleRecordsList = nil;
	
	NSString *descriptor = @"recordID";
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:VEHICLE_ENTITY_NAME inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:descriptor ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];	
	
	NSError *error;
	vehicleRecordsList = [managedObjectContext executeFetchRequest:request error:&error];
	if (vehicleRecordsList == nil) {
		//NSLog(@"Fetch result error %@, %@", error, [error userInfo]);
	}
	
	[request release];
	
	return vehicleRecordsList;	
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: updateVehicleRecord
// Parameters	: recordId	 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)updateVehicleRecord:(NSInteger)recordId
{
	NSError *error;
	
	NSFetchRequest *fetchRequest =[[NSFetchRequest alloc] init];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recordID == %d",recordId];
	[fetchRequest setPredicate:predicate];
    
	NSEntityDescription *requiredEntity = [NSEntityDescription entityForName:VEHICLE_ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
    
	[fetchRequest setEntity:requiredEntity];
	
	NSArray *resultArray =[self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
	Vehicle *vechileObj             = [resultArray lastObject]; 
    vechileObj.fileSend             = [NSNumber numberWithBool:YES];
    
    if (![self.managedObjectContext save:&error]) 
    {
        //NSLog(@"Sorry, couldn't save: %@", [error localizedDescription]);
    }		
    
	[fetchRequest release];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: listAllVehicleRecordsByDate
// Parameters	: fromDate	 
// Return type	: NSArray
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSArray*)listAllVehicleRecordsByDate:(NSDate *)fromDate
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *vehicleObj = [NSEntityDescription entityForName:VEHICLE_ENTITY_NAME inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:vehicleObj];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"recordCreatedDate < %@",fromDate];
    [fetchRequest setPredicate:predicate];
	
	NSError *error;
	NSArray *vehicleRecordsList = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
	[fetchRequest release];
	return vehicleRecordsList;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: deleteLastSixMonthsrecords
// Parameters	: 	 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)deleteLastOneMonthrecords
{
    
    NSDate *endDate     = [self getPreviousDate:1];
    NSLog(@"endDate ====> %@",endDate);
    
    
    NSArray *vehicleRecords  = [self listAllVehicleRecordsByDate:[self getPreviousDate:1]];
    
    for (Vehicle *vehicleObj in vehicleRecords) 
    {
        [self deleteFileFromDocuments:vehicleObj.pdfFileName];
        [self.managedObjectContext deleteObject:vehicleObj];
        NSError *error = nil;	
        if (![ [self managedObjectContext] save:&error]) 
        {
            //NSLog(@"Save error in (deleteBookSettingsOfBookId)%@, %@", error, [error userInfo]);
        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: getPreviousDate
// Parameters	: month	 
// Return type	: NSDate
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSDate*)getPreviousDate:(NSInteger)month
{
    int currentYear;
	int currentMonth;
    //int day;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy"];
	currentYear = [[dateFormat stringFromDate:[NSDate date]] intValue];
	[dateFormat setDateFormat:@"M"];
	currentMonth = [[dateFormat stringFromDate:[NSDate date]] intValue];
    
    int prevMonth = currentMonth - month;
    if (prevMonth <= 0)
    {
        currentMonth = (prevMonth == 0) ? 1 : 12 + prevMonth;
        currentYear--;
    }
    else
    {
        currentMonth = prevMonth;
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setYear:currentYear];
	[comps setMonth:currentMonth];
	[comps setDay:1];
    [comps setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSDate *otherDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    otherDate = [otherDate dateByAddingTimeInterval:timeZoneOffset];
    [comps release];
    [dateFormat release];
    return otherDate;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: deleteFileFromDocuments
// Parameters	: name	 
// Return type	: void
// Comments     : 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)deleteFileFromDocuments:(NSString*)name
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *saveDirectory = [paths objectAtIndex:0];
    NSString *newFilePath = [saveDirectory stringByAppendingPathComponent:name];
    BOOL isRemoved =  [[NSFileManager defaultManager] removeItemAtPath:newFilePath error:&error];
    (isRemoved) ? NSLog(@"file removed") : NSLog(@"file not removed");
    
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose		: saveContext
// Parameters	: 	 
// Return type	: Void
// Comments     : 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppRaise" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppRaise.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)dealloc
{
    [super dealloc]; 
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    
}

@end
