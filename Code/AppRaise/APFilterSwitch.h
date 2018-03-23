//
//  APFilterSwitch.h
//  AppRaise
//
//  Created by anilOruganti on 23/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APFilterSwitchDelegate <NSObject>

- (void)filterButtonClicked:(BOOL)btnStatus withSwitchTag:(NSInteger)switchTag;

@end
@interface APFilterSwitch : UIView 
{
    
    IBOutlet UIButton *filterBtn;
    BOOL isBtnClicked;
    id<APFilterSwitchDelegate> delegate;
}

@property(nonatomic,assign) id<APFilterSwitchDelegate> delegate;

- (IBAction)filterBtnAction:(id)sender;
- (void)setFilterBtnStatus:(BOOL)status;
@end
