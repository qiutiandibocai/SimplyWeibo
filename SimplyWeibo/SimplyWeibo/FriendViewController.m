//
//  FriendViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/17.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "FriendViewController.h"
#import <WeiboSDK.h>
#import "User.h"
@interface FriendViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    NSMutableArray *searchData;
    NSMutableArray *dataSource;
    NSMutableArray *imageData;
    NSMutableArray *searchImageData;
    UITableView *myTableView;
    UISearchController *mySearchController;
}
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    searchData = [NSMutableArray array];
    dataSource = [NSMutableArray array];
    imageData = [NSMutableArray array];
    self.title = @"联系人";
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    [self initData];
    [self manageData];
    mySearchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    mySearchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
    mySearchController.dimsBackgroundDuringPresentation = false;
   
    [mySearchController.searchBar sizeToFit];
    
    mySearchController.searchResultsUpdater = self;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tableHeaderView = mySearchController.searchBar;
    [self.view addSubview:myTableView];
    
}
-(void)initData{
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/2/friendships/friends.json" httpMethod:@"GET" params:@{@"uid":[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]} delegate:self withTag:@"101"];
}
-(void)manageData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/friendships/friends.json?oauth_sign=1590d5d&uid=5974581258&aid=01Arkwt1SELBg6f2cs4Bc1KpCVOT2MbQovKUQiylY_OORCRsI.&access_token=2.00qVj1WGh4DuZE68bdfd647fdPN35C&oauth_timestamp=1471405956"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array = mydic[@"users"];
            for (NSDictionary *dic in array) {
                [dataSource addObject:dic[@"screen_name"]];
                [imageData addObject:dic[@"profile_image_url"]];
            };
            [myTableView reloadData];
            
        });
    }];
    [dataTask resume];
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [searchData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchController.searchBar.text];
   
    searchData = [[dataSource filteredArrayUsingPredicate:predicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [myTableView reloadData];
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (!mySearchController.active) ? dataSource.count : searchData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
//    if (indexPath.row > 0) {
        cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageData[indexPath.row]]]]];
//    }
    cell.textLabel.text = (!mySearchController.active) ? dataSource[indexPath.row] : searchData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.block(dataSource[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back{
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
