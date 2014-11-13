//
//  ADWeiboToolBar.m
//  ADweibo
//
//  Created by fad on 14-11-12.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADWeiboToolBar.h"
#import "UIImage+AD.h"
#import "UIView+frameExtension.h"

@interface ADWeiboToolBar()
//按钮
@property(nonatomic,strong)UIButton *reweetBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *attitude;
//分割线
@property(nonatomic,strong)UIImageView *dividerL;
@property(nonatomic,strong)UIImageView *dividerR;

@end

@implementation ADWeiboToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        
        //1.设置图片
        UIImage *img=[UIImage imageWithName:@"timeline_card_bottom_background"];
        self.image=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
        
        UIImage *highlightedimg=[UIImage imageWithName:@"timeline_card_bottom_background_highlighted"];
        self.highlightedImage=[highlightedimg stretchableImageWithLeftCapWidth:highlightedimg.size.width/2 topCapHeight:img.size.height/2];
        //2.设置子控件
        [self initSubViews];
        //3.添加分割线
        [self initDivider];
    }
    return self;
}

-(void)initSubViews{
    //1.转发按钮
    self.reweetBtn=[self setToolBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
    [self addSubview:self.reweetBtn];
    //2.评论按钮
    self.commentBtn=[self setToolBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
    [self addSubview:self.commentBtn];
    //3.赞按钮
    self.attitude=[self setToolBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
    [self addSubview:self.attitude];
}

-(void)initDivider{
    self.dividerL=[[UIImageView alloc]init];
    self.dividerL.image=[UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:self.dividerL];
    
    self.dividerR=[[UIImageView alloc]init];
    self.dividerR.image=[UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:self.dividerR];
}

-(UIButton *)setToolBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    //按钮高亮的时候按钮内部不要高亮
    btn.adjustsImageWhenHighlighted=NO;
    //设置按钮内部label边距
    btn.imageEdgeInsets=UIEdgeInsetsMake(-3, 0, 0, 5);
    
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    
    UIImage *img=[UIImage imageWithName:bgImage];
    img=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    [btn setBackgroundImage:img forState:UIControlStateHighlighted];
    
    return btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //按钮
    CGFloat btnW=self.width/3;
    CGFloat btnH=self.height;
    self.reweetBtn.frame=CGRectMake(0, 0, 100, 40);
    self.commentBtn.frame=CGRectMake(btnW, 0, btnW, btnH);
    self.attitude.frame=CGRectMake(2*btnW, 0, btnW, btnH);
    //分割线
    CGFloat dividerX=CGRectGetMaxX(self.reweetBtn.frame);
    CGFloat dividerH=self.height;
    self.dividerL.frame=CGRectMake(dividerX, 0, 1, dividerH);
    self.dividerR.frame=CGRectMake(dividerX*2, 0, 1, dividerH);
}

- (void)setWeibo:(WeiboModel *)weibo{
    _weibo=weibo;
    NSNumber *reweetCount=_weibo.reposts_count;
    if([reweetCount intValue]>0){
        NSString *reweetCountStr=[NSString stringWithFormat:@"%@",reweetCount];
        [self.reweetBtn setTitle:reweetCountStr forState:UIControlStateNormal];
    }
     NSNumber *commentCount=_weibo.comments_count;
    if([commentCount intValue]>0){
        NSString *commentCountStr=[NSString stringWithFormat:@"%@",commentCount];
        [self.commentBtn setTitle:commentCountStr forState:UIControlStateNormal];
    }
    NSNumber *attitudesCount=_weibo.attitudes_count;
    if([attitudesCount intValue]>0){
        NSString *attitudesCountStr=[NSString stringWithFormat:@"%@",attitudesCount];
        [self.attitude setTitle:attitudesCountStr forState:UIControlStateNormal];
    }

}

@end
