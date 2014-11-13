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
#import "ADWeiboToolBar.h"
#import "ADWeiboView.h"

@interface WeiboCell()

//微博View
@property(nonatomic,strong)ADWeiboView *weiboView;
//微博操作按钮
@property(nonatomic,strong)ADWeiboToolBar *weiboToolBarView;

@end

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        //取消选中时的背景
        self.selectedBackgroundView=[[UIView alloc]init];
        //微博内容View
        self.weiboView=[[ADWeiboView alloc]init];
        [self.contentView addSubview:self.weiboView];
        //初始化工具条
        self.weiboToolBarView=[[ADWeiboToolBar alloc]init];
        [self.contentView addSubview:self.weiboToolBarView];
    }
    return self;
}
//设置Frame数据的时候,数据传递给微博和工具条
- (void)setWeiboFrame:(WeiboFrameModel *)weiboFrame{
    _weiboFrame=weiboFrame;
    self.weiboView.weiboFrameModel=_weiboFrame;
    self.weiboToolBarView.weibo=_weiboFrame.weibo;
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

- (void)layoutSubviews{
    [super layoutSubviews];
    //微博frame
    self.weiboView.frame=_weiboFrame.weiboBGImageFrame;
    //工具条Frame
    self.weiboToolBarView.frame=_weiboFrame.toolViewFrame;
}

@end
