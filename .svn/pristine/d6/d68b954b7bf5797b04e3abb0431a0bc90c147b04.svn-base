//
//  DrawerViewController.m
//  MyWardrobe
//
//  Created by develop1 on 2017/5/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "DrawerViewController.h"
#import "ZDStickerView.h"
#import "MWMacro.h"

@interface DrawerViewController ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;

    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.finishBtn];

    CGRect rect = CGRectMake(0, kScreenH-60, 60, 60);
    ZDStickerView *firstSticker = [self addFirstStickerView:rect];
    [self.view addSubview:firstSticker];


}
#pragma mark -- 应用
// 初始化
- (ZDStickerView *)addFirstStickerView:(CGRect)rect{
    ZDStickerView *stickerView = [[ZDStickerView alloc] initWithFrame:rect];
    UIImage *image = [UIImage imageNamed:@"衣服"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    stickerView.contentView = imageView;
    stickerView.preventsPositionOutsideSuperview = NO;
    [stickerView showEditingHandles];
    return stickerView;
}

#pragma mark -- 按钮触发方法
- (void)backBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)finishBtnAction:(UIButton *)sender{
    CGRect rect = CGRectMake(kScreenW/2-30, kScreenH/2-30, 60, 60);
    ZDStickerView *firstSticker = [self addFirstStickerView:rect];
    [self.view addSubview:firstSticker];
}
#pragma  mark -- 懒加载
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(10, 10, 40, 40);
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
}
-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _finishBtn.frame = CGRectMake(kScreenW -50, 10, 40, 40);
        [_finishBtn setImage:[UIImage imageNamed:@"完成"] forState:(UIControlStateNormal)];
        [_finishBtn addTarget:self action:@selector(finishBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _finishBtn;
}











#pragma mark --
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
