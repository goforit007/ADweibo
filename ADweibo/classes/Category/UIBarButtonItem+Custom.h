//
//  UIBarButtonItem+Custom.h
//  ADweibo
//
//  Created by fad on 14-11-8.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+(UIBarButtonItem *)initWithNormalBackgroundImage:(NSString *)NormalName HighlightedBackgroundImage:(NSString *)HighlightedName Target:(id)targat action:(SEL)action;

@end
