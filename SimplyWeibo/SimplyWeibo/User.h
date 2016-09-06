//
//  User.h
//  SimplyWeibo
//
//  Created by Ibokan2 on 16/8/10.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserStatus : NSObject
@property (nonatomic,strong)NSString *created_at;
//原来是id
@property (nonatomic,strong)NSNumber *statusID;
@property (nonatomic,strong)NSString *mid;
@property (nonatomic,strong)NSString *idstr;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSNumber *textLength;
@property (nonatomic,strong)NSNumber *source_allowclick;
@property (nonatomic,strong)NSString *source_type;
@property (nonatomic,strong)NSString *source;
@property (nonatomic,strong)NSNumber *favorited;
@property (nonatomic,strong)NSNumber *truncated;
@property (nonatomic,strong)NSString *in_reply_to_status_id;
@property (nonatomic,strong)NSString *in_reply_to_user_id;
@property (nonatomic,strong)NSString *in_reply_to_screen_name;
@property (nonatomic,strong)NSArray *pic_urls;
@property (nonatomic,strong)NSString *geo;
@property (nonatomic,strong)NSArray *annotations;
@property (nonatomic,strong)NSNumber *reposts_count;
@property (nonatomic,strong)NSNumber *comments_count;
@property (nonatomic,strong)NSNumber *attitudes_count;
@property (nonatomic,strong)NSNumber *isLongText;
@property (nonatomic,strong)NSNumber *mlevel;
@property (nonatomic,strong)NSDictionary *visible;
@property (nonatomic,strong)NSNumber *biz_feature;
@property (nonatomic,strong)NSNumber *hasActionTypeCard;
@property (nonatomic,strong)NSArray *darwin_tags;
@property (nonatomic,strong)NSArray *hot_weibo_tags;
@property (nonatomic,strong)NSArray *text_tag_tips;
@property (nonatomic,strong)NSNumber *userType;
@property (nonatomic,strong)NSNumber *positive_recom_flag;
@property (nonatomic,strong)NSString *gif_ids;
@end
@interface User : NSObject
//原来是id
@property (nonatomic,assign)NSNumber *uid;
@property (nonatomic,strong)NSString *idstr;
//原来是class
@property (nonatomic,strong)NSNumber *userClass;
@property (nonatomic,strong)NSString *screen_name;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *location;
//原来是description
@property (nonatomic,strong)NSString *userDescription;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *profile_image_url ;
@property (nonatomic,strong)NSString *cover_image_phone;
@property (nonatomic,strong)NSString *profile_url;
@property (nonatomic,strong)NSString *domain;
@property (nonatomic,strong)NSString *weihao;
@property (nonatomic,strong)NSString *gender;
@property (nonatomic,strong)NSNumber *followers_count;
@property (nonatomic,strong)NSNumber *friends_count;
@property (nonatomic,strong)NSNumber *pagefriends_count;
@property (nonatomic,strong)NSNumber *statuses_count;
@property (nonatomic,strong)NSNumber *favourites_count;
@property (nonatomic,strong)NSString *created_at;
@property (nonatomic,strong)NSNumber *following;
@property (nonatomic,strong)NSNumber *allow_all_act_msg;
@property (nonatomic,strong)NSNumber *geo_enabled;
@property (nonatomic,strong)NSNumber *verified;
@property (nonatomic,strong)NSNumber *verified_type;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)UserStatus *status;
@property (nonatomic,strong)NSNumber *ptype;
@property (nonatomic,strong)NSNumber *allow_all_comment;
@property (nonatomic,strong)NSString *avatar_large;
@property (nonatomic,strong)NSString *avatar_hd;
@property (nonatomic,strong)NSString *verified_reason;
@property (nonatomic,strong)NSString *verified_trade;
@property (nonatomic,strong)NSString *verified_reason_url;
@property (nonatomic,strong)NSString *verified_source;
@property (nonatomic,strong)NSString *verified_source_url;
@property (nonatomic,strong)NSNumber *follow_me;
@property (nonatomic,strong)NSNumber *online_status;
@property (nonatomic,strong)NSNumber *bi_followers_count;
@property (nonatomic,strong)NSString *lang;
@property (nonatomic,strong)NSNumber *star;
@property (nonatomic,strong)NSNumber *mbtype;
@property (nonatomic,strong)NSNumber *mbrank;
@property (nonatomic,strong)NSNumber *block_word;
@property (nonatomic,strong)NSNumber *block_app;
@property (nonatomic,strong)NSNumber *credit_score;
@property (nonatomic,strong)NSNumber *user_ability;
@property (nonatomic,strong)NSNumber *urank;
+(id)shareUser;
@end


