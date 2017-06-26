//
//  MWStyleView.m
//  MyWardrobe
//
//  Created by develop1 on 2017/6/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWStyleView.h"
#import "MWSearchTypeView.h"
#import "MWMacro.h"

@interface MWStyleView ()
@property (nonatomic, strong) UILabel *aTitleLable;
@property (nonatomic, strong) UIButton *aFinishBtn;

@end


@implementation MWStyleView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.aTitleLable];
        [self addSubview:self.aFinishBtn];
        [self addUI];
    }
    return self;
}
#pragma mark -- 懒加载
-(UILabel *)aTitleLable{
    if (!_aTitleLable) {
        _aTitleLable = [[UILabel alloc] initWithFrame:(CGRectMake(20, 150, kScreenW-40, 30))];
        _aTitleLable.backgroundColor = [UIColor whiteColor];
        _aTitleLable.textColor = [UIColor blackColor];
        _aTitleLable.text = @"请选择此衣服的风格";
        _aTitleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _aTitleLable;
}
- (UIButton *)aFinishBtn{
    if (!_aFinishBtn) {
        _aFinishBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _aFinishBtn.frame = CGRectMake(kScreenW/2-30, kScreenH-100, 60, 30);
        _aFinishBtn.backgroundColor = [UIColor brownColor];
        [_aFinishBtn setTitle:@" 完   成 " forState:(UIControlStateNormal)];
        [_aFinishBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _aFinishBtn.layer.cornerRadius = 15;
        [_aFinishBtn addTarget:self action:@selector(aFinishBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _aFinishBtn;
}
#pragma mark -- 添加UI
- (void)addUI{
    NSArray *titleArray = @[@"材质:",@"色系:",@"风格:",@"分类:"];
    NSArray *buttonArray = @[@[@"雪纺",@"夏布",@"绢丝",@"天丝", @"其它"],@[@"暖色",@"冷色",@"同色", @"其它"],@[@"甜美",@"田园",@"少女",@"简约",@"复古",@"前卫", @"其它"],@[@"裤子",@"外裤",@"T恤",@"内衣",@"裙子", @"其它"]];

    for (int i = 0; i < titleArray.count; i++) {
        MWSearchTypeView *typeView = [MWSearchTypeView typeView];
        typeView.style = [NSString stringWithFormat:@"style%d",i+1];
        WEAKSELF
        typeView.styleStyleStyleBlock = ^(NSString *selStyle, NSString *style) {
            [weakSelf selStyleWithBlock:selStyle style:style];
        };
        typeView.frame = CGRectMake(0, 50 * i + 200, kScreenW, 50);
        typeView.title = titleArray[i];
        typeView.dataArray = buttonArray[i];
        [self addSubview:typeView];
    }

}
#pragma mark -- 选择风格
- (void)selStyleWithBlock:(NSString *)selStyle style:(NSString *)style{

    if ([style isEqualToString:@"style1"]) {
        self.style1 = selStyle;
    }else if ([style isEqualToString:@"style2"]) {
        self.style2 = selStyle;
    }else if ([style isEqualToString:@"style3"]) {
        self.style3 = selStyle;
    }else if ([style isEqualToString:@"style4"]) {
        self.style4 = selStyle;
    }
}

#pragma mark -- aFinishBtnAction
- (void)aFinishBtnAction:(UIButton *)sender{
    self.style1 = self.style1 ? self.style1 : @"其它";
    self.style2 = self.style2 ? self.style2 : @"其它";
    self.style3 = self.style3 ? self.style3 : @"其它";
    self.style4 = self.style4 ? self.style4 : @"其它";
    if (self.styleSelected) {
        self.styleSelected(self.style1, self.style2, self.style3, self.style4);
    }
    [self removeFromSuperview];
}






@end
