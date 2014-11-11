//
//  WeiboCell.m
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "WeiboCell.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+AD.h"
#import "UIView+frameExtension.h"

@interface WeiboCell()
//原始微博控件
@property(nonatomic,strong)UIImageView *weiboBGImageView;
@property(nonatomic,strong)UIImageView *weiboIconImageView;
@property(nonatomic,strong)UILabel *weiboNameLabel;
@property(nonatomic,strong)UILabel *weiboTimeLabel;
@property(nonatomic,strong)UILabel *weiboSourceLabel;
@property(nonatomic,strong)UILabel *weiboTextLabel;
@property(nonatomic,strong)UIImageView *weiboPhotoImageView;
//被转发微博控件
@property(nonatomic,strong)UIImageView *retWeiboBGImageView;
@property(nonatomic,strong)UILabel *retweiboNameLabel;
@property(nonatomic,strong)UILabel *retweiboTextLabel;
@property(nonatomic,strong)UIImageView *retweiboPhotoImageView;
//微博操作按钮
@property(nonatomic,strong)UIImageView *toolView;

@end

@implementation WeiboCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        //取消选中时的背景
        self.selectedBackgroundView=[[UIView alloc]init];
        
        [self initWeiboViews];
        [self initRetWeibos];
        [self initWeiboToolViews];
    }
    return self;
}
//初始化原创微博控件
-(void)initWeiboViews{
    //1.微博大背景
    self.weiboBGImageView=[[UIImageView alloc]init];
    UIImage *img=[UIImage imageWithName:@"timeline_card_top_background"];
    self.weiboBGImageView.image=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    UIImage *highlightedimg=[UIImage imageWithName:@"timeline_card_top_background_highlighted"];
    self.weiboBGImageView.highlightedImage=[highlightedimg stretchableImageWithLeftCapWidth:highlightedimg.size.width/2 topCapHeight:highlightedimg.size.height/2];
    
    [self.contentView addSubview:self.weiboBGImageView];
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
    UIImage *img=[UIImage imageWithName:@"timeline_retweet_background"];
    self.retWeiboBGImageView.image=[img stretchableImageWithLeftCapWidth:img.size.width-5 topCapHeight:img.size.height/2];
    
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
//初始化微博工具条
-(void)initWeiboToolViews{
    self.toolView=[[UIImageView alloc]init];
    UIImage *img=[UIImage imageWithName:@"timeline_card_bottom_background"];
    self.toolView.image=[img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    UIImage *highlightedimg=[UIImage imageWithName:@"timeline_card_bottom_background_highlighted"];
    self.toolView.highlightedImage=[highlightedimg stretchableImageWithLeftCapWidth:highlightedimg.size.width/2 topCapHeight:img.size.height/2];
    
    [self.weiboBGImageView addSubview:self.toolView];
}


//设置Frame数据的时候
- (void)setWeiboFrame:(WeiboFrameModel *)weiboFrame{
    _weiboFrame=weiboFrame;
    //设置原创微博数据
    [self setWeiboViewsData];
    //设置转发微博数据
    [self setRetWeiboViewsData];
}
-(void)setWeiboViewsData{
    self.weiboBGImageView.frame=_weiboFrame.weiboBGImageFrame;
    
    NSURL *url=[NSURL URLWithString:_weiboFrame.weibo.user.profile_image_url];
    [self.weiboIconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    self.weiboNameLabel.font=kNameUIFont;
    self.weiboNameLabel.text=_weiboFrame.weibo.user.name;
    
    self.weiboTimeLabel.textColor=[UIColor orangeColor];
    self.weiboTimeLabel.font=kTImeUIFont;
    self.weiboTimeLabel.text=_weiboFrame.weibo.created_at;
    
    self.weiboSourceLabel.font=kSourceUIFont;
    self.weiboSourceLabel.text=_weiboFrame.weibo.source;
    
    self.weiboTextLabel.numberOfLines=0;
    self.weiboTextLabel.font=kTTextUIFont;
    self.weiboTextLabel.text=_weiboFrame.weibo.text;
    
    NSURL *photoUrl=[NSURL URLWithString:_weiboFrame.weibo.thumbnail_pic];
    [self.weiboPhotoImageView sd_setImageWithURL:photoUrl placeholderImage:[UIImage imageNamed:@"close"]];
}
-(void)setRetWeiboViewsData{
    //1.转发微博的背景
    //self.retWeiboBGImageView
    //2.昵称
    self.retweiboNameLabel.textColor=[UIColor blueColor];
    self.retweiboNameLabel.font=kRetTextUIFont;
    self.retweiboNameLabel.text=self.weiboFrame.weibo.retweeted_status.user.name;
    //3.文本
    self.retweiboTextLabel.numberOfLines=0;
    self.retweiboTextLabel.font=kRetTextUIFont;
    self.retweiboTextLabel.text=self.weiboFrame.weibo.retweeted_status.text;
    //4.图片
    NSURL *url=[NSURL URLWithString:self.weiboFrame.weibo.retweeted_status.thumbnail_pic];
    [self.retweiboPhotoImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"close"]];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //原创微博Frame
    self.weiboIconImageView.frame=_weiboFrame.weiboIconImageFrame;
    self.weiboNameLabel.frame=_weiboFrame.weiboNameLabelFrame;
    self.weiboTimeLabel.frame=_weiboFrame.weiboTimeLabelFrame;
    self.weiboSourceLabel.frame=_weiboFrame.weiboSourceLabelFrame;
    self.weiboTextLabel.frame=_weiboFrame.weiboTextLabelFrame;
    self.weiboPhotoImageView.frame=_weiboFrame.weiboPhotoImageFrame;
    //转发微博Frame
    self.retWeiboBGImageView.frame=_weiboFrame.retWeiboBGImageFrame;
    self.retweiboNameLabel.frame=_weiboFrame.retweiboNameLabelFrame;
    self.retweiboTextLabel.frame=_weiboFrame.retweiboTextLabelFrame;
    self.retweiboPhotoImageView.frame=_weiboFrame.retweiboPhotoImageFrame;
    //工具条Frame
    self.toolView.frame=_weiboFrame.toolViewFrame;
}
//拦截setFrame 修改cell整体的大小 和边距
- (void)setFrame:(CGRect)frame{
    frame.origin.x=kTableBorder;
    //每个cell的Y加上了一个kTableBorder边距，会让整个tableView的底部减少kTableBorder的长度，增加滚动视图的滚动范围，解决问题
    frame.origin.y+=kTableBorder;
    frame.size.width-=kTableBorder*2;
    frame.size.height-=kTableBorder;
    [super setFrame:frame];
}

@end
