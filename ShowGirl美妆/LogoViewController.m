//
//  LogoViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "LogoViewController.h"

@interface LogoViewController ()

@end

@implementation LogoViewController

@synthesize startViewController;


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
	// Do any additional setup after loading the view.
    
    //初始化start界面
    startViewController = [[StartView alloc] initWithNibName:@"StartView" bundle:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) startApp:(id)sender
{
   
    [UIView beginAnimations:@"Start View" context:nil];
    
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置动画方式
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    
    
    //显示相关的view
    [self presentViewController:startViewController animated:YES completion:NULL];
    
    //退出函数时，应用之
    [UIView  commitAnimations];
    
    
}

@end
