//
//  AppDelegate.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/8.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "MyViewController.h"
#import "IssueViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import <MBProgressHUD.h>
@interface AppDelegate ()<WeiboSDKDelegate>
{
    UITabBarController *tabBarController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyWindow];
    tabBarController = [UITabBarController new];
    _myVc = [[UINavigationController alloc]initWithRootViewController:[MyViewController new]];
    _issueVc = [[UINavigationController alloc]initWithRootViewController:[IssueViewController new]];
    _homeVc = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
    _loginVc = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"]) {
        tabBarController.viewControllers = @[_homeVc,_issueVc,_loginVc];
    }else{
        tabBarController.viewControllers = @[_homeVc,_issueVc,_myVc];
    }
    NSArray *names = @[@"首页",@"发布",@"我"];
    NSArray *images = @[[UIImage imageNamed:@"home"],[UIImage imageNamed:@"arrow-up"],[UIImage imageNamed:@"user"]];
    for (int i = 0; i < 3; i++) {
        tabBarController.viewControllers[i].tabBarItem.title = names[i];
        tabBarController.viewControllers[i].tabBarItem.image = images[i];
        if (i == 1) {
            tabBarController.viewControllers[1].tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            tabBarController.viewControllers[1].tabBarItem.title = nil;
            
        }
    }
    tabBarController.selectedIndex = 2;
    self.window.rootViewController = tabBarController;
    tabBarController.tabBar.tintColor = RGBColor(252, 119, 33);
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:KAppKey];
    
    return YES;
}
//下面两个方法是被别的应用打开的时候被调用
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
#pragma mark WeiboSDKDelegate
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到请求");
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSLog(@"收到响应");
    if ([response isMemberOfClass:[WBAuthorizeResponse class]]) {
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        self.user_id = authorizeResponse.userID;
        self.access_token = authorizeResponse.accessToken;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:authorizeResponse.accessToken forKey:@"accessToken"];
        [userDefaults setObject:authorizeResponse.userID forKey:@"userID"];
        [userDefaults synchronize];
       
        [MBProgressHUD hideHUDForView:tabBarController.viewControllers[2].view animated:YES];
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            tabBarController.viewControllers = @[_homeVc,_issueVc,_loginVc];
            tabBarController.viewControllers[2].tabBarItem.title = @"我";
            tabBarController.viewControllers[2].tabBarItem.image = [UIImage imageNamed:@"user"];
            tabBarController.selectedIndex = 0;
            self.window.rootViewController = tabBarController;
            tabBarController.tabBar.tintColor = RGBColor(252, 119, 33);
        }
    }    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
