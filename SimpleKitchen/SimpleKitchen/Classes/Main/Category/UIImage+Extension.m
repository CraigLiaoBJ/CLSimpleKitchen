//
//  UIImage+Extension.m
//  CLWeibo
//
//  Created by Craig Liao on 15/8/3.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name{
    UIImage *image = nil;
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizeImage:(NSString *)name{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
