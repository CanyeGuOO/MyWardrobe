//
//  MWClothesDisplayCell.h
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//  服装展示右边的collectionViewCell

#import <UIKit/UIKit.h>

typedef void(^LongPressGestureBlock)(UILongPressGestureRecognizer *longPress);
typedef void (^TapGestureBlock)(UITapGestureRecognizer *tap);

@interface MWClothesDisplayCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

// 长按手势block回调
@property (nonatomic, copy) LongPressGestureBlock longPressGestureBlock;
// 单机手势block回调
@property (nonatomic, copy) TapGestureBlock tapGestureBlock;


@property (nonatomic, strong) UIImage *image;

@end
