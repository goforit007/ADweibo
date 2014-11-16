//
//  WeiboFrameModel.h
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboFrameModel : NSObject

@property(nonatomic,strong)WeiboModel *weibo;

//原始微博控件
@property(nonatomic,assign)CGRect weiboBGImageFrame;
@property(nonatomic,assign)CGRect weiboIconImageFrame;
@property(nonatomic,assign)CGRect weiboVIPImageFrame;
@property(nonatomic,assign)CGRect weiboNameLabelFrame;
@property(nonatomic,assign)CGRect weiboTimeLabelFrame;
@property(nonatomic,assign)CGRect weiboSourceLabelFrame;
@property(nonatomic,assign)CGRect weiboTextLabelFrame;
@property(nonatomic,assign)CGRect weiboPhotoImageFrame;
//被转发微博控件
@property(nonatomic,assign)CGRect retWeiboBGImageFrame;
@property(nonatomic,assign)CGRect retweiboNameLabelFrame;
@property(nonatomic,assign)CGRect retweiboTextLabelFrame;
@property(nonatomic,assign)CGRect retweiboPhotoImageFrame;
//工具条
@property(nonatomic,assign)CGRect toolViewFrame;

@property(nonatomic,assign)CGFloat cellH;

@end
