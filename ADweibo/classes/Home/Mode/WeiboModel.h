//
//  WeiboModel.h
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
 
@interface WeiboModel : NSObject
/**
 *  微博创建时间
 */
@property(nonatomic,copy)NSString *created_at;
/**
 *  微博MID
 */
@property(nonatomic,copy)NSString *mid;
/**
 *  字符串型的微博ID
 */
@property(nonatomic,copy)NSString *idstr;
/**
 *  微博信息内容
 */
@property(nonatomic,copy)NSString *text;
/**
 *  缩略图片地址，没有时不返回此字段
 */
@property(nonatomic,copy)NSString *thumbnail_pic;
/**
 *  中等尺寸图片地址，没有时不返回此字段
 */
@property(nonatomic,copy)NSString *bmiddle_pic;
/**
 *  原始图片地址，没有时不返回此字段
 */
@property(nonatomic,copy)NSString *original_pic;
/**
 *  地理信息字段
 */
@property(nonatomic,copy)NSString *geo;
/**
 *  微博作者的用户信息字段
 */
@property(nonatomic,strong)UserModel *user;
/**
 *  被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property(nonatomic,strong)WeiboModel *retweeted_status;
/**
 *  转发数
 */
@property(nonatomic,copy)NSNumber *reposts_count;
/**
 *  评论数
 */
@property(nonatomic,copy)NSNumber *comments_count;
/**
 *  表态数
 */
@property(nonatomic,copy)NSNumber *attitudes_count;
/**
 *  微博来源
 */
@property(nonatomic,copy)NSString *source;
/**
 *  微博配图地址。多图时返回多图链接。无配图返回“[]”
 */
@property(nonatomic,copy)NSArray *pic_urls;

//-(void)statusWithDict:(NSDictionary *)weiboDict;

@end
