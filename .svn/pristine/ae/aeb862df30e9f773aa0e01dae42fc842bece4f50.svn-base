//
//  ZDStickerView.m
//
//  Created by Seonghyun Kim on 5/29/13.
//  Copyright (c) 2013 scipi. All rights reserved.
//

#import "ZDStickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kSPUserResizableViewGlobalInset 5.0
#define kSPUserResizableViewDefaultMinWidth 48.0
#define kSPUserResizableViewInteractiveBorderSize 10.0
#define kZDStickerViewControlSize 32.0


@interface ZDStickerView ()

@property (strong, nonatomic) UIImageView *resizingControl;
@property (strong, nonatomic) UIImageView *deleteControl;

@property (nonatomic) BOOL preventsLayoutWhileResizing;

@property (nonatomic) float deltaAngle;
@property (nonatomic) CGPoint prevPoint;
@property (nonatomic) CGAffineTransform startTransform;

@property (nonatomic) CGPoint touchStart;
@property (nonatomic, assign) CGPoint initialPoint;

@end

@implementation ZDStickerView
@synthesize contentView, touchStart;

@synthesize prevPoint;
@synthesize deltaAngle, startTransform; //rotation
@synthesize resizingControl, deleteControl;
@synthesize preventsPositionOutsideSuperview;
@synthesize preventsResizing;
@synthesize preventsDeleting;
@synthesize minWidth, minHeight;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
        [self setupDefaultAttributes];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupDefaultAttributes];
    }
    return self;
}

- (void)setContentView:(UIImageView *)newContentView {
    [contentView removeFromSuperview];
    contentView = newContentView;
    contentView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2);
//    contentView.frame = CGRectMake(16, 16, self.bounds.size.width-32, self.bounds.size.height-32);
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:contentView];
    contentView.layer.borderColor = [UIColor redColor].CGColor;
    contentView.layer.borderWidth = 1;

    [self bringSubviewToFront:borderView];
    [self bringSubviewToFront:resizingControl];
    [self bringSubviewToFront:deleteControl];

    self.deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.deleteBtn.frame = self.deleteControl.frame;
    self.deleteBtn.center = CGPointMake(CGRectGetMaxX(self.contentView.frame)-6, self.contentView.frame.origin.y+6);
    [self.deleteBtn setImage:[UIImage imageNamed:@"ZDBtn3" ] forState:(UIControlStateNormal)];
    self.deleteBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.deleteBtn addTarget:self action:@selector(userResizableViewDeleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.deleteBtn];

}
#pragma mark -- 移除
- (void)userResizableViewDeleteAction:(UIButton *)sender{
    [self removeFromSuperview];
}
- (void)setFrame:(CGRect)newFrame {
    [super setFrame:newFrame];
    contentView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2, kSPUserResizableViewGlobalInset + kSPUserResizableViewInteractiveBorderSize/2);

    borderView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset);
    resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                      self.bounds.size.height-kZDStickerViewControlSize,
                                      kZDStickerViewControlSize,
                                      kZDStickerViewControlSize);
    deleteControl.frame = CGRectMake(0, 0,
                                     kZDStickerViewControlSize, kZDStickerViewControlSize);
    [borderView setNeedsDisplay];
}
- (void)setupDefaultAttributes {
    borderView = [[SPGripViewBorderView alloc] initWithFrame:CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset)];
    [borderView setHidden:YES];
    [self addSubview:borderView];

    if (kSPUserResizableViewDefaultMinWidth > self.bounds.size.width*0.5) {
        self.minWidth = kSPUserResizableViewDefaultMinWidth;
        self.minHeight = self.bounds.size.height * (kSPUserResizableViewDefaultMinWidth/self.bounds.size.width);
    } else {
        self.minWidth = self.bounds.size.width*0.5;
        self.minHeight = self.bounds.size.height*0.5;
    }
    self.preventsPositionOutsideSuperview = YES;
    self.preventsLayoutWhileResizing = YES;
    self.preventsResizing = NO;
    self.preventsDeleting = NO;

    // 放大缩小控件
    deleteControl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                 kZDStickerViewControlSize, kZDStickerViewControlSize)];
    deleteControl.backgroundColor = [UIColor clearColor];
    deleteControl.image = [UIImage imageNamed:@"ZDBtn1" ];
    deleteControl.userInteractionEnabled = YES;
    [self addSubview:deleteControl];
    [deleteControl addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resizeTranslate:)]];

    resizingControl = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-kZDStickerViewControlSize,
                                                                   self.frame.size.height-kZDStickerViewControlSize,
                                                                   kZDStickerViewControlSize, kZDStickerViewControlSize)];
    resizingControl.backgroundColor = [UIColor clearColor];
    resizingControl.userInteractionEnabled = YES;
    resizingControl.image = [UIImage imageNamed:@"ZDBtn2" ];
    UIPanGestureRecognizer* panResizeGesture = [[UIPanGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(selectorAction:)];
    [resizingControl addGestureRecognizer:panResizeGesture];
//    [self addSubview:resizingControl];
    deltaAngle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y,
                       self.frame.origin.x+self.frame.size.width - self.center.x);

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
    
}


///移除视图
-(void)singleTap:(UIButton *)sender
{
    if (NO == self.preventsDeleting) {
        [sender.superview removeFromSuperview];
    }
    if([_delegate respondsToSelector:@selector(stickerViewDidClose:)]) {
        [_delegate stickerViewDidClose:self];
    }
}
// 视图旋转
- (void)selectorAction:(UIPanGestureRecognizer *)recognizer{
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
            prevPoint = [recognizer locationInView:self];
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            wChange = (point.x - prevPoint.x);
            hChange = (point.y - prevPoint.y);
            if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                prevPoint = [recognizer locationInView:self];
                return;
            }

        /* Rotation */
                float ang = atan2([recognizer locationInView:self.superview].y - self.center.y,
                                  [recognizer locationInView:self.superview].x - self.center.x);
                if (NO == preventsResizing) {
                    _angleDiff = deltaAngle - ang;
                    self.transform = CGAffineTransformMakeRotation(-_angleDiff);
                }
        //
        borderView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset);
        [borderView setNeedsDisplay];
        
        [self setNeedsDisplay];
    }else if ([recognizer state] == UIGestureRecognizerStateEnded){
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
}
// 视图缩放
-(void)resizeTranslate:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state]== UIGestureRecognizerStateBegan)
    {
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
    else if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (self.bounds.size.width < minWidth || self.bounds.size.width < minHeight)
        {
            self.bounds = CGRectMake(self.bounds.origin.x,
                                     self.bounds.origin.y,
                                     minWidth,
                                     minHeight);
            resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                       self.bounds.size.height-kZDStickerViewControlSize,
                                              kZDStickerViewControlSize,
                                              kZDStickerViewControlSize);
            deleteControl.frame = CGRectMake(0, 0,
                                             kZDStickerViewControlSize, kZDStickerViewControlSize);
            prevPoint = [recognizer locationInView:self];
             
        } else {
            CGPoint point = [recognizer locationInView:self];
            float wChange = 0.0, hChange = 0.0;
            
            wChange = (point.x - prevPoint.x);
            hChange = (point.y - prevPoint.y);
            
            if (ABS(wChange) > 20.0f || ABS(hChange) > 20.0f) {
                prevPoint = [recognizer locationInView:self];
                return;
            }
            
            CGFloat w = (self.bounds.size.width - (wChange)) > 60 ? self.bounds.size.width - (wChange) : 60;
            CGFloat h = (self.bounds.size.height - (hChange)) > 60 ? self.bounds.size.height - (hChange) : 60;
            self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,
                                     w, h);
            resizingControl.frame =CGRectMake(self.bounds.size.width-kZDStickerViewControlSize,
                                              self.bounds.size.height-kZDStickerViewControlSize,
                                              kZDStickerViewControlSize, kZDStickerViewControlSize);
            deleteControl.frame = CGRectMake(0, 0,
                                             kZDStickerViewControlSize, kZDStickerViewControlSize);
            prevPoint = [recognizer locationInView:self];
        }
        
        borderView.frame = CGRectInset(self.bounds, kSPUserResizableViewGlobalInset, kSPUserResizableViewGlobalInset);
        [borderView setNeedsDisplay];

        [self setNeedsDisplay];
    }else if ([recognizer state] == UIGestureRecognizerStateEnded){
        prevPoint = [recognizer locationInView:self];
        [self setNeedsDisplay];
    }
}


#pragma mark -- 手指指令
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    touchStart = [touch locationInView:self.superview];
    if([_delegate respondsToSelector:@selector(stickerViewDidBeginEditing:)]) {
        [_delegate stickerViewDidBeginEditing:self];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint touch = [[touches anyObject] locationInView:self.superview];
//    [self translateUsingTouchLocation:touch];
//    touchStart = touch;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidEndEditing:)]) {
        [_delegate stickerViewDidEndEditing:self];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Notify the delegate we've ended our editing session.
    if([_delegate respondsToSelector:@selector(stickerViewDidCancelEditing:)]) {
        [_delegate stickerViewDidCancelEditing:self];
    }
}
#pragma mark -- panAction
- (void)panAction:(UIPanGestureRecognizer *)gesture{
    CGPoint p = [gesture translationInView:self.superview];
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        _initialPoint = self.center;
    }
    self.center = CGPointMake(_initialPoint.x + p.x, _initialPoint.y + p.y);

    /*
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint touch = [pan locationInView:self.superview];
        touchStart = touch;
    }else{
        CGPoint touchPoint = [pan locationInView:self.superview];
        CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                        self.center.y + touchPoint.y - touchStart.y);
        if (self.preventsPositionOutsideSuperview) {
            CGFloat midPointX = CGRectGetMidX(self.bounds);
            if (newCenter.x > self.superview.bounds.size.width - midPointX) {
                newCenter.x = self.superview.bounds.size.width - midPointX;
            }
            if (newCenter.x < midPointX) {
                newCenter.x = midPointX;
            }
            CGFloat midPointY = CGRectGetMidY(self.bounds);
            if (newCenter.y > self.superview.bounds.size.height - midPointY) {
                newCenter.y = self.superview.bounds.size.height - midPointY;
            }
            if (newCenter.y < midPointY) {
                newCenter.y = midPointY;
            }
        }
        self.center = newCenter;
    }
     */

//    [self translateUsingTouchLocation:touch];

}
// 视图移动
- (void)translateUsingTouchLocation:(CGPoint)touchPoint {

    CGPoint newCenter = CGPointMake(self.center.x + touchPoint.x - touchStart.x,
                                    self.center.y + touchPoint.y - touchStart.y);
    if (self.preventsPositionOutsideSuperview) {
        // Ensure the translation won't cause the view to move offscreen.
        CGFloat midPointX = CGRectGetMidX(self.bounds);
        if (newCenter.x > self.superview.bounds.size.width - midPointX) {
            newCenter.x = self.superview.bounds.size.width - midPointX;
        }
        if (newCenter.x < midPointX) {
            newCenter.x = midPointX;
        }
        CGFloat midPointY = CGRectGetMidY(self.bounds);
        if (newCenter.y > self.superview.bounds.size.height - midPointY) {
            newCenter.y = self.superview.bounds.size.height - midPointY;
        }
        if (newCenter.y < midPointY) {
            newCenter.y = midPointY;
        }
    }
    self.center = newCenter;
}


- (void)hideDelHandle
{
    deleteControl.hidden = YES;
}

- (void)showDelHandle
{
    deleteControl.hidden = NO;
}

- (void)hideEditingHandles
{
    resizingControl.hidden = YES;
    deleteControl.hidden = YES;
    [borderView setHidden:YES];
}

- (void)showEditingHandles
{
    resizingControl.hidden = NO;
    deleteControl.hidden = NO;
    [borderView setHidden:NO];
}

@end
