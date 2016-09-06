//
//  WeiboViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "WeiboViewController.h"
#import "DATA.h"
@interface WeiboViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataSource;
}
@end

@implementation WeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(242, 242, 242);
    self.title = @"关于微博";
    [self setUI];

}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UIImageView *tubiaoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-40, 94, 80, 60)];
    tubiaoImageView.image = [UIImage imageNamed:@"weiboIcon"];
    [self.view addSubview:tubiaoImageView];
    
    UILabel *weiboLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-30, CGRectGetMaxY(tubiaoImageView.frame), 60, 44)];
    weiboLabel.text = @"微博";
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:weiboLabel];
    UILabel *banbenLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-30, CGRectGetMaxY(weiboLabel.frame), 60, 44)];
    banbenLabel.text = @"6.8.0版";
    banbenLabel.font = [UIFont systemFontOfSize:15];
    banbenLabel.textColor = [UIColor redColor];
    [self.view addSubview:banbenLabel];
    
    UITableView *myTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(banbenLabel.frame)+20, WIDTH, 176)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    myTableView.rowHeight = 44;
    myTableView.scrollEnabled = NO;
    dataSource = @[@"给我评分",@"官方微博",@"常见微博",@"版本更新"];
    UIImageView *tpImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myTableView.frame)+20, WIDTH, HEIGHT-CGRectGetMaxY(myTableView.frame)-20)];
    tpImageView.image = [UIImage imageNamed:@"connect"];
    [self.view addSubview:tpImageView];
    
    
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
