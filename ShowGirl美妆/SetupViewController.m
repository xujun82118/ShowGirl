//
//  SetupViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController

@synthesize isEveryDayDeclare,isEveryDayMission;

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
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    isEveryDayDeclare.on = [defaults boolForKey:DEFAULTS_IS_DECLARE_TIME];
    isEveryDayMission.on = [defaults boolForKey:DEFAULTS_IS_MISSION_TIME];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishSetup:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)setupMissonString:(id)sender {
    
    [self presentViewController:setUpMission animated:YES completion:NULL];

    
}

- (IBAction)setupMissionTime:(id)sender {
    
    [self presentViewController:missionTime animated:YES completion:NULL];

    
}

- (IBAction)setupDeclareTime:(id)sender {
    
    [self presentViewController:declareTime animated:YES completion:NULL];

}


- (IBAction)chooseDeclare:(id)sender{
    
    [self presentViewController:chooseDeclare animated:YES completion:NULL];

}

- (IBAction)isDeclareTimeChanged:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEveryDayDeclare.on forKey:DEFAULTS_IS_DECLARE_TIME];
    [defaults synchronize];

    //NSLog(@"declare time is %d", isEveryDayDeclare.on);
    
    
}

- (IBAction)isMissionTimeChanged:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEveryDayMission.on forKey:DEFAULTS_IS_MISSION_TIME];
    [defaults synchronize];
}


@end
