//
//  AddViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/11.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "AddViewController.h"
#import "HomeViewController.h"
#import "SSViewController.h"
@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"添加好友";
    [self setUI];
}
-(void)setUI{
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_more@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 74, WIDTH-20, 30)];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.layer.borderWidth = 0.1;
    searchTextField.layer.cornerRadius = 5;
    searchTextField.layer.masksToBounds = YES;
    [self.view addSubview:searchTextField];
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    searchImageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon@2x"];
    searchTextField.leftView = searchImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.placeholder = @"搜索昵称";
    
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchTextField.frame)+10, WIDTH, 160)];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
    myTableView.scrollEnabled = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"扫描二维码名片";
        cell.textLabel.text = @"扫一扫";
        cell.imageView.image = [UIImage imageNamed:@"sweep"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.detailTextLabel.text = @"添加邀请通讯录中的好友";
        cell.textLabel.text = @"通讯录好友";
        cell.imageView.image = [UIImage imageNamed:@"addressbook"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SSViewController *SSVC = [SSViewController new];
        [self.navigationController pushViewController:SSVC animated:YES];
    }
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)more{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *shuaxinAction = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *fanhuiAction = [UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.navigationController popToRootViewControllerAnimated:YES];
       });
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:shuaxinAction];
    [alert addAction:fanhuiAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
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
