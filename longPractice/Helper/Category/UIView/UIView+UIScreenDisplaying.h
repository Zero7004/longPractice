//
//  UIView+UIScreenDisplaying.h
//  ShiSanHang
//
//  Created by 何鹏 on 16/12/3.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIScreenDisplaying)

/**
 *  当前的View是否显示在屏幕上
 *
 *  @return YES is show NO is hide
 */
- (BOOL)isDisplayedInScreen;

- (void)addisDisplayView:(UIView *)view isShow:(void(^)(UIView *superView,UIView *subView))showView;

//计算当前控件在view上的位置坐标
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

@end
