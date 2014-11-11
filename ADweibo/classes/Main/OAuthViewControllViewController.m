//
//  OAuthViewControllViewController.m
//  ADweibo
//
//  Created by fad on 14-11-9.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "OAuthViewControllViewController.h"
#import "SinaOAuth.h"
#import "WeiboSDK.h"

@interface OAuthViewControllViewController ()

@end

@implementation OAuthViewControllViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    SinaOAuth *oauth=[SinaOAuth oauth];
    [oauth loginWith:kAppKey];
}

@end
