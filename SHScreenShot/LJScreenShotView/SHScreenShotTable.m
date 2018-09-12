//
//  SHScreenShotTable.m
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "SHScreenShotTable.h"

@implementation SHScreenShotTable
+ (BOOL)isNeedScreenShotController:(UIViewController *)vc {

    //假如在黑名单中 - 直接返回NO 不展示截图页面
    NSString *blackListvalue = [[self screenShotBlacklist] valueForKey:NSStringFromClass([vc class])];
    if (blackListvalue.length > 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)screenshotTitleFromController:(UIViewController *)vc {

    NSDictionary *tabDict = [self screenKeyValueTable];
    NSString *key   = NSStringFromClass([vc class]);
    NSString *value = tabDict[key];

    return value;
}

/**
 一定要展示的页面

 @return 展示页面对应的value
 */
+ (NSDictionary *)screenKeyValueTable {

    return [NSDictionary dictionary];
}

/**
 黑名单配置

 @return 配置的黑名单 则不显示截图页面
 */
+ (NSDictionary *)screenShotBlacklist{


    return [NSDictionary dictionary];
}
@end
