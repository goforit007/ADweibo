//
//  ADWeiboView.m
//  ADweibo
//
//  Created by fad on 14-11-12.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADWeiboView.h"
#import "UIImage+AD.h"
#import "UIImageView+WebCache.h"

@implementation ADWeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化原创微博View
        [self initWeiboViews];
        //初始化转发微博View
        [self initRetWeibos];

    }
    return self;
}

- (void)setWeiboFrameModel:(WeiboFrameModel *)weiboFrameModel{
    _weiboFrameModel=weiboFrameModel;
    //设置原创微博数据
    [self setWeiboViewsData];
    //设置转发微博数据
    [self setRetWeiboViewsData];
}

//初始化原创微博控件
-(void)initWeiboViews{
    //1.微博大背景
    self.weiboBGImageView=[[UIImageView alloc]init];
    UIImage *img=[UIImage imageWithName:@"timeline_card_top_background"];
    self.weiboBGImageView.image=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    UIImage *highlightedimg=[UIImage imageWithName:@"timeline_card_top_background_highlighted"];
    self.weiboBGImageView.highlightedImage=[highlightedimg stretchableImageWithLeftCapWidth:highlightedimg.size.width/2 topCapHeight:highlightedimg.size.height/2];
    
    [self addSubview:self.weiboBGImageView];
    //2.头像
    self.weiboIconImageView=[[UIImageView alloc]init];
    [self.weiboBGImageView addSubview:self.weiboIconImageView];
    //3.昵称
    self.weiboNameLabel=[[UILabel alloc]init];
    [self.weiboBGImageView addSubview:self.weiboNameLabel];
    //4.时间
    self.weiboTimeLabel=[[UILabel alloc]init];
    [self.weiboBGImageView addSubview:self.weiboTimeLabel];
    //5.来源
    self.weiboSourceLabel=[[UILabel alloc]init];
    [self.weiboBGImageView addSubview:self.weiboSourceLabel];
    //6.正文
    self.weiboTextLabel=[[UILabel alloc]init];
    [self.weiboBGImageView addSubview:self.weiboTextLabel];
    //7.图片
    self.weiboPhotoImageView=[[UIImageView alloc]init];
    [self.weiboBGImageView addSubview:self.weiboPhotoImageView];
}
//初始化转发微博控件
-(void)initRetWeibos{
    //1.转发微博的背景
    self.retWeiboBGImageView=[[UIImageView alloc]init];
    self.retWeiboBGImageView.userInteractionEnabled=YES;
    UIImage *img=[UIImage imageWithName:@"timeline_retweet_background"];
    self.retWeiboBGImageView.image=[img stretchableImageWithLeftCapWidth:img.size.width-5 topCapHeight:img.size.height/2];
#warning 没有这个图片
    UIImage *highlightedimg=[UIImage imageWithName:@"timeline_retweet_background_highlighted"];
    
    self.retWeiboBGImageView.highlightedImage=[highlightedimg stretchableImageWithLeftCapWidth:img.size.width-5 topCapHeight:highlightedimg.size.height/2];
    
    [self.weiboBGImageView addSubview:self.retWeiboBGImageView];
    //2.昵称
    self.retweiboNameLabel=[[UILabel alloc]init];
    [self.retWeiboBGImageView addSubview:self.retweiboNameLabel];
    //3.文本
    self.retweiboTextLabel=[[UILabel alloc]init];
    [self.retWeiboBGImageView addSubview:self.retweiboTextLabel];
    //4.图片
    self.retweiboPhotoImageView=[[UIImageView alloc]init];
    [self.retWeiboBGImageView addSubview:self.retweiboPhotoImageView];
}


-(void)setWeiboViewsData{
    NSURL *url=[NSURL URLWithString:_weiboFrameModel.weibo.user.profile_image_url];
    [self.weiboIconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    self.weiboNameLabel.font=kNameUIFont;
    self.weiboNameLabel.text=_weiboFrameModel.weibo.user.name;
    
    self.weiboTimeLabel.textColor=[UIColor orangeColor];
    self.weiboTimeLabel.font=kTImeUIFont;
    self.weiboTimeLabel.text=_weiboFrameModel.weibo.created_at;
    
    self.weiboSourceLabel.font=kSourceUIFont;
    self.weiboSourceLabel.text=_weiboFrameModel.weibo.source;
    
    self.weiboTextLabel.numberOfLines=0;
    self.weiboTextLabel.font=kTTextUIFont;
    self.weiboTextLabel.text=_weiboFrameModel.weibo.text;
    
    NSURL *photoUrl=[NSURL URLWithString:_weiboFrameModel.weibo.thumbnail_pic];
    [self.weiboPhotoImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"close"]];
}
-(void)setRetWeiboViewsData{
    //1.转发微博的背景
    
    //2.昵称
    self.retweiboNameLabel.textColor=[UIColor blueColor];
    self.retweiboNameLabel.font=kRetTextUIFont;
    self.retweiboNameLabel.text=self.weiboFrameModel.weibo.retweeted_status.user.name;
    //3.文本
    self.retweiboTextLabel.numberOfLines=0;
    self.retweiboTextLabel.font=kRetTextUIFont;
    self.retweiboTextLabel.text=self.weiboFrameModel.weibo.retweeted_status.text;
    //4.图片
    NSURL *url=[NSURL URLWithString:self.weiboFrameModel.weibo.retweeted_status.thumbnail_pic];
    [self.retweiboPhotoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"close"]];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //原创微博Frame
    self.weiboBGImageView.frame=_weiboFrameModel.weiboBGImageFrame;
    self.weiboIconImageView.frame=_weiboFrameModel.weiboIconImageFrame;
    self.weiboNameLabel.frame=_weiboFrameModel.weiboNameLabelFrame;
    self.weiboTimeLabel.frame=_weiboFrameModel.weiboTimeLabelFrame;
    self.weiboSourceLabel.frame=_weiboFrameModel.weiboSourceLabelFrame;
    self.weiboTextLabel.frame=_weiboFrameModel.weiboTextLabelFrame;
    self.weiboPhotoImageView.frame=_weiboFrameModel.weiboPhotoImageFrame;
    //转发微博Frame
    self.retWeiboBGImageView.frame=_weiboFrameModel.retWeiboBGImageFrame;
    self.retweiboNameLabel.frame=_weiboFrameModel.retweiboNameLabelFrame;
    self.retweiboTextLabel.frame=_weiboFrameModel.retweiboTextLabelFrame;
    self.retweiboPhotoImageView.frame=_weiboFrameModel.retweiboPhotoImageFrame;
}

@end
