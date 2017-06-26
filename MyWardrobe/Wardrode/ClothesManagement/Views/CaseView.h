//
//  CaseView.h
//  MyWardrobe
//
//  Created by develop1 on 2017/5/23.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
// 小橱窗

#import <UIKit/UIKit.h>

typedef void(^TapCaseViewBlock)(UITapGestureRecognizer *tapGesture);

@interface CaseView : UIImageView

@property (nonatomic, copy) TapCaseViewBlock tapCaseViewBlock;
@property (nonatomic, strong) NSMutableArray *subAry;

@end
