//
//  NotificationViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
}
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"通知";
    [self setUI];
    [self initData];
}
-(void)setUI{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT+300) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
}
-(void)initData{
    dataSource = @[@[@"@我的",@"评论",@"赞",@"消息",@"群通知",@"未关注人信息",@"新粉丝"],@[@"好友圈微博",@"特别关注微博",@"群微博",@"微博热点"],@[@"免打扰设置",@"获取新信息"]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }else{
        return 10;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"新微博推送通知";
    }else{
        return nil;
    }
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
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row ==1 || indexPath.row == 6) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"所有人";
        }else if (indexPath.row == 3 || indexPath.row == 4){
            cell.accessoryView = [UISwitch new];
        }else if (indexPath.row == 2){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"我关注的人";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"只能通知";
        }else{
           cell.accessoryView = [UISwitch new];
        }
    }else{
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"每2分钟";
        }
    }
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
