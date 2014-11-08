//
//  ADNavigationViewController.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADNavigationViewController.h"
#import "UIImage+AD.h"

@interface ADNavigationViewController ()

@end

@implementation ADNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //1.设置导航栏主题
        [self initNaviBar];
    }
    return self;
}

+(void)initialize{
    //2.设置导航栏按钮
    [self initBarButtonItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initNaviBar{
    //导航条背景
    if(!iOS7){
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackOpaque;
    }
    //导航条文字
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor]=[UIColor blackColor];
    //取消文字阴影
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    [self.navigationBar setTitleTextAttributes:textAttrs];
    
}
//导航栏按钮(自定义按钮)
+(void)initBarButtonItem{
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    //背景
    if(!iOS7){
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    //文字
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor]=iOS7?[UIColor orangeColor]:[UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset]=[NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:iOS7?14:12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *textAttrs2=[NSMutableDictionary dictionary];
    textAttrs2[UITextAttributeTextColor]=[UIColor grayColor];
    [item setTitleTextAttributes:textAttrs2 forState:UIControlStateDisabled];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //大于0代表不是主页面的ctrl，是后来push进来的ctrl 需要隐藏BottomBar
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
    

}

@end
