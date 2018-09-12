//
//  SHScreenShotTable.h
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHScreenShotTable : NSObject

/**
 判断这个页面是否允许展示 - 在黑名单中的控制器不做展示

 @param vc  当前VC
 @return 是否存在表里
 */
+ (BOOL)isNeedScreenShotController:(UIViewController *)vc;

/**
 通过控制器获取当前控制器的value

 @param vc 当前控制器
 @return 9个PM给的页面给出对应的value其他的使用控制器的name
 */
+ (NSString *)screenshotTitleFromController:(UIViewController *)vc;
@end
