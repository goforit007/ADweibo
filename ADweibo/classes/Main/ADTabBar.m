//
//  ADTabBar.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADTabBar.h"
#import "UIImage+AD.h"
#import "ADTabBarButton.h"

@interface ADTabBar()

@property(nonatomic,weak)ADTabBarButton *selectBtn;

@end

@implementation ADTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
    }
    return self;
}
//添加按钮
-(void)addTabBarButtonWithItem:(UITabBarItem *)item{
    ADTabBarButton *btn=[[ADTabBarButton alloc]init];
    btn.item=item;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    //默认选中第一个
    if (self.subviews.count==1) {
        //[self btnClick:btn];
        btn.selected=YES;
        self.selectBtn=btn;
    }
}
//按钮被点击
-(void)btnClick:(ADTabBarButton *)btn{
    //按钮被点击时，吧按钮tag记录进block里面，以供控制器使用 
    self.btnClickBlock(btn.tag);
    self.selectBtn.selected=NO;
    btn.selected=YES;
    self.selectBtn=btn;
}
//设置子按钮的布局
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width/4;
    CGFloat btnH = self.frame.size.height;
    for (int i=0; i<self.subviews.count; i++) {
        ADTabBarButton *btn=self.subviews[i];
        CGFloat btnX=i*btnW;
        btn.frame=CGRectMake(btnX, 0, btnW, btnH);
        btn.tag=i;
    }

}

@end





