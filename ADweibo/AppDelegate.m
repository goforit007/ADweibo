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
#import "OAuthViewControllViewController.h"
#import "SDWebImageManager.h"

@implementation AppDelegate

#warning revealapp在 TARGETS --> Settings --> Other Linker Flags -->添加命令 -ObjC

- (ADTabBarController *)tabBarController{
    if (_tabBarController==nil) {
        //初始化主页面
        self.tabBarController=[[ADTabBarController alloc] init];
    }
    return _tabBarController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //取消隐藏状态栏
    application.statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //欢迎页面显示判断 如果当前版本号和userdefault版本号一样加载主页面，否则加载欢迎界面
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *lastVersion=[defaults stringForKey:@"codeVersion"];
    NSString *nowVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if([lastVersion isEqualToString:nowVersion]){
        //判断登陆状态,没有登陆的话进行登录
        [self oauth];
    }else{
        WelcomeViewController *welcomeCtrl=[[WelcomeViewController alloc]init];
        self.window.rootViewController=welcomeCtrl;
        welcomeCtrl.startBlock=^{
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
    //如果储存的有token直接加载tabBarController
    if(oauth.token){
        self.window.rootViewController=self.tabBarController;
        return;
    }
    //没有储存的token进入授权控制器，然后等拿到Response再加载tabBarController
    OAuthViewControllViewController *oauthCtrl=[[OAuthViewControllViewController alloc]init];
    self.window.rootViewController=oauthCtrl;
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
    NSString *Token=[(WBAuthorizeResponse *)response accessToken];
    NSString *userID=[(WBAuthorizeResponse *)response userID];
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserID];
    [[NSUserDefaults standardUserDefaults] setObject:Token forKey:kAccessToken];
    NSLog(@"收到客户端response------token:%@",Token);
    //收到token再把tabBarController设置进去
    self.window.rootViewController=self.tabBarController;
}
//内存警告的时候清除sdwebimage的内存缓存（貌似不写内存警告时间他自己也会清除）
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //停止下载
    [[SDWebImageManager sharedManager] cancelAll];
    //清除内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
