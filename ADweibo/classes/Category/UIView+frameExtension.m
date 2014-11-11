//
//  UIView+frameExtension.m
//  网络
//
//  Created by fad on 14-10-28.
//  Copyright (c) 2014年 fad. All rights reserved.
//

#import "UIView+frameExtension.h"

@implementation UIView (frameExtension)

- (void)setX:(int)X{
    CGRect frame=self.frame;
    frame.origin.x=X;
    self.frame=frame;
}
- (int)X{
    return self.frame.origin.x;
}

- (void)setY:(int)Y{
    CGRect frame=self.frame;
    frame.origin.y=Y;
    self.frame=frame;
}
- (int)Y{
    return self.frame.origin.y;
}

- (void)setWidth:(int)width{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
- (int)width{
    return self.frame.size.width;
}

- (void)setHeight:(int)height{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
- (int)height{
    return self.frame.size.height;
}

@end
