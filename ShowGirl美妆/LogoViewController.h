//
//  LogoViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartView.h"

@interface LogoViewController : UIViewController

@property (retain, nonatomic) StartView* startViewController;


- (IBAction) startApp:(id)sender;

@end
