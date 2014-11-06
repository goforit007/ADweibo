//
//  ADTabBarButton.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADTabBarButton.h"
#import "ADBadgeButton.h"

@interface ADTabBarButton()

@property(nonatomic,strong)ADBadgeButton *badgeBtn;

@end

@implementation ADTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:iOS7?[UIColor blackColor]:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }

    }
    return self;
}
//取消点击时的高亮
- (void)setHighlighted:(BOOL)highlighted {}
//覆盖父类方法  修改文字位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY=contentRect.size.height*0.6;
    CGFloat titleH=contentRect.size.height - titleY;
    CGFloat titleW=contentRect.size.width;
    return CGRectMake(0, titleY, titleW,  titleH);
}
// 覆盖父类方法   修改图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageH=contentRect.size.height*0.6;
    CGFloat imageW=contentRect.size.width;
    return CGRectMake(0, 0, imageW,  imageH);
}

- (void)setItem:(UITabBarItem *)item{
    _item=item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    //监听item里面 badgeValue的变化
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}
//捕捉到badgeValue改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    // 设置提醒数字
    self.badgeBtn.badgeValue=change[@"new"];
    CGFloat badgeButtonX=self.frame.size.width-self.badgeBtn.frame.size.width-10;
    CGFloat badgeButtonY=2;
    self.badgeBtn.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.badgeBtn.frame=CGRectMake(badgeButtonX, badgeButtonY, self.badgeBtn.frame.size.width, self.badgeBtn.frame.size.height);
    [self addSubview:self.badgeBtn];
}
//提醒不一定有，使用懒加载
- (ADBadgeButton *)badgeBtn{
    if (_badgeBtn==nil) {
        _badgeBtn=[[ADBadgeButton alloc]init];
    }
    return _badgeBtn;
}

@end








