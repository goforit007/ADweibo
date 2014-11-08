//
//  ADSearbar.m
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADSearbar.h"
#import "UIImage+AD.h"

@interface ADSearbar()

@property(nonatomic,strong)UIImageView *searImageView;

@end

@implementation ADSearbar

/**
 *  使用UITextField封装的搜索框
 *
 *  @return 搜索框
 */
+(id)searBar{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        //背景图片
        UIImage *img=[UIImage imageWithName:@"searchbar_textfield_background"];
        img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
        self.background=img;
        //搜索标志
        self.searImageView=[[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        self.searImageView.contentMode=UIViewContentModeCenter;
        self.leftView=self.searImageView;
        self.leftViewMode=UITextFieldViewModeAlways;
        //设置提醒文字  searchBar.placeholder颜色太淡用下面的方法
        //searchBar.placeholder==@"搜索";
        NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
        attrs[UITextAttributeTextColor]=[UIColor grayColor];
        self.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
        //清除的X
        self.clearButtonMode=UITextFieldViewModeAlways;
        //设置键盘右下角按钮
        self.returnKeyType=UIReturnKeySearch;
        //没有文字时 按钮不能用
        self.enablesReturnKeyAutomatically=YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.searImageView.frame=CGRectMake(0, 0, 30, self.frame.size.height);
}

@end
