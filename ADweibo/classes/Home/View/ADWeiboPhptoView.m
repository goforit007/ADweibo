//
//  ADWeiboPhptoView.m
//  ADweibo
//
//  Created by fad on 14-11-13.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADWeiboPhptoView.h"
#import "UIImageView+WebCache.h"
#import "WeiboFrameModel.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define KPhotoMaxCount 9

@interface ADWeiboPhptoView()

@end

@implementation ADWeiboPhptoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        //初始化的时候创建所有图片视图，重用的时候就不用再次创建了性能好
        for(int i=0;i<KPhotoMaxCount;i++){
            UIImageView *photoView=[[UIImageView alloc]init];
            photoView.tag=i;
            photoView.hidden=YES;
            //设置图片伸缩模式
            photoView.contentMode=UIViewContentModeScaleAspectFit;
            //photoView.contentMode=UIViewContentModeScaleAspectFill;
            //超出范围的图片剪切掉
            //photoView.clipsToBounds=YES;
            //添加点击手势
            photoView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotoTap:)];
            [photoView addGestureRecognizer:tap];
            [self addSubview:photoView];
        }
    }
    return self;
}

-(void)PhotoTap:(UITapGestureRecognizer *)tap{
    int count = self.photos.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        //拿出图片地址
        NSDictionary *photoDict=_photos[i];
        NSString *photoStr=photoDict[@"thumbnail_pic"];
        //把缩略图换成中等图片
        NSString *url = [photoStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url=[NSURL URLWithString:url]; // 图片路径
        photo.srcImageView=self.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}

- (void)setPhotos:(NSArray *)photos{
    _photos=photos;

    //遍历所有子控件，有图片的显，没有的隐藏
    for(int i=0;i<KPhotoMaxCount;i++){
        //拿到iamgeView
        UIImageView *photoView=self.subviews[i];
        if(i<photos.count){
            photoView.hidden=NO;
            //拿出图片地址
            NSDictionary *photoDict=_photos[i];
            NSString *photoStr=photoDict[@"thumbnail_pic"];
            //设置图片
            NSURL *url=[NSURL URLWithString:photoStr];
            [photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }
        //大于用户图片数量的 imageView
        else{
            photoView.image=nil;
            photoView.hidden=YES;
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    int photoCount=self.subviews.count;
    
    //有几列
    int clos=photoCount>3?3:photoCount;
    //有几排
    int rows=photoCount/3;
    if(photoCount%3!=0){
        rows++;
    }
    for (int i=0; i<photoCount; i++) {
        //计算行号和列号
        int row=i/clos;
        int clo=i%clos;
        
        CGFloat X=clo*(kWeiboPhontSize+kWeiboPhontPadding);
        CGFloat Y=row*(kWeiboPhontSize+kWeiboPhontPadding);
        UIImageView *imageView=self.subviews[i];
        imageView.frame=CGRectMake(X, Y, kWeiboPhontSize, kWeiboPhontSize);
    }
    
}

@end
