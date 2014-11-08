//
//  titleButton.m
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "TitleButton.h"
#import "UIImage+AD.h"

#define Kmargin 10

@interface TitleButton()

@property(nonatomic,strong)UIImage *img;

@end

@implementation TitleButton

+(id)titleButton{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img=[UIImage imageWithName:@"navigationbar_arrow_down"];
        [self setImage:self.img forState:UIControlStateNormal];
        UIImage *img=[UIImage imageNamed:@"navigationbar_filter_background_highlighted"];
        img=[img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
        [self setBackgroundImage:img forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //高亮时不要吧内部图片变灰
        self.adjustsImageWhenHighlighted=NO;
        }
    return self;
    
    ;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageY=12;
    CGFloat imageW=self.img.size.width;
    CGFloat imageX=contentRect.size.width-self.img.size.width-Kmargin;
    CGFloat imageH=self.img.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX=Kmargin;
    CGFloat titleY=0;
    CGFloat titleW=contentRect.size.width;
    CGFloat titleH=contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
