//
//  AppDelegate.h
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADTabBarController;
@class OAuthViewControllViewController;
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)ADTabBarController *tabBarController;


@end
