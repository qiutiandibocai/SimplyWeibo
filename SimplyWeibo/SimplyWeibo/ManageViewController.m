//
//  ManageViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "ManageViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
@interface ManageViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"账号管理";
    [self setUI];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UITableView *mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-200) style:UITableViewStylePlain];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.view addSubview:mytableView];
    
    UILabel *outLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mytableView.frame)+20, WIDTH, 44)];
    outLabel.text = @"退出微博";
    outLabel.textColor = [UIColor redColor];
    outLabel.font = [UIFont systemFontOfSize:15];
    outLabel.backgroundColor = [UIColor whiteColor];
    outLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:outLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(outweibo:)];
    outLabel.userInteractionEnabled = YES;
    [outLabel addGestureRecognizer:tap];

    
}
-(void)outweibo:(UITapGestureRecognizer *)sender{
    NSLog(@"退");
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/oauth2/revokeoauth2" httpMethod:@"GET" params:nil delegate:self withTag:@"103"];
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"resu = %@",result);
    if ([result containsString:@"true"]) {
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        [userD setValue:nil forKey:@"accessToken"];
        [userD setValue:nil forKey:@"userID"];
        AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.tabBarController.viewControllers[2].tabBarItem.title = @"我";
        self.tabBarController.viewControllers[2].tabBarItem.image = [UIImage imageNamed:@"user"];
        self.tabBarController.viewControllers = @[d.homeVc,d.issueVc,d.myVc];
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.imageView.image = [UIImage imageNamed:@"head"];
    cell.textLabel.text = @"狗子的西瓜刀";
    return cell;
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
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
