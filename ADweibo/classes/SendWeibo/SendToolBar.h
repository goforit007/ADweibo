//
//  SendToolBar.h
//  ADweibo
//
//  Created by fad on 14-11-15.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    toolBarButtonTypeCamera,
    toolBarButtonTypePicture,
    toolBarButtonTypeMention,
    toolBarButtonTypeTrend,
    toolBarButtonTypeEmotion,
}toolBarButtonType;

@interface SendToolBar : UIView

@property(nonatomic,copy)void (^toolBarButtonClickBlock)(toolBarButtonType);

@end
