//
//  DeclareTimePickerViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "DeclareTimePickerViewController.h"

@interface DeclareTimePickerViewController ()

@end

@implementation DeclareTimePickerViewController

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

    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:NO];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSelect:(id)sender {
    
    NSDate *selected = [self.datePicker date];
   
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    
    //当前的时分秒获得
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)fromDate:selected];
    NSInteger hour = [comps hour];
    NSInteger miniute = [comps minute];
   // NSInteger second = [comps second];
    NSString *message = [[NSString alloc] initWithFormat:
                         @"%d:%d", hour, miniute];

    //存用户选择的时间
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //[defaults setInteger: hour forKey:DEFAULT_DECLARE_TIME];
    [defaults setObject:selected forKey:@"DEFAULT_DECLARE_TIME"];
    [defaults synchronize];
    
    
   // NSString *message = [[NSString alloc] initWithFormat:
   //                      @"The date and time you selected is: %@", selected];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Date and Time Selected"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Yes, I did."
                          otherButtonTitles:nil];
    [alert show];
    
    [self dismissViewControllerAnimated:NO completion:NULL];

    
}


@end
