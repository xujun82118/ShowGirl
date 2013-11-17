//
//  ImageEditingView.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-11.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"

@protocol ImageEditingProcessDelegate;
@interface ImageEditingView : UIViewController<CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate>

{
    // IBOutlet UIImageView *ivEditingImage;
    UIImage *editImage;
    // bool selectingImage;
    IBOutlet UIImageView *ivEditingImage;
    
    id <ImageEditingProcessDelegate> imageEditingDelegate;
    
}
- (IBAction)doFinishReturn:(id)sender;
- (IBAction)doShare:(id)sender;
- (IBAction)reDoPhoto:(id)sender;

- (WBMessageObject *)messageToShare;

@property (nonatomic, retain) UIImage *editImage;
@property(nonatomic) id<ImageEditingProcessDelegate> imageEditingDelegate;
@end

//定义协议，委托调用者处理
@protocol ImageEditingProcessDelegate <NSObject>

- (void) imageEditingFinishReturn;

@end

