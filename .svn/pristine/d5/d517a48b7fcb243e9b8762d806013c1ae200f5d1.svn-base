//
//  UIView+Frame.m
//  WeChat
//
//  Created by leshengping on 16/9/29.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import "UIView+Frame.h"
#import <objc/runtime.h>

@implementation UIView (Frame)

- (void)setMw_x:(CGFloat)mw_x {
    CGRect frame = self.frame;
    frame.origin.x = mw_x;
    self.frame = frame;
}

- (void)setMw_y:(CGFloat)mw_y
{
    CGRect frame = self.frame;
    frame.origin.y = mw_y;
    self.frame = frame;
}

- (CGFloat)mw_x
{
    return self.frame.origin.x;
}

- (CGFloat)mw_y
{
    return self.frame.origin.y;
}

- (void)setMw_centerX:(CGFloat)mw_centerX
{
    CGPoint center = self.center;
    center.x = mw_centerX;
    self.center = center;
}

- (CGFloat)mw_centerX
{
    return self.center.x;
}

- (void)setMw_centerY:(CGFloat)mw_centerY
{
    CGPoint center = self.center;
    center.y = mw_centerY;
    self.center = center;
}

- (CGFloat)mw_centerY
{
    return self.center.y;
}

- (void)setMw_width:(CGFloat)mw_width
{
    CGRect frame = self.frame;
    frame.size.width = mw_width;
    self.frame = frame;
}

- (void)setMw_height:(CGFloat)mw_height
{
    CGRect frame = self.frame;
    frame.size.height = mw_height;
    self.frame = frame;
}

- (CGFloat)mw_height
{
    return self.frame.size.height;
}

- (CGFloat)mw_width
{
    return self.frame.size.width;
}

- (void)setMw_size:(CGSize)mw_size
{
    CGRect frame = self.frame;
    frame.size = mw_size;
    self.frame = frame;
}

- (CGSize)mw_size
{
    return self.frame.size;
}

- (void)setMw_origin:(CGPoint)mw_origin
{
    CGRect frame = self.frame;
    frame.origin = mw_origin;
    self.frame = frame;
}

- (CGPoint)mw_origin
{
    return self.frame.origin;
}


@end
