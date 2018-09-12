//
//  SHScreenShotView.h
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHScreenShotView : UIView

/**
 展示截图后的页面

 @param image 当前截图的Image
 */
- (void)showScreenShotView:(UIImage *)image;

/**
 点击了某个按钮
 */
@property (nonatomic, copy) void(^LJScreenShotViewClick)(NSInteger buttonIndex);

@end
