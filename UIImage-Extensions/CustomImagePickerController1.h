//
//  CustomImagePickerController1.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-12-1.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomImagePickerControllerDelegate1;

@interface CustomImagePickerController1 : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    id<CustomImagePickerControllerDelegate1> _customDelegate;
}
@property(nonatomic)BOOL isSingle;
@property (nonatomic)BOOL isDeclare;
@property(nonatomic)id<CustomImagePickerControllerDelegate1> customDelegate;
@end

//定义协议，一个统一的处理接口
@protocol CustomImagePickerControllerDelegate1 <NSObject>

- (void)cameraPhoto:(UIImage *)image;
- (void)cancelCamera;
@end