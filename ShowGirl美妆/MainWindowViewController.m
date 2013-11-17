//
//  MainWindowViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "MainWindowViewController.h"
#import "LogoViewController.h"
#import "StartView.h"

@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

@synthesize logoViewController;
@synthesize startViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //加载Logo界面
    NSLog(@"Start main viewDidLoad.....");
    self.logoViewController = [[LogoViewController alloc] initWithNibName:@"LogoView" bundle:nil];
    
    if (self.logoViewController == nil) {
        NSLog(@"logoViewController == nil");
    }
    
    [self.view insertSubview:self.logoViewController.view  atIndex:0];
    
  
    //初始化start界面
    self.startViewController = [[StartView alloc] initWithNibName:@"StartView" bundle:nil];
    
    if (self.startViewController == nil) {
        NSLog(@"startViewController == nil");
    }

/*
    [UIView beginAnimations:@"Start View" context:nil];
    
    [UIView setAnimationDuration:10.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置动画方式
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    

    
    //显示相关的view
    [logoViewController.view removeFromSuperview];
    [self.view insertSubview:self.startViewController.view atIndex:0 ];
    
    //退出函数时，应用之
    [UIView  commitAnimations];
*/
    
    //起动定时延时器
    [self startOneOffTimer:nil];
    
    
    
}


- (void)startOneOffTimer:sender
{
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(targetMethodStartView:)
                                    userInfo:[self userInfo]
                                    repeats:NO];
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}

-(void)targetMethodStartView:(NSTimer*)theTimer
{
    NSLog(@"Into tartget timer!");
    
    [self startView:nil];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startView:(id)sender {
    
    NSLog(@"Into Switch....");
    
    [UIView beginAnimations:@"Start View" context:nil];
    
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置动画方式
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    
    
    
    //显示相关的view
    [logoViewController.view removeFromSuperview];
    [self.view insertSubview:self.startViewController.view atIndex:0 ];
    
    //退出函数时，应用之
    [UIView  commitAnimations];
    
    
}
@end
