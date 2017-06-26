//
//  MWNavigationController.m
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWNavigationController.h"

@interface MWNavigationController ()

@end

@implementation MWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        /* 当push的时候自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 必须super
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}



@end
