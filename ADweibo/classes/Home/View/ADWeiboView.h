//
//  ADWeiboView.h
//  ADweibo
//
//  Created by fad on 14-11-12.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADWeiboToolBar.h"
#import "WeiboModel.h"
#import "UserModel.h"
#import "WeiboFrameModel.h"
#import "ADWeiboPhptoView.h"

@interface ADWeiboView : UIView

//微博数据
@property(nonatomic,strong)WeiboFrameModel *weiboFrameModel;
//原始微博控件
@property(nonatomic,strong)UIImageView *weiboBGImageView;
@property(nonatomic,strong)UIImageView *weiboIconImageView;
@property(nonatomic,strong)UILabel *weiboNameLabel;
@property(nonatomic,strong)UILabel *weiboTimeLabel;
@property(nonatomic,strong)UILabel *weiboSourceLabel;
@property(nonatomic,strong)UILabel *weiboTextLabel;
@property(nonatomic,strong)ADWeiboPhptoView *weiboPhotoImageView;
//被转发微博控件
@property(nonatomic,strong)UIImageView *retWeiboBGImageView;
@property(nonatomic,strong)UILabel *retweiboNameLabel;
@property(nonatomic,strong)UILabel *retweiboTextLabel;
@property(nonatomic,strong)ADWeiboPhptoView *retweiboPhotoImageView;

@end
