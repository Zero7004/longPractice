//
//  WRImageHelper.h
//  CodeDemo
//
//  Created by wangrui on 2017/7/25.
//  Copyright © 2017年 wangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WRHelper)

-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage *)wr_updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect;

+ (UIImage *)imageWithGradualColor:(UIColor *)color rect:(CGRect)rect;
#pragma mark - 颜色渐变生成图片
+ (UIImage *)imageWithGradualColor:(UIColor *)color otherColor:(UIColor *)otherColor rect:(CGRect)rect;

@end
