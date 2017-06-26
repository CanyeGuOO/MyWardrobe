//
//  MWClothesDisplayViewController.h
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//  服装展示控制器

#import "MWBasicViewController.h"
#import "CaseView.h"

@interface MWClothesDisplayViewController : MWBasicViewController

@property (nonatomic, strong) NSMutableArray *caseAry;
@property (nonatomic, copy) NSString *order;

@end


@interface MWWardrobeButton : UIButton

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@interface MWDraverButton : UIButton

// 标记该按钮有没有刷新过collectionView
@property (nonatomic, assign, getter=isReloadata) BOOL reloadData;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
