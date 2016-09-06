//
//  User.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "User.h"
static User *user = nil;
@implementation User
+(id)shareUser{
    if (!user) {
        user = [User new];
    }
    return user;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (user == nil) {
        user = [super allocWithZone:zone];
    }
    return user;
}
+(NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"uid":@"id",
             @"userClass":@"class",
             @"userDescription":@"description"};
}
@end
@implementation UserStatus

+(NSDictionary *)modelCustomPropertyMapper{
    return @{@"statusID":@"id"};
}

@end
