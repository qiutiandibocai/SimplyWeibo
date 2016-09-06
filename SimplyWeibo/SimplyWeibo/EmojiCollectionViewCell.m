//
//  EmojiCollectionViewCell.m
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/18.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "EmojiCollectionViewCell.h"

@implementation EmojiCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellImageView = [UIImageView new];
        self.cellImageView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10);
//        [self.emojiButton setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
        [self.cellImageView setTintColor:[UIColor orangeColor]];
        [self addSubview:self.cellImageView];
    }
    return self;
}
@end
