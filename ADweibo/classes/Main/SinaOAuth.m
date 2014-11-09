//
//  SinaOAuth.m
//  ADweibo
//
//  Created by fad on 14-11-9.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "SinaOAuth.h"
#import "WeiboSDK.h"

@interface SinaOAuth()

@end

@implementation SinaOAuth
static SinaOAuth *oauth=nil;
//提单利方法
+(id)oauth{
    if(oauth==nil){
        oauth=[[self alloc]init];
    }
    return oauth;
}
//alloc拦截
+(id)allocWithZone:(NSZone *)zone{
    if(oauth==nil){
        oauth=[super allocWithZone:zone];
    }
    return oauth;
}
//copy拦截
- (id)copy{
    return oauth;
}
- (id)init{
    self=[super init];
    if (self) {
    }
    return self;
}

-(void)loginWith:(NSString *)appKey{
    [WeiboSDK enableDebugMode:YES];
    self.token=[[NSUserDefaults standardUserDefaults] stringForKey:kAccessToken];
    if(self.token){
        return;
    }else{
        [WeiboSDK registerApp:kAppKey];
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI=kRedirectURI;
        [WeiboSDK sendRequest:request];
    }

}
@end





