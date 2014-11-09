//
//  AppDelegate.m
//  ADweibo
//
//  Created by fad on 14-11-7.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "AppDelegate.h"
#import "ADTabBarController.h"
#import "WelcomeViewController.h"
#import "SinaOAuth.h"

@implementation AppDelegate

#warning revealapp在 TARGETS --> Settings --> Other Linker Flags -->添加命令 -ObjC

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //取消隐藏状态栏
    application.statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //初始化主页面
    self.tabBarController=[[ADTabBarController alloc] init];
    //欢迎页面显示判断 如果当前版本号和userdefault版本号一样加载主页面，否则加载欢迎界面
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *lastVersion=[defaults stringForKey:@"codeVersion"];
    NSString *nowVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if([lastVersion isEqualToString:nowVersion]){
        self.window.rootViewController = self.tabBarController;
        //判断登陆状态,没有登陆的话进行登录
        [self oauth];
    }else{
        WelcomeViewController *welcomeCtrl=[[WelcomeViewController alloc]init];
        self.window.rootViewController=welcomeCtrl;
        welcomeCtrl.startBlock=^{
            self.window.rootViewController=self.tabBarController;
            //判断登陆状态,没有登陆的话进行登录
            [self oauth];
            [defaults setObject:nowVersion forKey:@"codeVersion"];
            [defaults synchronize];
        };
    }
    return YES;
}

-(void)oauth{
    SinaOAuth *oauth=[SinaOAuth oauth];
    [oauth loginWith:kAppKey];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}
#pragma mark - 处理微博客户端程序通过URL启动第三方应用时传递的数据
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到客户端request：%@",request);
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSString *accessToken=[(WBAuthorizeResponse *)response accessToken];
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:kAccessToken];
    SinaOAuth *oauth=[SinaOAuth oauth];
    oauth.token=accessToken;
    NSLog(@"收到客户端response状态:%d------token:%@",response.statusCode,accessToken);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
