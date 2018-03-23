//
//  AppRaiseAppDelegate.h
//  AppRaise
//
//  Created by anilOruganti on 18/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppController.h"

@interface AppRaiseAppDelegate : NSObject <UIApplicationDelegate> 
{
    APAppController *appCtrl;
    NSMutableDictionary     *vehicleFormDataDictionary;
    NSMutableDictionary *photosCollectionDict;
    int switchTagValue;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, retain) NSMutableDictionary     *vehicleFormDataDictionary;
@property (nonatomic, assign) APAppController *appCtrl;
@property (nonatomic, retain) NSMutableDictionary *photosCollectionDict;
@property (nonatomic,assign) int switchTagValue;

@end
