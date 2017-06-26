//
//  MWStyleView.h
//  MyWardrobe
//
//  Created by develop1 on 2017/6/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MWStyleSelected)(NSString *style1, NSString *style2, NSString *style3, NSString *style4);

@interface MWStyleView : UIView

@property (nonatomic, copy) MWStyleSelected styleSelected;

@property (nonatomic, copy) NSString *style1;
@property (nonatomic, copy) NSString *style2;
@property (nonatomic, copy) NSString *style3;
@property (nonatomic, copy) NSString *style4;


@end
