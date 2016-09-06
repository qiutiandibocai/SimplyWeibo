//
//  MyViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "MyViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "SettingViewController.h"
@interface MyViewController ()<WBHttpRequestDelegate>

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"我";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(user)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(pushSet:)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, WIDTH/2)];
    imageView.image = [UIImage imageNamed:@"my_background"];
    [self.view addSubview:imageView];
    
    UIView *guanzhuView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), WIDTH, 44)];
    guanzhuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:guanzhuView];
    
    UILabel *guanzhuLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 44)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.font = [UIFont systemFontOfSize:20];
    [guanzhuView addSubview:guanzhuLabel];
    
    UILabel *checkoutLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 150, 44)];
    checkoutLabel.text = @"快看看大家都在关注谁";
    checkoutLabel.font = [UIFont systemFontOfSize:15];
    checkoutLabel.textColor = [UIColor grayColor];
    [guanzhuView addSubview:checkoutLabel];
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 10, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"cut"];
    [guanzhuView addSubview:rightImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chenkoutguanzhu:)];
    [guanzhuView addGestureRecognizer:tap];
    
    UILabel *jieshaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, CGRectGetMaxY(guanzhuView.frame)+(HEIGHT-CGRectGetMaxY(guanzhuView.frame))/2-60, WIDTH-120, 60)];
    jieshaoLabel.text = @"登陆后，你的微博，相册，个人资料会显示在这里，展示给他人";
    jieshaoLabel.textColor = [UIColor grayColor];
    jieshaoLabel.numberOfLines = 0;
    jieshaoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jieshaoLabel];
    UIButton *dengluButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dengluButton.frame = CGRectMake(WIDTH/2-50, CGRectGetMaxY(jieshaoLabel.frame)+20, 100, 44);
    [dengluButton setTitle:@"登陆" forState:UIControlStateNormal];
    [dengluButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [dengluButton addTarget:self action:@selector(denglu:) forControlEvents:UIControlEventTouchUpInside];
    dengluButton.layer.borderWidth = 2.0;
    dengluButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:dengluButton];
    
}
-(void)pushSet:(UIBarButtonItem *)sender{
    self.tabBarController.tabBar.hidden = YES;
    SettingViewController *setVc = [SettingViewController new];
    [self.navigationController pushViewController:setVc animated:YES];
}
-(void)chenkoutguanzhu:(UITapGestureRecognizer *)tap{
    NSLog(@"我点了一下");
}
-(void)denglu:(UIButton *)sender{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = KRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyViewController",
                         @"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tabBarController.tabBar.hidden = NO;
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
