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
@property(nonatomic,strong)UIButton *plusBtn;

@property(nonatomic,strong)NSMutableArray *tabBatBtns;

@end

@implementation ADTabBar

- (NSMutableArray *)tabBatBtns{
    if(_tabBatBtns==nil){
        _tabBatBtns=[NSMutableArray arrayWithCapacity:4];
    }
    return _tabBatBtns;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加号按钮
        [self addPlusBtn];
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
    [self.tabBatBtns addObject:btn];
    //默认选中第一个
    if (self.tabBatBtns.count==1) {
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
//加号按钮
-(void)addPlusBtn{
    self.plusBtn=[[UIButton alloc]init];
    [self.plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [self.plusBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    UIImage *bkImg=[UIImage imageWithName:@"tabbar_compose_button"];
    [self.plusBtn setBackgroundImage:bkImg forState:UIControlStateNormal];
    [self.plusBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    self.plusBtn.bounds=CGRectMake(0, 0, bkImg.size.width, bkImg.size.height);
    [self addSubview:self.plusBtn];
}

//设置子按钮的布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnW = self.frame.size.width/self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int i=0; i<self.tabBatBtns.count; i++) {
        ADTabBarButton *btn=self.tabBatBtns[i];
        CGFloat btnX=i*btnW;
        //i大于1 代表第二个按钮。需要给加号按钮留出一个空间，所以X再加上一个按钮的宽度
        if(i>1){
            btnX=btnX+btnW;
        }
        btn.frame=CGRectMake(btnX, 0, btnW, btnH);
        btn.tag=i;
    }
    self.plusBtn.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

@end





