//
//  MWSearchTypeView.h
//  MyWardrobe
//
//  Created by Libo on 17/5/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StyleStyleStyleBlock)(NSString *selStyle, NSString *style);

@interface MWSearchTypeView : UIView

+ (MWSearchTypeView *)typeView;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *style;
@property (nonatomic, copy) StyleStyleStyleBlock styleStyleStyleBlock;

@end
