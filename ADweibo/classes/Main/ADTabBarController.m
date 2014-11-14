//
//  ADTabBarController.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "ADTabBarController.h"

#import "ADHomeTableViewController.h"
#import "ADMessageTableViewController.h"
#import "ADMeTableViewController.h"
#import "ADDiscoverTableViewController.h"
#import "ADNavigationViewController.h"
#import "UIImage+AD.h"
#import "ADTabBar.h"

@interface ADTabBarController ()

@property(nonatomic,strong)ADTabBar *customTabBar;
@property(nonatomic,strong)NSMutableArray *subCtrls;

@end

@implementation ADTabBarController

- (NSMutableArray *)subCtrls{
    if(_subCtrls==nil){
        _subCtrls=[NSMutableArray array];
    }
    return _subCtrls;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化自动以tabBar
    [self initCustomTabbar];
    //初始化所有子控制器
    [self initAllChildViewControll];
    //监视按钮点击
    [self btnclick];

}
//viw即将显示的时候，删除系统自带的tabBarItem
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化所有的控制器
 */
-(void)initAllChildViewControll{
    //1.首页
    ADHomeTableViewController *home=[[ADHomeTableViewController alloc]init];
    [self initChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    //2.消息
    ADMessageTableViewController *message=[[ADMessageTableViewController alloc]init];
    [self initChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    //3.广场
    ADDiscoverTableViewController *discover=[[ADDiscoverTableViewController alloc]init];
    [self initChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    //4.我
    ADMeTableViewController *me=[[ADMeTableViewController alloc]init];
    [self initChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}
/**
 *  初始化一个具体的控制器
 */
-(void)initChildViewController:(UIViewController *)childCtrl title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    childCtrl.title = title;
    childCtrl.tabBarItem.image = [UIImage imageWithName:imageName];
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        childCtrl.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childCtrl.tabBarItem.selectedImage = selectedImage;
    }
    [self.subCtrls addObject:childCtrl];
    ADNavigationViewController *navi=[[ADNavigationViewController alloc] initWithRootViewController:childCtrl];
    [self addChildViewController:navi];
    //添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childCtrl.tabBarItem];
}
-(void)initCustomTabbar{
    self.customTabBar=[[ADTabBar alloc]init];
    self.customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:self.customTabBar];
}
//tarBarBtn重复点击的话，如果对应的控制器有clickAgain方法就自动刷新
-(void)btnclick{
    __weak typeof(self) tarBarCtrl=self;
    __weak NSMutableArray *tempSubArr=self.subCtrls;
    self.customTabBar.btnClickBlock=^(int tag,BOOL isClickAgain){
        tarBarCtrl.selectedIndex=tag;
        if(isClickAgain){
            if([tempSubArr[tag] respondsToSelector:@selector(clickAgain)]){
                [tempSubArr[tag] performSelector:@selector(clickAgain)];
            }
        }
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
