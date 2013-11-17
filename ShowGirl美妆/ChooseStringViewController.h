//
//  ChooseStringViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-20.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h> 

#define DEFAULT_CHOOSE_STRING_KEY  @"DefaultChooseString"

@interface ChooseStringViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* declareTableView;
    NSInteger currentSelect;
    
}

- (IBAction)finishReturn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *addDeclareString;
- (IBAction)addNewDeclare:(id)sender;


@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITableView *  declareTableView;
@end
