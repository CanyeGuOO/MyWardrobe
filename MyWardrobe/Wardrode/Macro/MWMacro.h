//
//  MWMacro.h
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#ifndef MWMacro_h
#define MWMacro_h

#ifdef DEBUG //  处于开发阶段
#define MWLog(...) NSLog(__VA_ARGS__)
#else //处于发布阶段
#define MWLog(...)
#endif

// 屏幕尺寸
#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


// --------------------- 颜色专区 ----------------------
// RGB颜色
#define MWColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 随机色
#define MWRandomColor MWColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)


// -----------------------------------------------------

#define greaterThaniOS(n) ([[UIDevice currentDevice].systemVersion doubleValue] >= n)

#define WEAKSELF typeof(self) __weak weakSelf = self;

#import "MWHeaderFile.h"

#endif /* MWMacro_h */
