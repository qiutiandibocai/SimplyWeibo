//
//  SignInViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "SignInViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <WeiboSDK.h>
@interface SignInViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,WBHttpRequestDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    NSString *jingduStr;
    NSString *weiduStr;
    NSMutableArray *arr;
    NSMutableArray *titleArr;
    NSMutableArray *peolpeArr;
    UITableView *myTableView;
}
@property(nonatomic,strong)CLLocationManager *lManager;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我在这里";
    self.view.backgroundColor = RGBColor(227, 227, 227);
    arr = [NSMutableArray array];
    titleArr = [NSMutableArray array];
    peolpeArr = [NSMutableArray array];
    [self setUI];
    [self startDingwei];
    [self initData];
    [self manageData];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    UISearchBar *sea = [[UISearchBar alloc]initWithFrame:CGRectMake(30, 0, WIDTH-60, 40)];
    sea.backgroundColor = [UIColor whiteColor];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-40) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
}
-(void)initData{
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/2/place/nearby/pois.json" httpMethod:@"GET" params:@{@"lat":@"23.130186",@"long":@"113.268409"} delegate:self withTag:@"101"];
}
-(void)manageData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/place/nearby/pois.json?oauth_timestamp=1471340376&oauth_sign=dcc5823&lat=23.130186&long=113.268409&aid=01Arkwt1SELBg6f2cs4Bc1KpCVOT2MbQovKUQiylY_OORCRsI.&access_token=2.00qVj1WGh4DuZE68bdfd647fdPN35C"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *mydic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array = mydic[@"pois"];
            for (NSDictionary *dic in array) {
                [titleArr addObject:dic[@"title"]];
                [arr addObject:dic[@"address"]];
                [peolpeArr addObject:dic[@"checkin_num"]];
            }
            [myTableView reloadData];
        });
    }];
    [dataTask resume];
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CLLocationManager *)lManager{
    if (_lManager == nil) {
        _lManager = [CLLocationManager new];
        _lManager.delegate = self;
        _lManager.distanceFilter = kCLDistanceFilterNone;
        _lManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _lManager;
}
-(void)startDingwei{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ) {
        [self.lManager requestWhenInUseAuthorization];
    }
    [self.lManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.lastObject;
    jingduStr = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    weiduStr = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//    NSLog(@"jindu = %@,weidu = %@",jingduStr,weiduStr);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text = titleArr[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@人去过.%@",peolpeArr[indexPath.row],arr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
