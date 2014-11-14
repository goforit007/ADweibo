//
//  SinaOAuth.h
//  ADweibo
//
//  Created by fad on 14-11-9.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinaOAuth : NSObject

@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *userID;

+(id)oauth;
-(void)loginWith:(NSString *)appKey;

@end
