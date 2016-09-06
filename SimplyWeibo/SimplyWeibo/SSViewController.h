//
//  SSViewController.h
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/12.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface SSViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView * imageView;
    
    BOOL hasCameraRight;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;
@end
