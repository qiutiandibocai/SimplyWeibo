//
//  HomeViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"
#import <WeiboSDK.h>
@interface HomeViewController ()<WBHttpRequestDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    [self initData];
    [self setUI];
    
    
}
-(void)setUI{
    User *user = [User shareUser];
    NSString *str = user.name;
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(WIDTH/4, 0, WIDTH/2, 40);
    [titleButton setTitle:str forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"pull_dowm"] forState:UIControlStateNormal];
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, WIDTH/2-40, 0, 0);
    self.navigationItem.titleView = titleButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user"] style:UIBarButtonItemStylePlain target:self action:@selector(user)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"radar"] style:UIBarButtonItemStylePlain target:self action:@selector(radar)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    
}
-(void)user{
    
}
-(void)radar{
    
}
-(void)initData{
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:nil delegate:self withTag:@"101"];
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
