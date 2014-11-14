//
//  WelcomeViewController.m
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "WelcomeViewController.h"

#define pageNum 3

@interface WelcomeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //滚动视图
    [self initScrollView];
    //pageControll
    [self initPageControll];
}

-(void)initScrollView{
    //设置滚动视图
    self.scrollView=[[UIScrollView alloc]init];
    self.scrollView.frame=self.view.bounds;
    
    CGFloat imageW=self.scrollView.frame.size.width;
    CGFloat imageH=self.scrollView.frame.size.height;
    for(int i=0;i<pageNum;i++){
        UIImageView *imageView=[[UIImageView alloc]init];
        //LaunchImage才会自动加载568图片，这里的需要自己加载
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%i",i+1];
        if([UIScreen mainScreen].bounds.size.height==568){
            imageName=[NSString stringWithFormat:@"%@-568h@2x",imageName];
        }
        imageView.image=[UIImage imageNamed:imageName];
        imageView.frame=CGRectMake(i*imageW,0 , imageW, imageH);
        //最后一个界面需要添加几个按钮
        if(i==(pageNum-1)){
            [self SetBtnWithImageView:imageView];
        }
        [self.scrollView addSubview:imageView];
    }
    //滚动范围
    self.scrollView.contentSize=CGSizeMake(imageW*pageNum, imageH);
    //取消滚动条
    self.scrollView.showsVerticalScrollIndicator=NO;
    //分页滚动
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    [self.view addSubview:self.scrollView];
}
-(void)initPageControll{
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.numberOfPages=pageNum;
    //禁止用户点击移动小圆点
    self.pageControl.userInteractionEnabled=NO;
    CGFloat imageW=self.scrollView.frame.size.width;
    CGFloat imageH=self.scrollView.frame.size.height;
    self.pageControl.center=CGPointMake(imageW/2, imageH-30);
    self.pageControl.bounds=CGRectMake(0, 0, 100, 30);
    //设置颜色
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    [self.view addSubview:self.pageControl];
}
//捕捉滚动，改变pageControll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX=scrollView.contentOffset.x;
    self.pageControl.currentPage=offsetX/scrollView.frame.size.width;
}
//添加最后一个页面的按钮
-(void)SetBtnWithImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled=YES;
    //开始按钮
    UIButton *stratBtn=[[UIButton alloc]init];
    [stratBtn setTitle:@"开始体验" forState:UIControlStateNormal];
    [stratBtn setTitle:@"开始体验" forState:UIControlStateHighlighted];
    [stratBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [stratBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    stratBtn.bounds=(CGRect){CGPointZero,stratBtn.currentBackgroundImage.size};
    stratBtn.center=CGPointMake(self.scrollView.bounds.size.width/2, self.scrollView.bounds.size.height*0.6);
    [stratBtn addTarget:self action:@selector(stratBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:stratBtn];
    //分享按钮
    UIButton *checkBoxBtn=[[UIButton alloc]init];
    [checkBoxBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [checkBoxBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
    [checkBoxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBoxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    checkBoxBtn.bounds=(CGRect){CGPointZero,stratBtn.bounds.size.width+20,stratBtn.bounds.size.height};
    checkBoxBtn.center=CGPointMake(stratBtn.center.x, stratBtn.center.y-40);
    [checkBoxBtn addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮image
    checkBoxBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkBoxBtn];
}
//分享按钮被点击
-(void)checkBoxClick:(UIButton *)btn{
    btn.selected=!btn.selected;
}
//开始按钮被点击
-(void)stratBtnClick:(UIButton *)btn{
    self.startBlock();
}
-(void)dealloc{
    NSLog(@"欢迎界面 over");
}
@end
