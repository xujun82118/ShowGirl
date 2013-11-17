//
//  ImageEditingView.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-11.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "ImageEditingView.h"

@interface ImageEditingView ()

@end

@implementation ImageEditingView

@synthesize editImage, imageEditingDelegate = imageEditingDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"image: %@", editImage);
    
	if (editImage != nil)
	{
		[ivEditingImage setImage:editImage];
		//[self.view sendSubviewToBack:ivEditingImage];
        [self.view addSubview:ivEditingImage];
	}
	

}


/*
+ (UIImage*)imageWithImage:(UIImage*)image
			  scaledToSize:(CGSize)newSize;
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

-(UIImage *)saveImage:(UIView *)view {
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(mainRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
	
    CGContextFillRect(context, mainRect);
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
    return newImage;
}

*/

- (IBAction)doFinishReturn:(id)sender {
    
    //[imageEditingDelegate imageEditingFinishReturn];
    [self dismissViewControllerAnimated:NO completion:^{
        [imageEditingDelegate imageEditingFinishReturn];
    }];

    
}

- (IBAction)doShare:(id)sender {
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
}

//填充微博信息
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
   
    message.text = @"新的一天，美丽的我!";
 
    if (editImage!=Nil) {
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(editImage);
        //image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }

     /*
     if (self.mediaSwitch.on)
     {
     WBWebpageObject *webpage = [WBWebpageObject object];
     webpage.objectID = @"identifier1";
     webpage.title = @"分享网页标题";
     webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
     webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
     webpage.webpageUrl = @"http://sina.cn?a=1";
     message.mediaObject = webpage;
     }
     */
    
    return message;
}

- (IBAction)reDoPhoto:(id)sender {
    
    
    //调用自定义的图片处理控制器
    CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
    //判断是否有相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [picker setIsSingle:YES];//??
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [picker setCustomDelegate:self];
    //调起pick处理器，及其view
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    //[self presentModalViewController:fitler animated:YES];
    [self presentViewController:fitler animated:YES completion:NULL];
    
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    if (image != nil)
	{
		[ivEditingImage setImage:image];
		[self.view sendSubviewToBack:ivEditingImage];
	}
     
}

@end
