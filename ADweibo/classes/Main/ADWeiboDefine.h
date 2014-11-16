//
//  ADWeiboDefine.h
//  ADweibo
//
//  Created by fad on 14-11-15.
//  Copyright (c) 2014年 fad. All rights reserved.
//  整个项目相关的宏

// 0.获取未读微博周期(s)
#define kUnreadRequestTime 60
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.新浪认证相关
#define kAppKey @"3719115697"
#define kUserID @"userID"
#define kRedirectURI @"www.baidu.com"
#define kAccessToken @"accessToken"

//4.cell各种元素

//cell元素间距
#define kWeiboCellBorder 6
//昵称字体
#define kNameUIFont [UIFont systemFontOfSize:15]
//时间字体
#define kTImeUIFont [UIFont systemFontOfSize:13]
//来源字体
#define kSourceUIFont [UIFont systemFontOfSize:13]
//正文字体
#define kTTextUIFont [UIFont systemFontOfSize:15]
//转发正文字体
#define kRetTextUIFont [UIFont systemFontOfSize:15]
//表格的边框宽度
#define kTableBorder 10
//配图的宽高
#define kWeiboPhontSize 70
#define kWeiboPhontPadding 10