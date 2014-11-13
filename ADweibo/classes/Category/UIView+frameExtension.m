//
//  UIView+frameExtension.m
//  网络
//
//  Created by fad on 14-10-28.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "UIView+frameExtension.h"

@implementation UIView (frameExtension)

- (void)setX:(CGFloat)X{
    CGRect frame=self.frame;
    frame.origin.x=X;
    self.frame=frame;
}
- (CGFloat)X{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)Y{
    CGRect frame=self.frame;
    frame.origin.y=Y;
    self.frame=frame;
}
- (CGFloat)Y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}

@end
