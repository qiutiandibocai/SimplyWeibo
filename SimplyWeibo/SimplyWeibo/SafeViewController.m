//
//  SafeViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "SafeViewController.h"

@interface SafeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataSource;
}

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"账号管理";
    [self setUI];
}
-(void)initData{
    dataSource = @[@[@"登录名"],@[@"修改密码",@"绑定手机",@"证件信息"],@[@"登录保护",@"微盾保护"]];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UITableView *mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT) style:UITableViewStylePlain];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.view addSubview:mytableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
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
