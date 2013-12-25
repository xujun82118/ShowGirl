//
//  StartView.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageEditingView.h"
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"

#define SHOWTIME_START 5
#define SHOWTIME_END 9


@class EveryDayDeclareView;
@class HoldBeautyView;
@class SetupViewController;

@interface StartView : UIViewController<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate,ImageEditingProcessDelegate>
{
    IBOutlet  ImageEditingView* imageEditing;
    BOOL isDeclare;
    BOOL isMission;
    BOOL isRemindedDeclare;
    BOOL isRemindedMission;
    
    NSInteger CurrentDay;
    
    //ImageFilterProcessViewController *fitler;

    
}
- (IBAction)setup:(id)sender;

-(void)targetMethodCheckTime:(NSTimer*)theTimer;
- (NSDictionary *)userInfo;

- (IBAction)ShowHold:(id)sender;
- (IBAction)showDeclaration:(id)sender;
- (IBAction)doTakePhoto:(id)sender;
- (IBAction)youMiAd:(id)sender;

- (IBAction)backToStart:(id)sender;

-(void)showAlert:(NSString *)msg;

- (NSInteger)getCurrentHour;
- (NSInteger)getCurrentDay;

//@property (retain, nonatomic) CustomImagePickerController *picker;
@property (retain, nonatomic) HoldBeautyView*  holdBeautyVeiwController; 
@property (retain, nonatomic) SetupViewController* setupViewController;

@property (retain, nonatomic) IBOutlet  UILabel* staticLabel1;
@property (retain, nonatomic) IBOutlet  UILabel* staticLabel2;
@property (retain, nonatomic) IBOutlet  UILabel* staticLabel3;


@end
