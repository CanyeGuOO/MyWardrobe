//
//  MWHomeViewController.m
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWHomeViewController.h"
#import "MWMacro.h"
#import "MWClothesDisplayViewController.h"
#import "DrawerViewController.h"
#import "WardrobeViewController.h"
#define kImageCount 4

@interface MWHomeViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation MWHomeViewController

    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.添加scrollView
    [self setupScrollView];
    
    // 2.设置pageControl
    [self setupPageControl];
}

    
/**
 *  添加scrollView
 */
- (void)setupScrollView {
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, kScreenW, kScreenH-49);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.mw_width;
    CGFloat imageH = scrollView.mw_height;
    for (int i = 0; i < kImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+100;
        imageView.backgroundColor = MWRandomColor;
        
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.mw_y = 0;
        imageView.mw_width = imageW;
        imageView.mw_height = imageH;
        imageView.mw_x = i * imageW;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];

    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(kImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = MWColorRGBA(246, 246, 246, 1);
}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kImageCount;
    pageControl.mw_centerX = self.view.mw_width * 0.5;
    pageControl.mw_centerY = self.view.mw_height - 79;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = MWColorRGBA(253, 98, 42, 1); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = MWColorRGBA(189, 189, 189, 1); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 101) {
        WardrobeViewController *drawer = [[WardrobeViewController alloc] init];
        [self.navigationController pushViewController:drawer animated:YES];

    }else{
        MWClothesDisplayViewController *clothesDisplayVc = [[MWClothesDisplayViewController alloc] init];
        [self.navigationController pushViewController:clothesDisplayVc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.mw_width;
    // 四舍五入
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end



