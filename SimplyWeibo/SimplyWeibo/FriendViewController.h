//
//  FriendViewController.h
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/17.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FBlock) (NSString *str);
@interface FriendViewController : UIViewController
@property(nonatomic,copy)FBlock block;
@end
