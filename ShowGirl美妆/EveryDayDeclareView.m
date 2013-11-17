//
//  EveryDayDeclareView.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-14.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "EveryDayDeclareView.h"
#import "ImageEditingView.h"

@interface EveryDayDeclareView ()

@end

@implementation EveryDayDeclareView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        imageEditing = [[ImageEditingView alloc] initWithNibName:@"ImageEditingView" bundle:nil];
        
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

- (IBAction)doTakePhoto:(id)sender
{
 /*
    if (self.getCurrentHour>5 && self.getCurrentHour <=9)
    {
        NSLog(@"The time is between 5 to 9 o'clock!");
    } else
    {
        NSLog(@"The time is not between 5 to 9 o'clock!");
        [self showAlert:@"已经不是早上了，明天早点来哦!"];
        return;

    }
  */

    
    //调用自定义的图片处理控制器
    CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
    //判断是否有相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [picker setIsSingle:YES];//??
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    //指向他的委托函数？？
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
   
    [imageEditing setEditImage:image];
    [imageEditing setImageEditingDelegate:self];
    [self presentViewController:imageEditing animated:YES completion:NULL];

}


-(void)showAlert:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"亲^_^"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
}


- (IBAction)backToStart:(id)sender
{
    
    [self dismissViewControllerAnimated:NO completion:NULL];
    
}

- (void)imageEditingFinishReturn
{
    NSLog(@"Get delegate imageEditingFinishReturn");
    [self backToStart:NULL];
}

- (NSInteger)getCurrentHour
{
    //查看现在时间， 只在早上5点到9点之间开启
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    
    //当前的时分秒获得
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)fromDate:date];
    NSInteger hour = [comps hour];
    
    return hour;
}

@end
