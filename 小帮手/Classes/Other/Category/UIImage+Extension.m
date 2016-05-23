//
//  UIImage+Extension.m
//  网易新闻瀑布流
//
//  Created by Kenny.li on 16/3/9.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color{
    
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    //2.画半圆
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    //3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageWithName:(NSString *)name
{
    if (IOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        // 没有ios7图片
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    // 非ios7
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

- (UIImage *)imageToSize:(CGSize) size
{
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
