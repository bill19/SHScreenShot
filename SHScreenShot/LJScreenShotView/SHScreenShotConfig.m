//
//  SHScreenShotConfig.m
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "SHScreenShotConfig.h"
#import "SHScreenShotView.h"
#import "UIWindow+EventTractingTool.h"
static SHScreenShotConfig *_shareInstance = nil;

@interface SHScreenShotConfig ()
@property (nonatomic, strong) SHScreenShotView *screenShotView;
@property (nonatomic, strong) UIImage *screenshotImage;
@end

@implementation SHScreenShotConfig

+ (SHScreenShotConfig *)shareInstance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[SHScreenShotConfig alloc] init];
    });

    return _shareInstance;
}


#pragma mark - 创建通知信息
- (void)creatScreenShot {

    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //如果表里存在这个控制器的key 则可以截图
        __weak __typeof(self)weakSelf = self;
        weakSelf.screenShotView.LJScreenShotViewClick = ^(NSInteger buttonIndex) {
            [weakSelf screenshotActionWithIndex:buttonIndex];
        };
        weakSelf.screenshotImage = [UIWindow getImageWithFullScreenshot];
        [weakSelf.screenShotView showScreenShotView:weakSelf.screenshotImage];//此处调用之前创建的用于显示截图的UIView，showView
    }];
}

- (SHScreenShotView *)screenShotView {
    if (!_screenShotView) {
        _screenShotView = [[SHScreenShotView alloc] init];
    }
    return _screenShotView;
}


/**
 点击某个按钮跳转页面

 @param index 点击的按钮信息 0 -常见问题： 1 - 在线咨询：2 - 问题反馈：
 */
- (void)screenshotActionWithIndex:(NSInteger)index {

    NSLog(@"点击了%ld按钮",index);
}
@end
