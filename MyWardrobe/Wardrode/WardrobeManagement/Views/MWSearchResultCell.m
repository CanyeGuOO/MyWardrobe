//
//  MWSearchResultCell.m
//  MyWardrobe
//
//  Created by Libo on 17/5/22.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWSearchResultCell.h"
#import "MWMacro.h"

@interface MWSearchResultCell()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation MWSearchResultCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

@end
