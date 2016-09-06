//
//  WordViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "WordViewController.h"
#import "User.h"
#import <WeiboSDK.h>
#import "FriendViewController.h"
#import "EmojiCollectionViewCell.h"
@interface WordViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WBHttpRequestDelegate>
{
    UITextView *myTextView;
    UIImageView *myImageView;
    NSMutableArray *mArr;
    UIImageView *myImageView1;
    UIImageView *myImageView2;
    UIImageView *myImageView3;
    int index;
    NSMutableArray *emojiArray;
    UIView *bottomView;
//    EmojiCollectionViewCell *cell;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@end
@implementation WordViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发微博";
    emojiArray = [NSMutableArray array];
    [self setUI];
    mArr = [NSMutableArray array];
    index = 0;
    [self initData];
    [self manageData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyShow:(NSNotification *)noti{
    CGRect keyFrame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyFrame = %f",keyFrame.origin.y);
    bottomView.frame = CGRectMake(0, keyFrame.origin.y-80, WIDTH, 80);
}
-(void)keyHidden:(NSNotification *)noti{
    bottomView.frame = CGRectMake(0, HEIGHT-80,WIDTH,80);
}
-(void)initData{
        [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://api.weibo.com/2/emotions.json" httpMethod:@"GET" params:nil delegate:self withTag:@"103"];
    
}
-(void)manageData{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/2/emotions.json?oauth_sign=da9e1a6&aid=01Arkwt1SELBg6f2cs4Bc1KpCVOT2MbQovKUQiylY_OORCRsI.&oauth_timestamp=1471493760&access_token=2.00qVj1WGh4DuZE68bdfd647fdPN35C"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *con = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session= [NSURLSession sessionWithConfiguration:con];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            int a = 0;
            for (NSDictionary *dic in array) {
                a++;
                if (a > 500) {
                    continue;
                }
                [emojiArray addObject:dic[@"url"]];
            }
            [_CV reloadData];
        });
           }];
    [dataTask resume];
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
//    NSLog(@"res = %@",response);
}
-(void)setUI{
    User *user = [User shareUser];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sendButton.frame = CGRectMake(WIDTH-40, 0, 40, 40);
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(senderW) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-40, 0, 80, 64)];
    UILabel *opinionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    opinionLabel.text = @"发微博";
    opinionLabel.font = [UIFont systemFontOfSize:16];
    [centerView addSubview:opinionLabel];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 80, 24)];
    myLabel.text = user.name;
    myLabel.font = [UIFont systemFontOfSize:12];
    myLabel.textColor = [UIColor grayColor];
    [centerView addSubview:myLabel];
    self.navigationItem.titleView = centerView;
    myTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, (HEIGHT-80)/2)];
    myTextView.textColor = [UIColor lightGrayColor];
    myTextView.font = [UIFont systemFontOfSize:20];
    myTextView.tintColor = RGBColor(110, 56, 51);
    myTextView.text = APPIRATER;
    myTextView.selectedRange = NSMakeRange(0, 0);
    myTextView.delegate = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hid)];
    
    [myTextView addGestureRecognizer:pan];
    [self.view addSubview:myTextView];
    myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100,100)];
    [myTextView addSubview:myImageView];
    myImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [myTextView addSubview:myImageView1];
    myImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [myTextView addSubview:myImageView2];
    myImageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(300, 200, 100, 100)];
    [myTextView addSubview:myImageView3];
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-80, WIDTH, 80)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UIView *doubleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    doubleView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:doubleView];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 2.5, 10, 15)];
    leftImageView.image = [UIImage imageNamed:@"location"];
    [doubleView addSubview:leftImageView];
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
    leftLabel.text = @"显示位置";
    leftLabel.layer.borderWidth = 0.1;
    leftLabel.layer.cornerRadius = 8;
    leftLabel.layer.masksToBounds = YES;
    leftLabel.textColor = [UIColor darkGrayColor];
    leftLabel.font = [UIFont systemFontOfSize:13];
    [doubleView addSubview:leftLabel];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-60+3, 3.5, 13 ,13)];
    rightImageView.image = [UIImage imageNamed:@"global"];
    [doubleView addSubview:rightImageView];
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-60+21, 0, 37, 20)];
    rightLabel.text = @"公开";
    rightLabel.layer.borderWidth = 0.1;
    rightLabel.layer.cornerRadius = 8;
    rightLabel.layer.masksToBounds = YES;
    rightLabel.textColor = [UIColor darkGrayColor];
    rightLabel.font = [UIFont systemFontOfSize:13];
    [doubleView addSubview:rightLabel];
    UIView *fiveView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, WIDTH, 40)];
    [bottomView addSubview:fiveView];
    
    CGFloat buWidth = (WIDTH-40-35*5)/4;
    UIButton *picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    picButton.frame = CGRectMake(20, 5, 35, 30);
    [picButton setImage:[UIImage imageNamed:@"picture"] forState:UIControlStateNormal];
    [picButton addTarget:self action:@selector(choosePic) forControlEvents:UIControlEventTouchUpInside];
    [fiveView addSubview:picButton];
    
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    friendButton.frame = CGRectMake(CGRectGetMaxX(picButton.frame)+buWidth, 5, 35, 30);
    [friendButton setImage:[UIImage imageNamed:@"@"] forState:UIControlStateNormal];
    [friendButton addTarget:self action:@selector(friend) forControlEvents:UIControlEventTouchUpInside];
    [fiveView addSubview:friendButton];
    
    UIButton *emoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emoButton.frame = CGRectMake(CGRectGetMaxX(friendButton.frame)+buWidth*2+35, 5, 35, 30);
    [emoButton setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    [emoButton addTarget:self action:@selector(emoAction) forControlEvents:UIControlEventTouchUpInside];
    [fiveView addSubview:emoButton];
    
    
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _CV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 200) collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(40, 40);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [_CV registerClass:[EmojiCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EmojiCollectionViewCell class])];
        _CV.delegate = self;
        _CV.dataSource = self;
        _CV.backgroundColor = [UIColor whiteColor];
        _CV.hidden = YES;
        _CV.pagingEnabled = YES;
        // _CV.contentOffset = CGPointMake(WIDTH, 0);
        [self.view addSubview:_CV];
    
}

-(void)friend{
    
    FriendViewController *FVC = [FriendViewController new];
    FVC.block = ^(NSString *str){
        NSAttributedString *attr =[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" @%@ ",str] attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        [myTextView.textStorage insertAttributedString:attr atIndex:myTextView.selectedRange.location];
        NSUInteger length = myTextView.selectedRange.location + attr.length;
        myTextView.selectedRange = NSMakeRange(length,0);
//        myTextView.textColor = [UIColor blackColor];
    };
    [self.navigationController pushViewController:FVC animated:YES];
}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)senderW{
    
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"] url:@"https://upload.api.weibo.com/2/statuses/upload.json" httpMethod:@"POST" params:@{@"status":myTextView.text,@"pic":myImageView.image} delegate:self withTag:@"101"];
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if (![text isEqualToString:@""]&&textView.textColor==[UIColor lightGrayColor])
//    {
//        textView.text=@"";
//        textView.textColor=[UIColor blackColor];
//    }
//    
//    if ([text isEqualToString:@"\n"])
//    {
//        if ([textView.text isEqualToString:@""])
//        {
//            textView.textColor=[UIColor lightGrayColor];
//            textView.text= APPIRATER;
//        }
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@""])
//    {
//        textView.textColor=[UIColor lightGrayColor];
//        textView.text=APPIRATER;
//    }
//}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _CV.hidden = YES;
    if ([textView.text isEqualToString:APPIRATER]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}
-(void)textViewDidChange:(UITextView *)textView{
    if (_CV.hidden == NO) {
        _CV.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _CV.hidden = YES;
    if ([textView.text isEqualToString:@""]) {
        textView.text = APPIRATER;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}
-(void)choosePic{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    [self presentViewController:pickerController animated:YES completion:nil];
 
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    index++;
    UIImage *image = [info objectForKey:    UIImagePickerControllerOriginalImage];
    switch (index) {
        case 1:{
            myImageView.image = image;
            [mArr addObject:myImageView.image];
        }
            break;
        case 2:{
            myImageView1.image = image;
            [mArr addObject:myImageView1];
        }
            break;
        case 3:{
            myImageView2.image = image;
            [mArr addObject:myImageView2];
        }
            break;
        case 4:{
            myImageView3.image = image;
            [mArr addObject:myImageView3];
        }
            break;
        default:
            break;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)emoAction{
    [myTextView resignFirstResponder];
    _CV.hidden = NO;
    bottomView.frame = CGRectMake(0, CGRectGetMinY(_CV.frame)-80, WIDTH, 80);
}
-(void)hid{
    _CV.hidden = YES;
    [myTextView resignFirstResponder];
}
-(UICollectionView *)collectionView{
    if (_CV == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _CV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 200) collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(WIDTH/8, 40);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [_CV registerClass:[EmojiCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EmojiCollectionViewCell class])];
        _CV.delegate = self;
        _CV.dataSource = self;
        
        _CV.backgroundColor = [UIColor whiteColor];
    }
    return  _CV;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return emojiArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmojiCollectionViewCell *cell =(EmojiCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EmojiCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellImageView.userInteractionEnabled = YES;
    cell.cellImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",emojiArray[indexPath.row]]]]];
//    [cell.emojiButton addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell sizeToFit];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSTextAttachment *textAttachment = [NSTextAttachment new];
    textAttachment.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",emojiArray[indexPath.row]]]]];
    [myTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment] atIndex:myTextView.selectedRange.location];
    myTextView.font = [UIFont systemFontOfSize:20];
    NSUInteger length = myTextView.selectedRange.location + 1;
    myTextView.selectedRange = NSMakeRange(length,0);
   
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return (WIDTH-40*7)/7;
}
//-(void)emojiAction:(UIButton *)sender{
//    NSLog(@"我点了一下");
//}
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
