//
//  WordViewController.h
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/16.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSString *friendStr;
@property(nonatomic,strong)UICollectionView *CV;
@end
