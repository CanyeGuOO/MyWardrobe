//
//  StickerView.h
//  MyWardrobe
//
//  Created by develop1 on 2017/5/23.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
// 横竖隔板

#import <UIKit/UIKit.h>

typedef void(^TapHcaseBlock)(UITapGestureRecognizer *tapGesture);
typedef void(^PanHcaseBlock)(UIPanGestureRecognizer *panGesture);
typedef void(^LongCaseBlock)(UILongPressGestureRecognizer *longGesture);

@interface StickerView : UIView

@property (nonatomic, copy) TapHcaseBlock tapHcaseBlock;
@property (nonatomic, copy) PanHcaseBlock panHcaseBlock;
@property (nonatomic, copy) LongCaseBlock longCaseBlock;
@property (nonatomic, assign) NSInteger aTag;
@property (nonatomic, strong) NSNumber *direction;
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, strong) UIButton *delBtn;

@end
