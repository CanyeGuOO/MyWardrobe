//
//  MWClothesDisplayCell.m
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWClothesDisplayCell.h"

#import "MWMacro.h"

@interface MWClothesDisplayCell() <UIGestureRecognizerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *clothesImageView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imgView;

@end

@implementation MWClothesDisplayCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.clothesImageView];
        
        // 添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 0.5;
        self.longPress = longPress;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBigAction:)];
        self.tap = tap;
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;

     // 手势和控件不一样，控件如果添加多次到父视图，父视图只会添加一次，而手势添加几次，父视图就接受几次
    if (indexPath.row == 0) {
        self.clothesImageView.image = [UIImage imageNamed:@"添加"];
        [self.clothesImageView removeGestureRecognizer:self.longPress];
        [self.clothesImageView removeGestureRecognizer:self.tap];
    } else {

        [self.clothesImageView addGestureRecognizer:self.longPress];
        [self.clothesImageView addGestureRecognizer:self.tap];
        
    }
}

- (void)setImage:(UIImage *)image {
    _image = image;

    self.clothesImageView.image = image;
    self.clothesImageView.transform = CGAffineTransformMakeScale(1, 1);
    self.clothesImageView.mw_origin = CGPointZero;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    if (self.longPressGestureBlock) {
        self.longPressGestureBlock(longPress);
    }
}

- (void)tapBigAction:(UITapGestureRecognizer *)tap {
//    if (self.tapGestureBlock) {
//        self.tapGestureBlock(tap);
//    }

    //弹出来的视图
    [self creactSubView];
    //放大的动画
    [UIView animateWithDuration:1.0f
                          delay:-1
                        options:UIViewAnimationOptionShowHideTransitionViews//视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
                     animations:^{
                         _imgView.frame = _scrollView.frame;
                         _scrollView.backgroundColor = [UIColor whiteColor];
                         self.hidden = YES;
                     }
                     completion:nil];
}
- (void)creactSubView{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 5;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    // _scrollView.
    [self.window addSubview:_scrollView];
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _imgView = [[UIImageView alloc] initWithFrame:frame];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.image = self.image;
    _imgView.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallTap)];
    [_imgView addGestureRecognizer:tap];
    [_scrollView addSubview:_imgView];
}
- (void)smallTap{

    [UIView animateWithDuration:.5 animations:^{
        _scrollView.zoomScale = 1;
        _imgView.frame = [self convertRect:self.bounds toView:self.window];

    } completion:^(BOOL finished) {
        self.hidden = NO;
        [_imgView endEditing:YES];
        [_scrollView removeFromSuperview];
    }];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    [_imgView becomeFirstResponder];
    return _imgView;
}



#pragma mark --
- (UIImageView *)clothesImageView {
    
    if (!_clothesImageView) {
        _clothesImageView = [[UIImageView alloc] init];
        _clothesImageView.frame = self.bounds;
        _clothesImageView.contentMode = UIViewContentModeScaleAspectFit;
        _clothesImageView.userInteractionEnabled = YES;
        _clothesImageView.backgroundColor = [UIColor whiteColor];
    }
    return _clothesImageView;
}

// 画矩形
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    layer.lineWidth = 1;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor grayColor].CGColor;
    layer.opacity = 0.5;
    [self.layer insertSublayer:layer atIndex:0];
    
}

// 重写这个方法的作用是让self.clothesImageView放大后超出父控件依然能点击
/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.clothesImageView convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.clothesImageView.bounds, tempoint))
        {
//            view = self.clothesImageView;
        }
    }
    return view;
}
*/

@end


