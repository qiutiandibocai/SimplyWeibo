//
//  MoreSetViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "MoreSetViewController.h"
#import "ManageViewController.h"
#import "SafeViewController.h"
#import "NotificationViewController.h"
#import "PrivacyViewController.h"
#import "AllUserViewController.h"
#import "OpinionViewController.h"
#import "WeiboViewController.h"
@interface MoreSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
}
@end

@implementation MoreSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"设置";
    [self setUI];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-164)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.rowHeight = (HEIGHT-244)/9;
    myTableView.scrollEnabled = NO;
    dataSource = @[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"意见反馈",@"关于微博"],@[@"清楚缓存"]];
    UILabel *outLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myTableView.frame)+20, WIDTH, 44)];
    outLabel.text = @"退出微博";
    outLabel.textColor = [UIColor redColor];
    outLabel.font = [UIFont systemFontOfSize:15];
    outLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:outLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(outweibo:)];
    outLabel.userInteractionEnabled = YES;
    [outLabel addGestureRecognizer:tap];
}
-(void)outweibo:(UITapGestureRecognizer *)sender{
    NSLog(@"退");
    exit(0);
}
-(void)pop{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *mArr = [NSMutableArray array];
    mArr = dataSource[section];
    return mArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 3) {
        cell.detailTextLabel.text = @"0.8MB";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                ManageViewController *manageVC = [ManageViewController new];
                [self.navigationController pushViewController:manageVC animated:YES];
            }else{
                SafeViewController *safeVC = [SafeViewController new];
                [self.navigationController pushViewController:safeVC animated:YES];
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                NotificationViewController *notiVC = [NotificationViewController new];
                [self.navigationController pushViewController:notiVC animated:YES];
            }else if (indexPath.row == 1){
                PrivacyViewController *priVC = [PrivacyViewController new];
                [self.navigationController pushViewController:priVC animated:YES];
            }else{
                AllUserViewController *alluserVC = [AllUserViewController new];
                [self.navigationController pushViewController:alluserVC animated:YES];
            }
        }
            break;
        case 2:{
            if (indexPath.row == 0) {
                OpinionViewController *opinionVC = [OpinionViewController new];
                [self.navigationController pushViewController:opinionVC animated:YES];
            }else{
                WeiboViewController *weiboVC = [[WeiboViewController alloc]init];
                [self.navigationController pushViewController:weiboVC animated:YES];
            }
        }
        default:
            break;
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
