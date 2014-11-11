//
//  User.h
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**
 *  字符串型的用户UID
 */
@property(nonatomic,copy)NSString *idstr;
/**
 *  用户昵称
 */
@property(nonatomic,copy)NSString *screen_name;
/**
 *  友好显示名称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  用户所在省级ID
 */
@property(nonatomic,copy)NSString *city;
/**
 *  用户所在地
 */
@property(nonatomic,copy)NSString *location;
/**
 *  用户个人描述
 */
@property(nonatomic,copy)NSString *description;
/**
 *  用户头像地址（中图），50×50像素
 */
@property(nonatomic,copy)NSString *profile_image_url;
/**
 *  性别，m：男、f：女、n：未知
 */
@property(nonatomic,copy)NSString *gender;
/**
 *  粉丝数
 */
@property(nonatomic,copy)NSString *followers_count;
/**
 *  关注数
 */
@property(nonatomic,copy)NSString *friends_count;
/**
 *  微博数
 */
@property(nonatomic,copy)NSString *statuses_count;
/**
 *  收藏数
 */
@property(nonatomic,copy)NSString *favourites_count;
/**
 *  用户创建（注册）时间
 */
@property(nonatomic,copy)NSString *created_at;
/**
 *  用户头像地址（大图），180×180像素
 */
@property(nonatomic,copy)NSString *avatar_large;
/**
 *  用户头像地址（高清），高清头像原图
 */
@property(nonatomic,copy)NSString *avatar_hd;
/**
 *  该用户是否关注当前登录用户，true：是，false：否
 */
@property(nonatomic,copy)NSString *follow_me;
/**
 *  用户的在线状态，0：不在线、1：在线
 */
@property(nonatomic,copy)NSString *online_status;

//-(void)statusWithDict:(NSDictionary *)userDict;

@end
