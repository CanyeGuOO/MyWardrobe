//
//  BorderView.m
//  MyWardrobe
//
//  Created by develop1 on 2017/5/23.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "BorderView.h"
#import "SPGripViewBorderView.h"

@implementation BorderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        SPGripViewBorderView *spgView = [[SPGripViewBorderView alloc] initWithFrame:self.bounds];
        [self addSubview:spgView];
    }
    return self;
}

@end
