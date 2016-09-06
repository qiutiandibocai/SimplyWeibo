//
//  AppDelegate.h
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/8.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *access_token;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)UINavigationController *issueVc;
@property(nonatomic,strong)UINavigationController *homeVc;
@property(nonatomic,strong)UINavigationController *loginVc;
@property(nonatomic,strong)UINavigationController *myVc;
@end

