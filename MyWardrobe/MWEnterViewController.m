//
//  MWEnterViewController.m
//  MyWardrobe
//
//  Created by Libo on 17/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWEnterViewController.h"
#import "MWMacro.h"
#import "MWTabBarController.h"

#define kImageCount 3

@interface MWEnterViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation MWEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.mw_width;
    CGFloat imageH = scrollView.mw_height;
    for (int i = 0; i < kImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"大衣柜"];
   
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.mw_y = 0;
        imageView.mw_width = imageW;
        imageView.mw_height = imageH;
        imageView.mw_x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == kImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(kImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = MWColorRGBA(246, 246, 246, 1);
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];

}

/**
 *  添加进入按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *enterButton = [[UIButton alloc] init];
    [imageView addSubview:enterButton];
    enterButton.backgroundColor = [UIColor greenColor];
    
    // 2.设置frame
    enterButton.mw_size = CGSizeMake(120, 30);
    enterButton.mw_centerX = self.view.mw_width * 0.5;
    enterButton.mw_centerY = self.view.mw_height * 0.8;
    
    // 3.设置文字
    [enterButton setTitle:@"点击进入>>>" forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
}

- (void)enter {
    [[NSUserDefaults standardUserDefaults] setBool:@(YES) forKey:@"isFirst"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    MWTabBarController *tabBarVc = [[MWTabBarController alloc] init];
    // 切换根控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabBarVc;
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
    pageControl.mw_centerY = self.view.mw_height - 30;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = MWColorRGBA(253, 98, 42, 1); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = MWColorRGBA(189, 189, 189, 1); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
