//
//  UIWindow+EventTractingTool.h
//  LJEventTracting
//
//  Created by 吴洋 on 2017/6/19.
//  Copyright © 2017年 Lianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface UIWindow (EventTractingTool)

+ (UIImage *)getImageWithFullScreenshot;

@end
