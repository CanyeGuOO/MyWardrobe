//
//  MWClothesDisplayTestViewController.h
//  MyWardrobe
//
//  Created by Libo on 17/6/1.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWBasicViewController.h"

@interface MWClothesDisplayTestViewController : MWBasicViewController

@property (nonatomic, strong) NSMutableArray *caseAry;
@property (nonatomic, assign) NSInteger aLong;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *myWardrobeName;

@end

@interface MWWardrobeButton1 : UIButton

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@interface MWDraverButton1 : UIButton

// 标记该按钮有没有刷新过collectionView
@property (nonatomic, assign, getter=isReloadata) BOOL reloadData;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
