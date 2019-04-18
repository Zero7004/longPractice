//
//  WRImageHelper.m
//  CodeDemo
//
//  Created by wangrui on 2017/7/25.
//  Copyright © 2017年 wangrui. All rights reserved.
//

#import "WRImageHelper.h"

@implementation UIImage (WRHelper)

-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self wr_updateImageWithTintColor:color alpha:alpha rect:rect];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f rect:rect];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets
{
    return [self wr_updateImageWithTintColor:color alpha:1.0f insets:insets];
}
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self wr_updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 全能初始化方法
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 启动图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    // 获取图片上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(contextRef, alpha);
    // 设置混合模式
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    // 填充当前rect
    CGContextFillRect(contextRef, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


+ (UIImage *)imageWithGradualColor:(UIColor *)color rect:(CGRect)rect{
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, rect.size.width, 0);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, 0, rect.size.height);
    CGPathCloseSubpath(path);
    
    NSArray *colors = @[(id)RGB(212, 0, 10).CGColor,(id)RGB(254, 3, 5).CGColor]; // 渐变色数组
    //创建CGContextRef
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();   // 上下文文本
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //   CGFloat locations[] = { 0.0, 0.3, 1.0 }; // 颜色位置设置,要跟颜色数量相等，否则无效
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);    // 渐变颜色效果设置
    //起止点设置
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);    // 添加路径
    CGContextClip(context);
    // 绘制线性渐变
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGContextRestoreGState(context);
    // 需要手动释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
    
}

+ (UIImage *)imageWithGradualColor:(UIColor *)color otherColor:(UIColor *)otherColor rect:(CGRect)rect {
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, rect.size.width, 0);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, 0, rect.size.height);
    CGPathCloseSubpath(path);
    
    NSArray *colors = @[(id)color.CGColor,(id)otherColor.CGColor]; // 渐变色数组
    //创建CGContextRef
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();   // 上下文文本
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //   CGFloat locations[] = { 0.0, 0.3, 1.0 }; // 颜色位置设置,要跟颜色数量相等，否则无效
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);    // 渐变颜色效果设置
    //起止点设置
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);    // 添加路径
    CGContextClip(context);
    // 绘制线性渐变
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGContextRestoreGState(context);
    // 需要手动释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
    
}
@end
