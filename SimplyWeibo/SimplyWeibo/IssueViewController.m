//
//  IssueViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "IssueViewController.h"
#import "LoginViewController.h"
#import "TEM.h"
//#import "User.h"
#import "WordViewController.h"
#import <WeiboSDK.h>
#import "SignInViewController.h"
@interface IssueViewController ()<WBHttpRequestDelegate>
{
    UILabel *tianqiLabel;
}
@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"issue"] style:UIBarButtonItemStylePlain target:self action:@selector(user)];
    [self initData];
    [self setUI];
//    [self getttt];
}
//-(void)getttt{
//     NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
//    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"]url:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:@{@"uid":uid} delegate:self withTag:@"100"];
//}
//- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
//    NSLog(@"myresponse = %@",response);
//}
-(void)setUI{
    UIView *buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 40)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    UIImageView *buttomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-20, 10, 20, 20)];
    buttomImageView.image = [UIImage imageNamed:@"back"];
    [buttomView addSubview:buttomImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    [buttomView addGestureRecognizer:tap];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    //[formatter setDateFormat:@"yyy年MM月dd日HH时mm分ss秒"];
    [formatter setDateFormat:@"dd"];
    NSDate *date=[NSDate date];
    NSString *dayStr=[formatter stringFromDate:date];
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"EEEE"];
     NSString *weekStr=[formatter1 stringFromDate:date];
    
    UILabel *dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, 40, 40)];
    dayLabel.text = [NSString stringWithFormat:@"%@",dayStr];
    dayLabel.font = [UIFont systemFontOfSize:25];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dayLabel];
    
    UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayLabel.frame), 50, 80, 20)];
    weekLabel.text = weekStr;
    weekLabel.font = [UIFont systemFontOfSize:12];
    weekLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weekLabel];
    
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"MM/yyyy"];
    NSString *yearStr=[formatter2 stringFromDate:date];
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dayLabel.frame), CGRectGetMaxY(weekLabel.frame), 60, 20)];
    yearLabel.text = yearStr;
    yearLabel.font = [UIFont systemFontOfSize:12];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:yearLabel];
    tianqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(dayLabel.frame)+10, 100, 30)];
    tianqiLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:tianqiLabel];
    
//    UIButton *wordButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [wordButton setTintColor:[UIColor yellowColor]];
//    wordButton.frame = CGRectMake(20, CGRectGetMaxY(yearLabel.frame)+150, 100, 100);
//    [wordButton setTitle:@"文字" forState:UIControlStateNormal];
//    [wordButton setImage:[UIImage imageNamed:@"word"] forState:UIControlStateNormal];
    NSArray *wordArray = @[@"文字",@"照片/视频",@"头条文章",@"签到",@"直播",@"更多"];
    NSArray *imageArray = @[[UIImage imageNamed:@"word"],[UIImage imageNamed:@"image"],[UIImage imageNamed:@"topline"],[UIImage imageNamed:@"checkin"],[UIImage imageNamed:@"video"],[UIImage imageNamed:@"issue_more"]];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:imageArray[3*i+j] forState:UIControlStateNormal];
            [button setTitle:wordArray[3*i+j] forState:UIControlStateNormal];
           CGFloat buttonWidth = (WIDTH-80)/3;
            button.frame = CGRectMake(20*(j+1)+buttonWidth*j, CGRectGetMaxY(yearLabel.frame)+150+(buttonWidth+40)*i, buttonWidth, buttonWidth);
            button.tag = 101+j+3*i;
            [button addTarget:self action:@selector(gogogo:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(dian:) forControlEvents:UIControlEventTouchDown];
            CGFloat imageWith = button.imageView.frame.size.width;
            CGFloat imageHeight = button.imageView.frame.size.height;
            
            CGFloat labelWidth = 0.0;
            CGFloat labelHeight = 0.0;
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
                // 由于iOS8中titleLabel的size为0，用下面的这种设置
                labelWidth = button.titleLabel.intrinsicContentSize.width;
                labelHeight = button.titleLabel.intrinsicContentSize.height;
            } else {
                labelWidth = button.titleLabel.frame.size.width;
                labelHeight = button.titleLabel.frame.size.height;
            }
            
            UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
            UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-5/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-5/2.0, 0);
            
            button.titleEdgeInsets = labelEdgeInsets;
            button.imageEdgeInsets = imageEdgeInsets;
            
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            [self.view addSubview:button];
        }
    }

//    CGFloat imageWith = wordButton.imageView.frame.size.width;
//    CGFloat imageHeight = wordButton.imageView.frame.size.height;
//    
//    CGFloat labelWidth = 0.0;
//    CGFloat labelHeight = 0.0;
//    
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        // 由于iOS8中titleLabel的size为0，用下面的这种设置
//        labelWidth = wordButton.titleLabel.intrinsicContentSize.width;
//        labelHeight = wordButton.titleLabel.intrinsicContentSize.height;
//    } else {
//        labelWidth = wordButton.titleLabel.frame.size.width;
//        labelHeight = wordButton.titleLabel.frame.size.height;
//    }
//    
//    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
//    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
//    imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-5/2.0, 0, 0, -labelWidth);
//    labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-5/2.0, 0);
//    
//    wordButton.titleEdgeInsets = labelEdgeInsets;
//    wordButton.imageEdgeInsets = imageEdgeInsets;
//
//    wordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [wordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:wordButton];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2,30 , WIDTH/2, CGRectGetMaxY(tianqiLabel.frame)+50)];
    imageView.image = [UIImage imageNamed:@"issue_AD"];
    [self.view addSubview:imageView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}
-(void)issue{
    
}
-(void)pop{
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedIndex = 2;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initData{
    NSURL *url = [NSURL URLWithString:@"https://api.thinkpage.cn/v3/weather/now.json?key=xiwhfms2l3lovidw&location=guangzhou&language=zh-Hans&unit=c"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:con];
    NSURLSessionDataTask *dataTask =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *array = dic[@"results"];
                for (NSDictionary *myDic in array) {
                    TEM *T = [TEM new];
                    T.temperature = myDic[@"now"][@"temperature"];
                    T.qihou = myDic[@"now"][@"text"];
                    NSLog(@"tem = %@,qihou = %@",T.temperature,T.qihou);
                    tianqiLabel.text = [NSString stringWithFormat:@"广州:%@%@℃",T.qihou,T.temperature];
                }
            
        });
    }];
    
    [dataTask resume];
    
}
-(void)gogogo:(UIButton *)sender{
    switch (sender.tag) {
        case 101:{
            WordViewController *WVC = [WordViewController new];
            [self.navigationController pushViewController:WVC animated:YES];
        }
            break;
        case 104:{
            SignInViewController *SIVC = [SignInViewController new];
            [self.navigationController pushViewController:SIVC animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)dian:(UIButton *)sender{
    sender.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            
            sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            
            sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            
            sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
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
