//
//  ADBadgeButton.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADBadgeButton.h"
#import "UIImage+AD.h"

@interface ADBadgeButton()

@property(nonatomic,strong)UIImage *BackgroundImg;

@end

@implementation ADBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        //返回一个会伸缩的图片
        UIImage *img=[UIImage imageWithName:@"main_badge"];
        self.BackgroundImg=[img stretchableImageWithLeftCapWidth:img.size.width*0.5 topCapHeight:img.size.height*0.5];
        [self setBackgroundImage:self.BackgroundImg forState:UIControlStateNormal];
    }
    return self;
}
//设置badgeValue时，修改bounds
- (void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue=[badgeValue copy];
    [self setTitle:_badgeValue forState:UIControlStateNormal];
    CGSize valueSize=[badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat W=valueSize.width+10;
    CGFloat H=self.BackgroundImg.size.height;
    self.bounds=CGRectMake(0, 0, W, H);
}


@end
