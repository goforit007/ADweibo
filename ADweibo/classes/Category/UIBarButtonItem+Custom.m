//
//  UIBarButtonItem+Custom.m
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"
#import "UIImage+AD.h"

@implementation UIBarButtonItem (Custom)
/**
 *  快速自定义BarButtonItem
 *
 *  @param NormalName      普通图片
 *  @param HighlightedName 高亮图片
 *  @param id              谁
 *  @param action          什么方法
 *
 *  @return 返回一个自定义的BarButtonItem
 */
+(UIBarButtonItem *)initWithNormalBackgroundImage:(NSString *)NormalName HighlightedBackgroundImage:(NSString *)HighlightedName Target:(id)targat action:(SEL)action{
    UIButton *Btn=[[UIButton alloc]init];
    [Btn setBackgroundImage:[UIImage imageWithName:NormalName] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageWithName:HighlightedName] forState:UIControlStateHighlighted];
    Btn.bounds=CGRectMake(0, 0, Btn.currentBackgroundImage.size.width, Btn.currentBackgroundImage.size.height);
    [Btn addTarget:targat action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Btn];
}

@end
/*
 


 */