//
//  MWSearchViewController.m
//  MyWardrobe
//
//  Created by Libo on 17/5/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWSearchViewController.h"
#import "MWMacro.h"
#import "MWSearchTypeView.h"
#import "MWSearchResultCell.h"

@interface MWSearchViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) MWSearchTypeView *typeView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    
    self.dataArray = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"],[UIImage imageNamed:@"6.jpg"]];

    
    [self.collectionView registerClass:[MWSearchResultCell class] forCellWithReuseIdentifier:NSStringFromClass([MWSearchResultCell class])];

    NSArray *titleArray = @[@"材质:",@"色系:",@"风格:",@"分类:"];
    NSArray *buttonArray = @[@[@"雪纺",@"夏布",@"绢丝",@"天丝"],@[@"暖色",@"冷色",@"同色"],@[@"甜美",@"田园",@"少女",@"简约",@"复古",@"前卫"],@[@"裤子",@"外裤",@"T恤",@"内衣",@"裙子"]];
    
    for (int i = 0; i < titleArray.count; i++) {
        MWSearchTypeView *typeView = [MWSearchTypeView typeView];
        typeView.frame = CGRectMake(0, 50 * i + 44, kScreenW, 50);
        typeView.title = titleArray[i];
        typeView.dataArray = buttonArray[i];
        [self.view addSubview:typeView];
    }
    
    // 添加一个向上的轻扫手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MWSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MWSearchResultCell class]) forIndexPath:indexPath];
    
    cell.image = self.dataArray[indexPath.row];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenW-20-10)/2, (kScreenW-20-10)/2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchBlock) {
        self.searchBlock();
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.mw_y = kScreenH;
    }];
}

- (void)swipeView:(UISwipeGestureRecognizer *)swipe {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.mw_y = kScreenH;
    }];
}

- (void)typeViewButtonClicked:(UIButton *)sender {
    if (self.searchBlock) {
        self.searchBlock(sender);
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.view.mw_y = kScreenH;
    }];
}



- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.frame = CGRectMake(0, 250, kScreenW, kScreenH-250);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
 
    }
    return _collectionView;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
