//
//  MainWindowAppDelegate.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//



#import "MainWindowAppDelegate.h"

#import "MainWindowViewController.h"

#import "YouMiConfig.h"
#import "YouMiWall.h"


@interface WBBaseRequest ()
- (void)debugPrint;
@end

@interface WBBaseResponse ()
- (void)debugPrint;
@end


@implementation MainWindowAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[MainWindowViewController alloc] initWithNibName:@"MainWindowViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    //[self.window makeKeyAndVisible];
    
    //有米广告初始化
    [YouMiConfig setUserID:@"BeatufifullEveryday"]; // [可选] 例如开发者的应用是有登录功能的，则可以使用登录后的用户账号来替代有米为每台机器提供的标识（有米会为每台设备生成的唯一标识符）。
    [YouMiConfig setUseInAppStore:YES];  // [可选]开启内置appStore，详细请看YouMiSDK常见问题解答
    [YouMiConfig launchWithAppID:@"48029e4c19982a01" appSecret:@"06c84e9e0fe2055a"];
    [self.window makeKeyAndVisible];
    // 设置显示全屏广告的window
    //[YouMiConfig setFullScreenWindow:self.window];
    [YouMiWall enable];
    
    
    return YES;
}


- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif
{

        NSLog(@"Recieved Notification %@",notif);
        NSDictionary* infoDic = notif.userInfo;
        NSLog(@"userInfo description=%@",[infoDic description]);
        NSString* codeStr = [infoDic objectForKey:@"DeclareOrMissionTime"];
    NSLog(@"codeStr is  %@", codeStr);
    
    NSString* Mesg = nil;
    if ([codeStr isEqualToString:@"IsMissionTime"]) {
        Mesg = NSLocalizedString(@"Mission time is on", @"");
    }else if ([codeStr isEqualToString:@"IsDeclareTime"])
    {
        Mesg = NSLocalizedString(@"Declare time is on", @"");

    }
    
    if (Mesg != nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"亲 ^-^"
                              message:Mesg
                              delegate:nil
                              cancelButtonTitle:@"Yes, I did."
                              otherButtonTitles:nil];
        [alert show];
    }


}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    /*
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        ProvideMessageForWeiboViewController *controller = [[[ProvideMessageForWeiboViewController alloc] init] autorelease];
        [self.viewController presentModalViewController:controller animated:YES];
    }
     */
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"亲^_^";
        NSString *msg;
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            msg = @"分享成功";
        }else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel)
        {
            msg = @"取消分享";
        }else if (response.statusCode == WeiboSDKResponseStatusCodeSentFail)
        {
            msg = @"分享失败";
        }else if (response.statusCode == WeiboSDKResponseStatusCodeAuthDeny)
        {
            msg = @"授权失败";
        }else if (response.statusCode ==WeiboSDKResponseStatusCodeUserCancelInstall)
        {
            msg = @"无微博客户端";
        }else
        {
            msg = @"分享失败";
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = @"认证结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
       
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


@end
