//
//  EveryDayDeclareView.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-14.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageEditingView.h"
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"

@interface EveryDayDeclareView : UIViewController<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate,ImageEditingProcessDelegate>
{
 
   IBOutlet  ImageEditingView* imageEditing;
  

    
}
- (IBAction)doTakePhoto:(id)sender;

- (IBAction)backToStart:(id)sender;

-(void)showAlert:(NSString *)msg;

- (NSInteger)getCurrentHour;
//-(void) StartCamera;

@end
