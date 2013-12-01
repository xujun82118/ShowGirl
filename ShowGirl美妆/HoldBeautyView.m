//
//  HoldBeautyView.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-15.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "HoldBeautyView.h"
#import "SetMissionViewController.h"


@interface HoldBeautyView ()

@end

@implementation HoldBeautyView

@synthesize proveImage,insertPhotoButton,changeImageButton,deleteImageButton;

@synthesize CurrentMissionTableView, textSelfString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.dataSourceArray = [defaults objectForKey:DEFAULT_MISSION_STRING_KEY];
    
    if (self.dataSourceArray == nil)
    {
        self.dataSourceArray = [NSMutableArray arrayWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_1", @""), @"kMissionStringKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_2", @""), @"kMissionStringKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_3", @""), @"kMissionStringKey",
                                 nil],
                                nil];
        
        [defaults setObject:self.dataSourceArray forKey:DEFAULT_MISSION_STRING_KEY];
        [defaults synchronize];
    }
    
    NSInteger  currentSelect = [defaults integerForKey:@"initSelect"];
    if (currentSelect == 100) {
        currentSelect = 0;
    }
    
    
    textSelfString.borderStyle = UITextBorderStyleBezel;
    textSelfString.textColor = [UIColor blackColor];
    textSelfString.font = [UIFont systemFontOfSize:17.0];
    textSelfString.placeholder = @"说点什么？";
    textSelfString.backgroundColor = [UIColor whiteColor];
    
    textSelfString.keyboardType = UIKeyboardTypeDefault;
    textSelfString.returnKeyType = UIReturnKeyDone;
    textSelfString.secureTextEntry = NO;	// make the text entry secure (bullets)
    
    textSelfString.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
	// this will cause automatic vertical resize when the table is resized
	textSelfString.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //textSelfString.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
    
    textSelfString.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
    
    // Add an accessibility label that describes what the text field is for.
    //[textSelfString setAccessibilityLabel:NSLocalizedString(@"SecureTextField", @"")];
    
    //self.textSelf.on = NO;
     
    changeImageButton.hidden = YES;
    deleteImageButton.hidden = YES;
    
}


-(void) viewDidAppear:(BOOL)animated
{
    
    [self.CurrentMissionTableView  reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToStart:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:(NULL)];

}



- (IBAction)doShare:(id)sender {
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
   /* request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    */
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    
    [WeiboSDK sendRequest:request];
}


//填充微博信息
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    UITableViewCell *cell = [self.CurrentMissionTableView cellForRowAtIndexPath:[self.CurrentMissionTableView indexPathForSelectedRow]];
    
    if (![self.textSelfString.text isEqualToString:@""])
    {
        message.text = textSelfString.text;
        
    }else if(![cell.textLabel.text isEqualToString:@""] && cell != nil)
    {
        NSString * preString = NSLocalizedString(@"FromUri", @"");
        message.text = [preString stringByAppendingString:cell.textLabel.text];
    }

    if (proveImage.image!=Nil) {
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(proveImage.image);
        //image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
   
    if ([message.text isEqualToString:@""] || message.text == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"亲^_^"
                              message:@"您未选择任务！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles: nil];
        [alert show];
    }
    
    return message;
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
    NSLog(@"Receive Weibo reponse");
    
}

- (IBAction)insertPhoto:(id)sender {
    
    //调用自定义的图片处理控制器
    CustomImagePickerController *picker = [[CustomImagePickerController alloc] init];
    //判断是否有相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [picker setIsSingle:YES];//??
        [picker setIsDeclare:NO];
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
		[proveImage setImage:image];
		[self.view addSubview:proveImage];
        
        insertPhotoButton.hidden = YES;
        changeImageButton.hidden = NO;
        deleteImageButton.hidden = NO;
	}
    
}



- (IBAction)deleteImage:(id)sender {
    
    if (proveImage.image != nil)
	{
		[proveImage setImage:NULL];
		[self.view addSubview:proveImage];
        
        insertPhotoButton.hidden = NO;
        changeImageButton.hidden = YES;
        deleteImageButton.hidden = YES;
        
    }
}

- (IBAction)changeImage:(id)sender {
    
    [self insertPhoto:NULL];
}

- (void)cancelCamera
{
    
}


/*
- (IBAction)changeSwitchSelf:(id)sender {
    
    if (self.textSelf.on) {
        [self.CurrentMissionTableView reloadData];
    }
}
 */
 
/*


- (IBAction)changeSwitch3:(id)sender {
  
    if (self.text3.on) {
        self.text1.on = NO;
        self.text2.on = NO;
        self.textSelf.on = NO;
    }
    
}

- (IBAction)changeSwitch2:(id)sender {
    
    if (self.text2.on) {
        self.text1.on = NO;
        self.text3.on = NO;
        self.textSelf.on = NO;
    }
}

- (IBAction)changeSwith1:(id)sender {
    
    if (self.text1.on) {
        self.text2.on = NO;
        self.text3.on = NO;
        self.textSelf.on = NO;
    }
}
*/

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    
    
    [self.CurrentMissionTableView reloadData];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataSourceArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    
    [tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:CellIdentifier];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
	cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kMissionStringKey"];
    cell.backgroundColor = [UIColor clearColor];
    cell.opaque = YES;
    
    cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];



    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 列寬
    CGFloat contentWidth = self.view.frame.size.width;
    
    
    // 該行要顯示的內容
    NSString *content = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kMissionStringKey"];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 500) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}  context:nil].size;
    // 這裏返回需要的高度
    return size.height;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.imageView.image = [UIImage imageNamed:@"camera_btn_ok.png"];

    
    
}



- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];
    
}


@end
