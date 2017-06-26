//
//  MWSearchTypeView.m
//  MyWardrobe
//
//  Created by Libo on 17/5/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWSearchTypeView.h"
#import "MWMacro.h"

@interface MWSearchTypeView()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation MWSearchTypeView

+ (MWSearchTypeView *)typeView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    UIButton *lastBtn;
    for (int i = 0; i < self.dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + i * (40 + 10), 10, 40, 30);
        [button setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickedTypeView:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.scrollView addSubview:button];
        lastBtn = button;
    }

    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame)+10, 0);
}

- (void)awakeFromNib {
    [super awakeFromNib];

 
}
#pragma mark -- 选择
- (void)clickedTypeView:(UIButton *)sender {

    sender.backgroundColor = [UIColor brownColor];
    self.selectedButton.backgroundColor = [UIColor whiteColor];
    self.selectedButton = sender;

    if (self.styleStyleStyleBlock) {
        self.styleStyleStyleBlock(sender.titleLabel.text, self.style);
    }
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

@end
