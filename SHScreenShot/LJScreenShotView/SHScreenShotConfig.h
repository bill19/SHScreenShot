//
//  SHScreenShotConfig.h
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHScreenShotConfig : NSObject

+ (SHScreenShotConfig *)shareInstance;

/**
 创建屏幕截图通知
 */
- (void)creatScreenShot;

@end
