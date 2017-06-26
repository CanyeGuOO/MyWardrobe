//
//  MWDrawerColorView.m
//  MyWardrobe
//
//  Created by develop1 on 2017/6/26.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "MWDrawerColorView.h"

@interface MWDrawerColorView ()

@property (nonatomic, strong) UIImageView *colorICon;
@property (nonatomic, strong) UIView *colorView;


@end



@implementation MWDrawerColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark -- 获取图片单个点的颜色

- (UIColor *)getPixelColorAtLocation:(CGPoint)point {

    UIColor *color = nil;
    CGImageRef inImage = self.image.CGImage;
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) {
        return nil;
    }

    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0}, {w,h}};

    CGContextDrawImage(cgctx, rect, inImage);

    unsigned char *data = CGBitmapContextGetData(cgctx);
    if (data != NULL) {
        @try {
            int offset = 4*((w*round(point.y)) + round(point.x));
            NSLog(@"offset: %d", offset);
            int alpha = data[offset];
            int red = data[offset + 1];
            int green = data[offset + 2];
            int blue = data[offset + 3];
            NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
            color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
        } @catch (NSException *exception) {
            NSLog(@"%@", [exception reason]);
        } @finally {
            NSLog(@"finally");
        }
    }

    CGContextRelease(cgctx);
    if (data) {
        free(data);
    }
    return color;
}
//创建取点图片工作域：
- (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef) inImage {
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;

    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);

    bitmapBytesPerRow = (int)(pixelsWide * 4);
    bitmapByteCount = (int)(bitmapBytesPerRow * pixelsHigh);

    colorSpace = CGColorSpaceCreateDeviceRGB();

    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return  NULL;
    }

    bitmapData = malloc(bitmapByteCount);
    if (bitmapData == NULL) {
        fprintf(stderr, "Memory not allocated!");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }

    context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaFirst);
    if (context == NULL) {
        free(bitmapData);
        fprintf(stderr, "Context not created!");
    }

    CGColorSpaceRelease(colorSpace);
    return context;

}


















@end
