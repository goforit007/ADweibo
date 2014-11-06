//
//  ADTabBar.h
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADTabBar : UIView

@property(nonatomic,copy)void (^btnClickBlock)(int);
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
