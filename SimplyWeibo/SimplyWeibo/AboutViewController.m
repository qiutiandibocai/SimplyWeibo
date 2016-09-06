//
//  AboutViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/9.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"通用设置";
    [self setUI];
}
-(void)setUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UIView *fastView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, WIDTH, 44)];
    fastView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fastView];
    UILabel *fastLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 140, 44)];
    fastLabel.text = @"开启快速拖动";
    fastLabel.font = [UIFont systemFontOfSize:15];
    [fastView addSubview:fastLabel];
    UISwitch *fastSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-60, 7, 20, 20)];
    [fastView addSubview:fastSwitch];
    UIView *describeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fastView.frame), WIDTH, 30)];
    
    [self.view addSubview:describeView];
    UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 30)];
    describeLabel.text = @"浏览列表时可使用拖动条快速拖动。";
    describeLabel.textAlignment = NSTextAlignmentLeft;
    describeLabel.font = [UIFont systemFontOfSize:12];
    describeLabel.textColor = [UIColor grayColor];
    [describeView addSubview:describeLabel];
    
    UIView *playView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(describeView.frame), WIDTH, 44)];
    playView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:playView];
    UILabel *playLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH/2, 44)];
    playLabel.text = @"视频自动播放设置";
    playLabel.font = [UIFont systemFontOfSize:15];
    [playView addSubview:playLabel];
    
    UILabel *playLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-70, 0, 50, 44)];
    playLabel1.text = @"仅WiFi";
    playLabel1.font = [UIFont systemFontOfSize:15];
    playLabel1.textColor = [UIColor grayColor];
    [playView addSubview:playLabel1];
    
    UIImageView *playImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 12, 20, 20)];
    playImageView.image = [UIImage imageNamed:@"cut"];
    [playView addSubview:playImageView];
    UITapGestureRecognizer *playtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playpush)];
    [playView addGestureRecognizer:playtap];
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(playView.frame)+20, WIDTH, 44)];
    downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:downView];
    UILabel *downLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 44)];
    downLabel.text = @"WiFi下自动下载微博安装包";
    downLabel.font =[UIFont systemFontOfSize:15];
    [downView addSubview:downLabel];
    UISwitch *downSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(WIDTH-60, 5, 40, 44)];
    [downView addSubview:downSwitch];
    
    UIView *loundView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(downView.frame)+1, WIDTH, 44)];
    loundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loundView];
    UILabel *loundLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 44)];
    loundLabel.text = @"声音与震动";
    loundLabel.font = [UIFont systemFontOfSize:15];
    [loundView addSubview:loundLabel];
    UIImageView *loundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 12, 20, 20)];
    loundImageView.image = [UIImage imageNamed:@"cut"];
    [loundView addSubview:loundImageView];
    UITapGestureRecognizer *loundtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loundpush)];
    [loundView addGestureRecognizer:loundtap];
    
    UIView *languageView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loundView.frame)+1, WIDTH, 44)];
    languageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:languageView];
    UILabel *languageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    languageLabel.text = @"多语言环境";
    languageLabel.font = [UIFont systemFontOfSize:15];
    [languageView addSubview:languageLabel];
    UILabel *languageLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-60, 0, 40, 44)];
    languageLabel1.text = @"自动";
    languageLabel1.font = [UIFont systemFontOfSize:15];
    languageLabel1.textColor = [UIColor grayColor];
    [languageView addSubview:languageLabel1];
    UIImageView *languangeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-20, 12, 20, 20)];
    languangeImageView.image = [UIImage imageNamed:@"cut"];
    [languageView addSubview:languangeImageView];
    UITapGestureRecognizer *languagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(languagepush)];
    [languageView addGestureRecognizer:languagetap];
    
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)playpush{
    
}
-(void)loundpush{
    
}
-(void)languagepush{
    
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
