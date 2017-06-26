//
//  StickerView.m
//  MyWardrobe
//
//  Created by develop1 on 2017/5/23.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "StickerView.h"

@interface StickerView ()

@property (nonatomic, strong) UIView *stickerV;

@end

@implementation StickerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)]];
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGestureAction:)];
        longGesture.minimumPressDuration = 2;
        [self addGestureRecognizer:longGesture];
    }
    return self;
}
#pragma mark -- 懒加载

-(UIView *)stickerV{
    if (!_stickerV) {
        _stickerV = [[UIView alloc] init];
    }
    return _stickerV;
}


#pragma maRK -- GestureAction
- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    if (self.tapHcaseBlock) {
        self.tapHcaseBlock(tap);
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan{
    if (self.panHcaseBlock) {
        self.panHcaseBlock(pan);
    }
}

- (void)longGestureAction:(UILongPressGestureRecognizer *)longGesture{
    if (self.longCaseBlock) {
        self.longCaseBlock(longGesture);
    }
}


/*
-(void)drawRect:(CGRect)rect{
    // 获取处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条的样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 10.0);
    //设置颜色
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    // 计算矩形
    
    if (self.bounds.size.width > self.bounds.size.height) {
        CGRect rectangle = CGRectMake(0, 10, self.bounds.size.width, 10);
        CGContextFillRect(UIGraphicsGetCurrentContext(), rectangle);
    }else{
        CGRect rectangle = CGRectMake(10, 0, 10, self.bounds.size.height);
        CGContextFillRect(UIGraphicsGetCurrentContext(), rectangle);
    }
    //连接上面定义的坐标点
    CGContextStrokePath(context);

}

*/





@end
