//
//  WeiboFrameModel.m
//  ADweibo
//
//  Created by fad on 14-11-10.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "WeiboFrameModel.h"
#import "UserModel.h"


@implementation WeiboFrameModel

-(void)setWeibo:(WeiboModel *)weibo{
    _weibo=weibo;
    
    //cell宽度  cell里面setFrame把cell的宽度减去了20所以这里的cell宽度应该是屏幕-20 kTableBorder=10
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width-kTableBorder*2;
    //微博背景
    CGFloat BGImageX=0;
    CGFloat BGImageY=0;
    CGFloat BGImageW=cellW;

    //头像
    CGFloat IconImageX=kWeiboCellBorder;
    CGFloat IconImageY=kWeiboCellBorder;
    CGFloat IconImageW=35;
    CGFloat IconImageH=35;
    _weiboIconImageFrame=CGRectMake(IconImageX, IconImageY, IconImageW, IconImageH);
    //昵称
    CGFloat NameLabelX=CGRectGetMaxX(_weiboIconImageFrame)+kWeiboCellBorder;
    CGFloat NameLabelY=kWeiboCellBorder;
    CGSize nameSize=[_weibo.user.name sizeWithFont:kNameUIFont];
    CGFloat NameLabelW=nameSize.width;
    CGFloat NameLabelH=nameSize.height;
    _weiboNameLabelFrame=CGRectMake(NameLabelX,NameLabelY, NameLabelW, NameLabelH);
    //时间
    CGFloat TimeLabelX=NameLabelX;
    CGFloat TimeLabelY=CGRectGetMaxY(_weiboNameLabelFrame)+kWeiboCellBorder;
    CGSize timeSize=[_weibo.created_at sizeWithFont:kTImeUIFont];
    //CGFloat TimeLabelW=timeSize.width;
    CGFloat TimeLabelH=timeSize.height;
    _weiboTimeLabelFrame=CGRectMake(TimeLabelX,TimeLabelY, 60, TimeLabelH);
    //来源
    CGFloat SourceLabelX=CGRectGetMaxX(_weiboTimeLabelFrame)+kWeiboCellBorder;
    CGFloat SourceLabelY=TimeLabelY;
    CGSize SourceLabelSize=[_weibo.source sizeWithFont:kSourceUIFont];
    CGFloat SourceLabelW=SourceLabelSize.width;
    CGFloat SourceLabelH=SourceLabelSize.height;
    _weiboSourceLabelFrame=CGRectMake(SourceLabelX,SourceLabelY, SourceLabelW, SourceLabelH);
    //正文
    CGFloat TextLabelX=kWeiboCellBorder;
    CGFloat TextLabelY=MAX(CGRectGetMaxY(_weiboIconImageFrame), CGRectGetMaxY(_weiboTimeLabelFrame))+kWeiboCellBorder;
    CGSize contentSize=CGSizeMake(BGImageW-2*kWeiboCellBorder, CGFLOAT_MAX);
    CGSize TextSize=[self.weibo.text sizeWithFont:kTTextUIFont constrainedToSize:contentSize];
    CGFloat TextLabelW=TextSize.width;
    CGFloat TextLabelH=TextSize.height;
    _weiboTextLabelFrame=CGRectMake(TextLabelX, TextLabelY, TextLabelW, TextLabelH);
    
    //图片
    if(weibo.pic_urls.count){
        CGFloat photoImageX=kWeiboCellBorder;
        CGFloat photoImageY=CGRectGetMaxY(_weiboTextLabelFrame)+kWeiboCellBorder;
        //每张图片的宽高
        CGFloat ImageW=kWeiboPhontSize;
        CGFloat ImageH=kWeiboPhontSize;
        //每张图片的间距
        CGFloat Padding=kWeiboPhontPadding;
        //每排图片的数量
        int clos=(int)weibo.pic_urls.count>3?3:weibo.pic_urls.count;
        //有几排
        int rows=(int)weibo.pic_urls.count/3;
        if(weibo.pic_urls.count%3!=0){
            rows++;
        }
        
        CGFloat W=clos*ImageW+Padding*(clos-1);
        CGFloat H=rows*ImageH+Padding*(rows-1);
        
        _weiboPhotoImageFrame=CGRectMake(photoImageX, photoImageY, W, H);
    }else{
        _weiboPhotoImageFrame=CGRectMake(0,CGRectGetMaxY(_weiboTextLabelFrame),0,0);
    }
    
    //被转发微博
    if(weibo.retweeted_status){
        //背景
        CGFloat RetBGImageViewX=kWeiboCellBorder;
        CGFloat RetBGImageViewY=CGRectGetMaxY(_weiboPhotoImageFrame)+kWeiboCellBorder;
        CGFloat RetBGImageViewW=BGImageW-kWeiboCellBorder*2;
        //昵称
        CGFloat RetNameLabelX=kWeiboCellBorder;
        CGFloat RetNameLabelY=kWeiboCellBorder*2;
        CGSize RetnameSize=[_weibo.retweeted_status.user.name sizeWithFont:kRetTextUIFont];
        CGFloat RetNameLabelW=RetnameSize.width;
        CGFloat RetNameLabelH=RetnameSize.height;
        _retweiboNameLabelFrame=CGRectMake(RetNameLabelX,RetNameLabelY, RetNameLabelW, RetNameLabelH);
        //正文
        CGFloat TextLabelX=kWeiboCellBorder;
        CGFloat TextLabelY=CGRectGetMaxY(_retweiboNameLabelFrame)+kWeiboCellBorder;
        CGSize contentSize=CGSizeMake(RetBGImageViewW-2*kWeiboCellBorder, CGFLOAT_MAX);
        CGSize TextSize=[self.weibo.retweeted_status.text sizeWithFont:kTTextUIFont constrainedToSize:contentSize];
        CGFloat TextLabelW=TextSize.width;
        CGFloat TextLabelH=TextSize.height;
        _retweiboTextLabelFrame=CGRectMake(TextLabelX, TextLabelY, TextLabelW, TextLabelH);
        //图片
        if(weibo.retweeted_status.pic_urls.count){
            CGFloat retphotoImageX=kWeiboCellBorder;
            CGFloat retphotoImageY=CGRectGetMaxY(_retweiboTextLabelFrame)+kWeiboCellBorder;
            //每张图片的宽高
            CGFloat ImageW=kWeiboPhontSize;
            CGFloat ImageH=kWeiboPhontSize;
            //每张图片的间距
            CGFloat Padding=kWeiboPhontPadding;
            //每排图片的数量
            int clos=weibo.retweeted_status.pic_urls.count>3?3:weibo.retweeted_status.pic_urls.count;
            //有几排
            int rows=weibo.retweeted_status.pic_urls.count/3;
            if(weibo.retweeted_status.pic_urls.count%3!=0){
                rows++;
            }
            
            CGFloat W=clos*ImageW+Padding*(clos-1);
            CGFloat H=rows*ImageH+Padding*(rows-1);
            _retweiboPhotoImageFrame=CGRectMake(retphotoImageX, retphotoImageY, W, H);
            /**
             *  有转发，并且有图片
             */
            CGFloat RetBGImageViewH=CGRectGetMaxY(_retweiboPhotoImageFrame)+kWeiboCellBorder;
            _retWeiboBGImageFrame=CGRectMake(RetBGImageViewX, RetBGImageViewY, RetBGImageViewW, RetBGImageViewH);
        }else{
            /**
             *  有转发，没有图片
             */
            CGFloat RetBGImageViewH=CGRectGetMaxY(_retweiboTextLabelFrame)+kWeiboCellBorder;
            _retWeiboBGImageFrame=CGRectMake(RetBGImageViewX, RetBGImageViewY, RetBGImageViewW, RetBGImageViewH);
        }
    }else{
        /**
         *  没有转发
         */
        CGFloat RetBGImageViewY=CGRectGetMaxY(_weiboPhotoImageFrame)+kWeiboCellBorder;
        _retWeiboBGImageFrame=CGRectMake(0, RetBGImageViewY, 0, 0);
    }
    //还需要加入一个工具条的高度
    CGFloat toolH=CGRectGetMaxY(_retWeiboBGImageFrame)+kWeiboCellBorder;
    _toolViewFrame=CGRectMake(0, toolH, BGImageW, 40);
    //微博大背景
    CGFloat BGImageH=CGRectGetMaxY(_toolViewFrame);
    _weiboBGImageFrame=CGRectMake(BGImageX, BGImageY, BGImageW, BGImageH-1);
    //设置cell高度  //加上一个table边距，吧cell撑大一点，然后在cell的setFrame里面减去cell的这个kTableBorder ，扩大cell的间距
    self.cellH=CGRectGetMaxY(_weiboBGImageFrame)+kTableBorder;
}

@end
