//
//  OpinionViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "OpinionViewController.h"
#import "User.h"
#import <NSObject+YYModel.h>
@interface OpinionViewController ()<UITextViewDelegate>
{
    UITextView *myTextView;
}
@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(227, 227, 227);
    self.title = @"意见反馈";
    [self setUI];
}
-(void)setUI{
    User *user = [User shareUser];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sendButton.frame = CGRectMake(WIDTH-40, 0, 40, 40);
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-40, 0, 80, 64)];
    UILabel *opinionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    opinionLabel.text = @"意见反馈";
    opinionLabel.font = [UIFont systemFontOfSize:16];
    [centerView addSubview:opinionLabel];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 80, 24)];
    myLabel.text = user.name;
    myLabel.font = [UIFont systemFontOfSize:12];
    myLabel.textColor = [UIColor grayColor];
    [centerView addSubview:myLabel];
    self.navigationItem.titleView = centerView;
    myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50)];
    myTextView.textColor = [UIColor lightGrayColor];
    myTextView.font = [UIFont systemFontOfSize:20];
    myTextView.tintColor = RGBColor(110, 56, 51);
    myTextView.text = APPIRATER;
    myTextView.selectedRange = NSMakeRange(0, 0);
    myTextView.delegate = self;
    [self.view addSubview:myTextView];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(myTextView.frame)-30, 80, 20)];
    leftView.layer.borderWidth = 0.1;
    leftView.layer.cornerRadius = 8;
    leftView.layer.masksToBounds = YES;
    leftView.backgroundColor =  RGBColor(227, 227, 227);
    [self.view addSubview:leftView];
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2.5, 10, 15)];
    leftImageView.image = [UIImage imageNamed:@"location"];
    [leftView addSubview:leftImageView];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
    leftLabel.text = @"显示位置";
    leftLabel.textColor = [UIColor darkGrayColor];
    leftLabel.font = [UIFont systemFontOfSize:13];
    [leftView addSubview:leftLabel];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH-60, CGRectGetMaxY(myTextView.frame)-30, 55, 20)];
    rightView.layer.borderWidth = 0.1;
    rightView.layer.cornerRadius = 8;
    rightView.layer.masksToBounds = YES;
    rightView.backgroundColor = RGBColor(227, 227, 227);
    [self.view addSubview:rightView];
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3.5, 13 ,13)];
    rightImageView.image = [UIImage imageNamed:@"global"];
    [rightView addSubview:rightImageView];
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 0, 37, 20)];
    rightLabel.text = @"公开";
    rightLabel.textColor = [UIColor darkGrayColor];
    rightLabel.font = [UIFont systemFontOfSize:13];
    [rightView addSubview:rightLabel];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])
    {
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
    
    if ([text isEqualToString:@"\n"])
    {
        if ([textView.text isEqualToString:@""])
        {
            textView.textColor=[UIColor lightGrayColor];
            textView.text= APPIRATER;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=APPIRATER;
    }
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ok{
    
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
