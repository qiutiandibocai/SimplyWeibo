//
//  SettingViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "WeiboViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"设置";
//    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self setUI];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UIView *WiFiView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, WIDTH, 44)];
    WiFiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:WiFiView];
    UILabel *WiFiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    WiFiLabel.text = @"微博热点";
    WiFiLabel.font = [UIFont systemFontOfSize:15];
    [WiFiView addSubview:WiFiLabel];
    
    UISwitch *WiFiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-60, 7, 50, 44)];
    [WiFiView addSubview:WiFiSwitch];
    
    UIView *tongyongView = [[UIView alloc]initWithFrame:CGRectMake(0, 144, WIDTH, 44)];
    tongyongView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tongyongView];
    UILabel *tongyongLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    tongyongLabel.text = @"通用设置";
    tongyongLabel.font = [UIFont systemFontOfSize:15];
    [tongyongView addSubview:tongyongLabel];
    UIImageView *tongyongImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 12, 20, 20)];
    tongyongImageView.image = [UIImage imageNamed:@"cut"];
    [tongyongView addSubview:tongyongImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji:)];
    [tongyongView addGestureRecognizer:tap];
    
    UIView *aboutView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tongyongView.frame)+1, WIDTH, 44)];
    aboutView.backgroundColor = [UIColor whiteColor];
    UILabel *aboutLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    [self.view addSubview:aboutView];
    aboutLabel.text = @"关于微博";
    aboutLabel.font = [UIFont systemFontOfSize:15];
    [aboutView addSubview:aboutLabel];
    UIImageView *aboutImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 12, 20, 20)];
    aboutImageView.image = [UIImage imageNamed:@"cut"];
    [aboutView addSubview:aboutImageView];
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shezhi:)];
    [aboutView addGestureRecognizer:tapges];
   
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dianji:(UITapGestureRecognizer *)tap{
    AboutViewController *aboutVC = [AboutViewController new];
    [self.navigationController pushViewController:aboutVC animated:YES];
}
-(void)shezhi:(UITapGestureRecognizer *)tap{
    WeiboViewController *WVC = [WeiboViewController new];
    [self.navigationController pushViewController:WVC animated:YES];
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
