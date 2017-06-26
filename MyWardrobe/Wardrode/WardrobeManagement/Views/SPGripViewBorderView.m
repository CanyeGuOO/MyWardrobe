//
//  SPGripViewBorderView.m
//
//  Created by Seonghyun Kim on 6/3/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "SPGripViewBorderView.h"
#import "MWMacro.h"

@implementation SPGripViewBorderView

#define kSPUserResizableViewGlobalInset 5.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewDefaultMinHeight 48.0
#define kSPUserResizableViewInteractiveBorderSize 10.0

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 20.0);
    CGContextSetStrokeColorWithColor(context, MWColorRGBA(239, 234, 230, 1).CGColor);
    CGContextAddRect(context, CGRectInset(self.bounds, 0, 0));
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

@end
