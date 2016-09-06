//
//  LoginViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "LoginViewController.h"
#import "MoreSetViewController.h"
#import <WeiboSDK.h>
#import "User.h"
#import "MyTableViewCell.h"
#import "ManageViewController.h"
#import <NSObject+YYModel.h>
#import <UIImageView+YYWebImage.h>
#import "WebViewController.h"
#import "AddViewController.h"
@interface LoginViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
    NSArray *imageArray;
    User *user;
    UITableView *myTableView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"我";
    [self setUI];
    [self initData];
}
-(void)setUI{
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(pushSet:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    [myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell class])];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    NSArray *array = dataSource[section-1];
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 44;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >=1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        cell.textLabel.text = dataSource[indexPath.section-1][indexPath.row];
        cell.imageView.image = imageArray[indexPath.section-1][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        MyTableViewCell *cell =(MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyTableViewCell class])];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholder:[UIImage imageNamed:@"head"]];
        cell.nameLabel.text = user.name;
        if ([user.userDescription isEqualToString:@""]) {
            cell.introduceLabel.text = [NSString stringWithFormat:@"基本介绍:暂无介绍"];
        }else{
            cell.introduceLabel.text = [NSString stringWithFormat:@"基本介绍:%@",user.userDescription];
        }
        [cell.weiboButton setTitle:[NSString stringWithFormat:@" %@\n微博",user.statuses_count] forState:UIControlStateNormal];
        [cell.attentionButton setTitle:[NSString stringWithFormat:@" %@\n关注",user.friends_count] forState:UIControlStateNormal];
        [cell.fensButton setTitle:[NSString stringWithFormat:@" %@\n粉丝",user.followers_count] forState:UIControlStateNormal];
        [cell.weiboButton addTarget:self action:@selector(weiboButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.attentionButton addTarget:self action:@selector(attentionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.fensButton addTarget:self action:@selector(fensButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
-(void)weiboButtonAction:(UIButton *)sender{
    NSString *url = [NSString stringWithFormat:@"http://m.weibo.cn/u/%@",user.uid];
    WebViewController *WVC = [WebViewController new];
    WVC.url = [NSURL URLWithString:url];
    [self.navigationController pushViewController:WVC animated:YES];
}
-(void)attentionButtonAction:(UIButton *)sender{
    
}
-(void)fensButtonAction:(UIButton *)sender{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(void)initData{
    dataSource = @[@[@"新的好友",@"微博等级"],@[@"我的相册",@"我的点评",@"我的赞"],@[@"微博支付",@"微博运动"],@[@"粉丝头条",@"粉丝服务"],@[@"草稿箱",@"更多"]];
    imageArray = @[@[[UIImage imageNamed:@"new_friend"],[UIImage imageNamed:@"weibo_level"]],@[[UIImage imageNamed:@"my_photo"],[UIImage imageNamed:@"my_comment"],[UIImage imageNamed:@"my_zan"]],@[[UIImage imageNamed:@"weibo_pay"],[UIImage imageNamed:@"weibo_exercise"]],@[[UIImage imageNamed:@"fans_topline"],[UIImage imageNamed:@"fans_serve"]],@[[UIImage imageNamed:@"draft"],[UIImage imageNamed:@"more"]]];
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"accessToken"];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    [WBHttpRequest requestWithAccessToken:access_token url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"100"];
}
-(void)pushSet:(UIBarButtonItem *)sender{
    self.tabBarController.tabBar.hidden = YES;
    MoreSetViewController *MVC = [MoreSetViewController new];
    [self.navigationController pushViewController:MVC animated:YES];
}
-(void)add:(UIBarButtonItem *)sender{
    AddViewController *addVC = [AddViewController new];
    [self.navigationController pushViewController:addVC animated:YES];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
}
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
//    NSLog(@"data = %@",data);
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error = %@",error);
    }else{
       user =[User shareUser];
        [user modelSetWithJSON:dic];
        [myTableView reloadData];
    }
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
