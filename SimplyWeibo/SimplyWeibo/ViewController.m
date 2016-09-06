//
//  ViewController.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/8.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "ViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
@interface ViewController ()<WBHttpRequestDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accessLabel;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *d = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [d addObserver:self forKeyPath:@"access_token" options:NSKeyValueObservingOptionNew context:nil];
    self.title = @"我";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加好友" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(shezhi)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    [self tabbar];
}
-(void)addFriend{
    
}
-(void)shezhi{
    
}
-(void)tabbar{
     
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"access_token"]) {
        self.accessLabel.text = change[NSKeyValueChangeNewKey];
    }
}
- (IBAction)loginButton:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = KRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"ViewController",
                         @"Other_Info_1":[NSNumber numberWithInteger:123]};
    [WeiboSDK sendRequest:request];
    
}
-(void)dealloc{
    [(AppDelegate *)[UIApplication sharedApplication].delegate removeObserver:self forKeyPath:@"access_token"];
}
- (IBAction)senderWeiboButton:(UIButton *)sender {
    NSString *text = self.sendMessageTextField.text;
//    text = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [WBHttpRequest requestWithAccessToken:self.accessLabel.text url:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":text} delegate:self withTag:@"101"];
   
//    WBAuthorizeRequest *authrequest = [WBAuthorizeRequest request];
//    authrequest.redirectURI = KRedirectURI;
//    authrequest.scope = @"all";
//    
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageObject] authInfo:authrequest access_token:self.accessLabel.text];
//    [WeiboSDK sendRequest:request];
}
-(WBMessageObject *)messageObject{
    WBMessageObject *message = [WBMessageObject message];    
    message.text = self.sendMessageTextField.text;
//    WBImageObject *image = [WBImageObject object];
//    image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ah" ofType:@"jpg"]];
//    message.imageObject = image;
    return message;
}
-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
