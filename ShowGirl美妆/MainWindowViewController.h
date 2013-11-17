//
//  MainWindowViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogoViewController;
@class StartView;

@interface MainWindowViewController : UIViewController
- (IBAction)startView:(id)sender;
- (void)startOneOffTimer:(id)sender;
-(void)targetMethodStartView:(NSTimer*)theTimer;
- (NSDictionary *)userInfo;

@property (retain, nonatomic) LogoViewController* logoViewController;
@property (retain, nonatomic) StartView* startViewController;
@end
