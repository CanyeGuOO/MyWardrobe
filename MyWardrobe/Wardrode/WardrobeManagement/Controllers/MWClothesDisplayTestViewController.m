//
//  MWClothesDisplayTestViewController.m
//  MyWardrobe
//
//  Created by Libo on 17/6/1.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWClothesDisplayTestViewController.h"
#import "MWMacro.h"
#import "CaseView.h"
#import "MWClothesDisplayCell.h"
#import "MWClothesDispalySqlite.h"
#import "MWSearchViewController.h"
#import "MWStyleView.h"

#define kChangelessTag 2017
#define kInset 10
#define kCollectionViewRatio 0.59
#define kBottomButtonH 55

typedef NS_ENUM(NSInteger,CollectionViewState) {
    CollectionViewStateHide,  // 隐藏
    CollectionViewStateShow   // 显示
};

typedef NS_ENUM(NSInteger,CollectionViewFrom) {
    CollectionViewFromRight,    // 右边
    CollectionViewFromBottom   // 底部
};

@interface MWClothesDisplayTestViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UICollectionView *collectionView;

// 长按cell上的图片时的开始点
@property (nonatomic, assign) CGPoint beginPoint;
// 是否单击过
@property (nonatomic) BOOL didTap;
// collectionView的状态，显示和隐藏
@property (nonatomic, assign) CollectionViewState collectionViewState;
// collectionView的来源,左边和底部
@property (nonatomic, assign) CollectionViewFrom collectionViewFrom;

@property (nonatomic, strong) MWWardrobeButton1 *selectedLeftButton;

// 底部的2个抽屉按钮
@property (nonatomic, strong) MWWardrobeButton1 *drawerBtn1;
@property (nonatomic, strong) MWWardrobeButton1 *drawerBtn2;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) MWWardrobeButton1 *clothButton;

@property (nonatomic, strong) MWWardrobeButton1 *currentButton;


////////////////////////////////////////////////////////////
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSMutableArray *imgAry;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, strong) CaseView *currentCaseView;
@property (nonatomic, strong) CaseView *tapCaseView;
@property (nonatomic, strong) UIView *leftButtonContainerView;
@property (nonatomic, strong) MWStyleView *styleView;


@end

// 这个标记是为了判断完左边button与移动的图片有重叠之后，就结束判断。否则平移的过程中会不断的判断，图片会一闪一闪
static BOOL flag = 0;

@implementation MWClothesDisplayTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MWColorRGBA(53, 53, 53, 1);
    self.imgAry = [@[] mutableCopy];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.leftButtonContainerView];
    [self.view addSubview:self.bgScrollView];
    [self.view addSubview:self.collectionView];
    [self.view bringSubviewToFront:self.collectionView];


    // 添加一个向上的轻扫手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe];

    MWSearchViewController *searchVc = [[MWSearchViewController alloc] init];
//    WEAKSELF;
    searchVc.searchBlock = ^() {
//        MWWardrobeButton1 *btn = weakSelf.leftButtonContainerView.subviews[ (arc4random() % 5)];
//        btn.layer.borderWidth = 5;
//        btn.layer.borderColor = [UIColor redColor].CGColor;
//        for (MWWardrobeButton1 *otherButton in weakSelf.leftButtonContainerView.subviews) {
//            if (otherButton != btn) {
//                otherButton.layer.borderWidth = 0;
//            }
//        }
    };
    [self addChildViewController:searchVc];
    [self.view addSubview:searchVc.view];
    searchVc.view.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH);

    
}
#pragma mark -- UICollectViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgAry.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MWClothesDisplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MWClothesDisplayCell class]) forIndexPath:indexPath];

    cell.indexPath = indexPath;

    if (indexPath.row > 0) {
        cell.image = self.imgAry[indexPath.row-1];
    }

    WEAKSELF;
    // 实现长按手势block
    cell.longPressGestureBlock = ^(UILongPressGestureRecognizer *longPress) {
        [weakSelf longPressGestureAction:longPress];
    };
    // 单击图片放大全屏
//    cell.tapGestureBlock = ^(UITapGestureRecognizer *tap) {
//        [weakSelf tapGestureAction:tap];
//    };
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenW/3*2-2*kInset, kScreenW/3*2-2*kInset);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kInset, kInset, kInset, kInset);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self selectPhoto];
    }
}

#pragma mark - 长按手势触发的方法

- (void)longPressGestureAction:(UILongPressGestureRecognizer *)longPress {
    
    // 开始状态
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        self.collectionView.clipsToBounds = NO;
        
        // 获取当前触摸点所在的cell
        MWClothesDisplayCell *cell = (MWClothesDisplayCell *)longPress.view.superview.superview;
        // 将当前cell置为所有cell的最顶层，目的是为了平移cell上的图片时不会被其余cell盖住
        [self.collectionView bringSubviewToFront:cell];

        // 获取开始触摸的点
        self.beginPoint = [longPress locationInView:longPress.view];
        
    }
    // 移动过程中
    else if (longPress.state == UIGestureRecognizerStateChanged) {
        
        // 当前点
        CGPoint currentPoint = [longPress locationInView:longPress.view];
        
        // x偏移量
        CGFloat distanceX = currentPoint.x-self.beginPoint.x;
        // y偏移量
        CGFloat distanceY = currentPoint.y-self.beginPoint.y;
        
        // 让图片跟随触摸点移动
        CGPoint movePoint = longPress.view.center;
        movePoint.x += distanceX;
        movePoint.y += distanceY;
        longPress.view.center = movePoint;

        // 缩放图片
//        [self scaleImageView:longPress];

    }
    // 平移结束
    else {
        
        flag = 0.0f;
        
        if (![self pointInButton:longPress]) {
            longPress.view.mw_origin = CGPointZero;
        } else {
            NSString *nameTable = [NSString stringWithFormat:@"%@%ld", self.myWardrobeName, (long)self.currentCaseView.tag];
            if (![nameTable isEqualToString:self.tableName]) {
                [MWClothesDispalySqlite saveImage:((UIImageView *)longPress.view).image toTable:nameTable];
            } else {
                longPress.view.transform = CGAffineTransformMakeScale(1, 1);
                longPress.view.mw_origin = CGPointZero;
                
                return;
            }
            NSLog(@"666666666");
            // 删除动画
            [UIView animateWithDuration:0.5 animations:^{
                longPress.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                MWClothesDisplayCell *cell = (MWClothesDisplayCell *)longPress.view.superview.superview;
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
                // 从数据库删除数据
                [MWClothesDispalySqlite deleteImage:self.imgAry[indexPath.row-1] fromTable:self.tableName];
                // 从数组中删除数据
                [self.imgAry removeObjectAtIndex:indexPath.row-1];
                
                // 1.删除cell，这种删除方式和reloadData的区别是，此方式有动画效果，而且，indexPath必须存在，否则会崩溃.
                // 2.删除并刷新cell时，并不会从缓存池里删除cell，只是从collectionView表格中删除。因此，被删除的这个cell仍然会被后面的cell复用。而上面已经把longPress.view缩放到0.01了，所以当后面的cell复用这个被删除的cell时，那个cell的longPress.view的transform也是0.01，几乎看不见，所以会导致cell空白现象.所以每次刷新时都要将cell的imageview的transform复原
                if (indexPath.row) {
                    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                    [self delchangeTheResponseWindowDisplayImages:self.tapCaseView];
                    [self changeTheResponseWindowDisplayImages:self.currentCaseView];
                }
            }];
        }
    }
}

// 缩放移动的图片
- (void)scaleImageView:(UILongPressGestureRecognizer *)longPress {
    
    BOOL isIn = [self pointInButton:longPress];
    
    if (isIn && flag == 0) {
        flag = 1;
        [UIView animateWithDuration:0.8 animations:^{
            // 如果中心点包含在button内,让移动的图片开始按照button的size进行缩放
            longPress.view.transform = CGAffineTransformMakeScale(0.4, 0.4);
        }];
    }
    else if (![self isAccross:longPress]) {
        [UIView animateWithDuration:0.8 animations:^{
            // 恢复原图比例
            longPress.view.transform = CGAffineTransformMakeScale(1, 1);
        }];
        flag = 0;
    }
}

// 移动的图片中心点是否在某个button上
- (BOOL)pointInButton:(UILongPressGestureRecognizer *)longPress {

    for (CaseView *caseView in self.caseAry) {
        // 转换坐标系
        CGPoint clotheImageViewCenterPoint = [longPress.view.superview convertPoint:longPress.view.center toView:caseView];
        CGPoint aPoint = [longPress.view.superview convertPoint:longPress.view.center toView:self.collectionView];
        // 判断移动的图片中心点是否在button上
        if ([caseView pointInside:clotheImageViewCenterPoint withEvent:nil] && ![self.collectionView pointInside:aPoint withEvent:nil]) {
//            self.currentButton = button;
            self.currentCaseView = caseView;
            return YES;
        }
    }
    return NO;
}
// 判断是否超出父视图
- (BOOL)qwert:(UILongPressGestureRecognizer *)longPress {
    CGPoint aPoint = [longPress.view.superview convertPoint:longPress.view.center toView:self.collectionView];
    if (![self.collectionView pointInside:aPoint withEvent:nil]) {
        [UIView animateWithDuration:0.8 animations:^{
            // 如果中心点包含在button内,让移动的图片开始按照button的size进行缩放
            longPress.view.transform = CGAffineTransformMakeScale(0.4, 0.4);
        }];
        return YES;
    }else{
        [UIView animateWithDuration:0.8 animations:^{
            // 恢复原图比例
            longPress.view.transform = CGAffineTransformMakeScale(1, 1);
        }];
        return NO;
    };

}

//  是否重叠
- (BOOL)isAccross:(UILongPressGestureRecognizer *)longPress {
    CGRect clothImageViewRect = [longPress.view convertRect:longPress.view.bounds toView:nil];
    CGRect leftButtonContainerViewRect = [self.leftButtonContainerView convertRect:self.leftButtonContainerView.bounds toView:nil];
    if (CGRectIntersectsRect(clothImageViewRect, leftButtonContainerViewRect)) {
        return YES;
    } else {
        return NO;
    }

//    CGRect clothImageViewRect = [longPress.view convertRect:longPress.view.bounds toView:nil];
//    CGRect aRect = [self.collectionView convertRect:self.collectionView.bounds toView:nil];
//    if (!CGRectIntersectsRect(clothImageViewRect, aRect)) {
//        return YES;
//    } else {
//        return NO;
//    }
}

#pragma mark - 单击,放大图片

- (void)tapGestureAction:(UITapGestureRecognizer *)tap {
    _tap = tap;
    MWClothesDisplayCell *cell = (MWClothesDisplayCell *)tap.view.superview.superview;
    [self.collectionView bringSubviewToFront:cell];
    self.collectionView.clipsToBounds = NO;
    
    if (!self.didTap) {
//        [self hideOtherControls:tap];
        CGRect rectInView = [tap.view convertRect:tap.view.bounds toView:nil];
        [UIView animateWithDuration:0.5 animations:^{
            tap.view.transform = CGAffineTransformMakeScale(kScreenW/tap.view.mw_width, kScreenH/tap.view.mw_height);
            tap.view.mw_x = -rectInView.origin.x;
            tap.view.mw_y = -rectInView.origin.y;
        }];
    } else {
//        [self showOtherControls:tap];
        [UIView animateWithDuration:0.5 animations:^{
            
            tap.view.transform = CGAffineTransformMakeScale(1, 1);
            tap.view.mw_origin = CGPointZero;
        }];
    }
    self.didTap = !self.didTap;
}

// 放大时隐藏其余控件
- (void)hideOtherControls:(UITapGestureRecognizer *)tap {
    self.leftView.hidden = YES;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    for (MWClothesDisplayCell *cell in self.collectionView.visibleCells) {
        NSLog(@"---%@",self.collectionView.visibleCells);
        NSLog(@"tap==%@",tap.view.superview.superview);
        if (cell != tap.view.superview.superview) {
            cell.hidden = YES;
        } else {
            cell.hidden = NO;
        }
    }
}

// 恢复图片时显示其余控件
- (void)showOtherControls:(UITapGestureRecognizer *)tap {
    self.leftView.hidden = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    for (MWClothesDisplayCell *cell in self.collectionView.visibleCells) {
        cell.hidden = NO;
    }
}

#pragma mark -- 添加可点击小衣橱
- (void)configerCaseView {
    for (int i = 0; i < self.caseAry.count; i++) {
        CaseView *caseView = self.caseAry[i];
        caseView.image = [UIImage imageNamed:@"衣柜1"];
        [self.bgScrollView addSubview:caseView];
        WEAKSELF
        caseView.tapCaseViewBlock = ^(UITapGestureRecognizer *tapGesture) {
            // 点击切换衣橱服装展示
            [weakSelf clickOnTheSwitchWardrobeClothingDisplay:tapGesture];
        };
    }
}
#pragma mark --  点击切换衣橱服装展示
- (void)clickOnTheSwitchWardrobeClothingDisplay:(UITapGestureRecognizer *)tap{
    self.tapCaseView = (CaseView *)tap.view;
    NSString *tableName = [NSString stringWithFormat:@"%@%ld", self.myWardrobeName, (long)tap.view.tag];
    if (![tableName isEqualToString:self.tableName]) {
        [self openActionTest:tableName];
    }else{
        if (self.collectionViewState == CollectionViewStateHide) {
            [self openActionTest:tableName];
        }else{
            [self swipeActionTest];
        }
    }
}
- (void)rotation {
    // 开始动画
    [UIView beginAnimations:@"doflip" context:nil];
    // 设置时常
    [UIView setAnimationDuration:1];
    // 设置动画淡入淡出
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 设置代理
    [UIView setAnimationDelegate:self];
    // 设置翻转方向
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft forView:self.collectionView cache:YES];
    // 动画结束
    [UIView commitAnimations];
}
#pragma mark  - 拍照、相册

- (void)selectPhoto {
    UIAlertController *alertController = [[UIAlertController alloc]init];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES; // 可编辑
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [MBProgressHUD showError:@"没有摄像头"];
        }

    }];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
        } else {
            MWLog(@"不能打开相册");
        }

    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0) {
    UIImage *originalImage = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
    [self moveImageToSqlite:originalImage];
    [self changeTheResponseWindowDisplayImages:self.tapCaseView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 将此图片存入数据库
- (void)moveImageToSqlite:(UIImage *)originalImage{
    [MWClothesDispalySqlite saveImage:originalImage toTable:self.tableName];
    [self.imgAry insertObject:originalImage atIndex:0];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:1 inSection:0]]];
}
#pragma mark -- 改变响应,橱窗显示图片
/// 添加
- (void)changeTheResponseWindowDisplayImages:(CaseView *)tapCaseView{
    int i = tapCaseView.frame.size.height/15*1;
    if (tapCaseView.subAry.count < i) {
        int j = tapCaseView.subAry.count % (5);
        NSString *imgName = [NSString stringWithFormat:@"着色%d", j];
        CGSize aSize = tapCaseView.frame.size;
        UIImageView *aImg = [[UIImageView alloc] init];
        aImg.image = [UIImage imageNamed:imgName];
        aImg.frame = CGRectMake(5, aSize.height-15-tapCaseView.subAry.count*15, aSize.width-10, 15);
        [tapCaseView addSubview:aImg];
        [tapCaseView.subAry addObject:aImg];
    }
}
// 删除
- (void)delchangeTheResponseWindowDisplayImages:(CaseView *)tapCaseView{
    if (tapCaseView.subAry.count != 0) {
        UIImageView *aImg = [tapCaseView.subAry lastObject];
        [aImg removeFromSuperview];
        [tapCaseView.subAry removeLastObject];
    }
}

#pragma mark - 轻扫
// 关闭服装列表
- (void)swipeActionTest{
    if (self.collectionViewFrom == CollectionViewFromRight) {
//        [self.view insertSubview:self.collectionView belowSubview:self.bgScrollView];
        [UIView animateWithDuration:1 animations:^{
            self.collectionView.mw_x = kScreenW;
        }];
        self.collectionViewState = CollectionViewStateHide;
    }
}
// 打开服装列表
- (void)openActionTest:(NSString *)tableName{
    self.tableName = tableName;
    // 从数据库取出数据
    [self.imgAry removeAllObjects];
    self.imgAry = [MWClothesDispalySqlite queryImageFromTable:tableName].mutableCopy;
    self.collectionView.clipsToBounds = YES;
    [self.collectionView reloadData];
    //    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"我是%ld", (long)tap.view.tag]];
    if (self.collectionViewState == CollectionViewStateHide) {
        //        _collectionView.frame = CGRectMake(kScreenW*(1-kCollectionViewRatio)-(kScreenW*kCollectionViewRatio), 0, kScreenW*kCollectionViewRatio, kScreenH);

        [UIView animateWithDuration:1 animations:^{
            self.collectionView.mw_x = kScreenW/3-10;
        } completion:^(BOOL finished) {
            //            [self.view insertSubview:self.collectionView aboveSubview:self.bgScrollView];
        }];
        self.collectionViewState = CollectionViewStateShow;
        self.collectionViewFrom = CollectionViewFromRight;
    } else {
        if (self.collectionViewState == CollectionViewStateShow) {
            [self rotation];
        }
    }

}
// 显示搜索页面
- (void)swipeView:(UISwipeGestureRecognizer *)swipe {
    MWSearchViewController *searchVc = self.childViewControllers[0];
    [UIView animateWithDuration:0.5 animations:^{
        searchVc.view.mw_y = 0;
    }];
}






#pragma mark -- BtnAction
/// 返回上一页
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
///// 暂无
- (void)buttonAction:(UIButton *)sender {
    [UIView animateWithDuration:1 animations:^{
        self.collectionView.mw_x = (kScreenW-40)/3;
        self.collectionView.mw_width = CGRectGetWidth(self.backgroundView.frame)-(kScreenW-40)/3;
    } completion:^(BOOL finished) {
        [self.backgroundView bringSubviewToFront:self.collectionView];
    }];
}
#pragma mark -- 添家小衣橱
- (void)setCaseAry:(NSMutableArray *)caseAry{
    if (_caseAry != caseAry) {
        _caseAry = caseAry;
    }
    if (_caseAry.count != 0) {
        // 改变滑动衣橱contentSize
        self.bgScrollView.contentSize = CGSizeMake(self.aLong+10, self.bgScrollView.frame.size.height);
        self.backgroundView.frame = CGRectMake(0, 0, self.bgScrollView.contentSize.width, self.bgScrollView.contentSize.height);
        // 添家小衣橱
        [self configerCaseView];
        [self creatTableFMDB];
    }
}
#pragma mark -- 创建表格
- (void)creatTableFMDB{
    for (int i = 0; i < self.caseAry.count; i++) {
        CaseView *caseV = self.caseAry[i];
        NSString *tableName = [NSString stringWithFormat:@"%@%ld", self.myWardrobeName, (long)caseV.tag];
        [MWClothesDispalySqlite creatTableName:tableName];
        [MWClothesDispalySqlite saveImage:[UIImage imageNamed:@"1.jpg"] toTable:tableName];
    }
}
#pragma mark -- 懒加载
- (UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenW, kScreenH-40)];
        _bgScrollView.contentSize = _bgScrollView.bounds.size;
        _bgScrollView.backgroundColor = [UIColor clearColor];
        [_bgScrollView addSubview:self.backgroundView];
    }
    return _bgScrollView;
}
-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = MWColorRGBA(239, 234, 230,1);
    }
    return _backgroundView;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(10, 5, 40, 30);
        _backBtn.backgroundColor = [UIColor brownColor];
        [_backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.frame = CGRectMake(kScreenW, 40, kScreenW/3*2+10, kScreenH-40);
        _collectionView.backgroundColor = MWColorRGBA(239, 234, 230,1);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MWClothesDisplayCell class] forCellWithReuseIdentifier:NSStringFromClass([MWClothesDisplayCell class])];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeActionTest)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_collectionView addGestureRecognizer:swipe];
        
    }
    return _collectionView;
}
-(UIView *)leftButtonContainerView{
    if (!_leftButtonContainerView) {
        _leftButtonContainerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 40, kScreenW/3, kScreenH-40))];
    }
    return _leftButtonContainerView;
}
-(MWStyleView *)styleView{
    if (!_styleView) {
        _styleView = [[MWStyleView alloc] initWithFrame:self.view.bounds];
        _styleView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.3];
        _styleView.hidden = YES;
        _styleView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }
    return _styleView;
}

@end

@implementation MWWardrobeButton1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

@end


@implementation MWDraverButton1

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

@end
