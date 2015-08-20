//
//  UIImage+Extension.h
//  CLWeibo
//
//  Created by Craig Liao on 15/8/3.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//根据图片名自动加载适配iOS6.7的图片
+ (UIImage *)imageWithName:(NSString *)name;

//根据图片名返回一张自由拉伸的图片
+ (UIImage *)resizeImage:(NSString *)name;

@end
