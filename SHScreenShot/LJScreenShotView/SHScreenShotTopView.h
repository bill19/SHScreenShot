//
//  SHScreenShotTopView.h
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHScreenShotTopView : UIView

/**
 icon的image
 */
@property (nonatomic, strong) UIImage *image;

/**
 点击某个按钮 常见问题  问题反馈 在线客服
 */
@property (nonatomic, copy) void(^SHScreenShotTopViewClick)(NSInteger buttonIndex);
@end
