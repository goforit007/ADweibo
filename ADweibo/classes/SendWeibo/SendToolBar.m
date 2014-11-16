//
//  SendToolBar.m
//  ADweibo
//
//  Created by fad on 14-11-15.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "SendToolBar.h"
#import "UIImage+AD.h"

@implementation SendToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        //初始化按钮
        [self initToolBtn];
    }
    return self;
}
//添加工具按钮
-(void)initToolBtn{
    [self addBunntonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:toolBarButtonTypeCamera];
    [self addBunntonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:toolBarButtonTypePicture];
    [self addBunntonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:toolBarButtonTypeMention];
    [self addBunntonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:toolBarButtonTypeTrend];
    [self addBunntonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:toolBarButtonTypeEmotion];
}
//具体的每一个按钮
-(void)addBunntonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(int)tag{
    UIButton *btn=[[UIButton alloc]init];
    btn.tag=tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:btn];
}
//按钮点击事件
-(void)btnClick:(UIButton *)btn{
    self.toolBarButtonClickBlock(btn.tag);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat W=self.frame.size.width/self.subviews.count;
    CGFloat H=self.frame.size.height;
    for(int i=0;i<self.subviews.count;i++){
        UIButton *btn=self.subviews[i];
        CGFloat X=W*i;
        btn.frame=CGRectMake(X, 0, W, H);
    }
    
}

@end
