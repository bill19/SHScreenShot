//
//  SHScreenShotView.m
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "SHScreenShotView.h"
#import "SHScreenShotTopView.h"
#import "Masonry.h"
static CGFloat const kLJScreenShotTopViewHeight = 131.0f;
static CFTimeInterval const kLJScreenShotTimeDiff = 6.0;
@interface SHScreenShotView ()

@property (nonatomic, strong) SHScreenShotTopView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval starTime;
@end
@implementation SHScreenShotView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
        [self setupLayouts];
    }
    return self;
}

- (void)setupSubViews {
    __weak __typeof(self)weakSelf = self;
    SHScreenShotTopView *topView = [[SHScreenShotTopView alloc] init];
    topView.SHScreenShotTopViewClick = ^(NSInteger buttonIndex) {
        if (weakSelf.LJScreenShotViewClick) {
            weakSelf.LJScreenShotViewClick(buttonIndex);
        }
        [weakSelf dismissView];
    };
    [self addSubview:topView];
    self.topView = topView;

    UITapGestureRecognizer *dissmissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    UIView *bottomView = [[UIView alloc] init];
    bottomView.userInteractionEnabled = YES;
    [bottomView addGestureRecognizer:dissmissTap];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)setupLayouts {

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
    }];

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.left.right.mas_equalTo(self);
    }];

}

/**
 展示截图后的页面

 @param image 当前截图的Image
 */
- (void)showScreenShotView:(UIImage *)image {

    self.topView.image = image;
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.topView.transform = CGAffineTransformMakeTranslation(0, -kLJScreenShotTopViewHeight);
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.topView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {

    }];

    _starTime = 0;
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(countdown:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)stopCountTime {
    [_displayLink invalidate];
    _displayLink = nil;
    _starTime = 0;

}

- (void)countdown:(CADisplayLink *)displayLink {
    if (!self.starTime) {
        self.starTime = displayLink.timestamp;
    }
    CFTimeInterval timeDifference = displayLink.timestamp - self.starTime;
    if (timeDifference > kLJScreenShotTimeDiff) {
        self.displayLink.paused = YES;
        [self dismissView];
    }
}

- (void)dismissView {

    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.topView.transform = CGAffineTransformMakeTranslation(0, -kLJScreenShotTopViewHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];

    [self stopCountTime];
}


@end
