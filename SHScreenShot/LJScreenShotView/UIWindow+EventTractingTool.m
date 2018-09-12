//
//  UIWindow+EventTractingTool.m
//  LJEventTracting
//
//  Created by 吴洋 on 2017/6/19.
//  Copyright © 2017年 Lianjia. All rights reserved.
//

#import "UIWindow+EventTractingTool.h"

@implementation UIWindow (EventTractingTool)

+ (UIImage *)getImageWithFullScreenshot {
    
    // Source (Under MIT License): https://github.com/shinydevelopment/SDScreenshotCapture/blob/master/SDScreenshotCapture/SDScreenshotCapture.m#L35
    
    BOOL ignoreOrientation = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0");
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    CGSize imageSize = CGSizeZero;
    if (UIInterfaceOrientationIsPortrait(orientation) || ignoreOrientation)
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        
        // Correct for the screen orientation
        if(!ignoreOrientation)
        {
            if(orientation == UIInterfaceOrientationLandscapeLeft)
            {
                CGContextRotateCTM(context, (CGFloat)M_PI_2);
                CGContextTranslateCTM(context, 0, -imageSize.width);
            }
            else if(orientation == UIInterfaceOrientationLandscapeRight)
            {
                CGContextRotateCTM(context, (CGFloat)-M_PI_2);
                CGContextTranslateCTM(context, -imageSize.height, 0);
            }
            else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
            {
                CGContextRotateCTM(context, (CGFloat)M_PI);
                CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
            }
        }
        
        if([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
        else
            [window.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
