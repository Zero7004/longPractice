//
//  UIView+UIScreenDisplaying.m
//  ShiSanHang
//
//  Created by 何鹏 on 16/12/3.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "UIView+UIScreenDisplaying.h"

@implementation UIView (UIScreenDisplaying)

// 判断View是否显示在屏幕上
//- (BOOL)isDisplayedInScreen
//{
//    if (self == nil) {
//        return FALSE;
//    }
//    
//    CGRect screenRect = [UIScreen mainScreen].bounds;
//    
//    // 转换view对应window的Rect
//    CGRect rect = [self convertRect:self.frame fromView:nil];
//    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
//        return FALSE;
//    }
//    
//    // 若view 隐藏
//    if (self.hidden) {
//        return FALSE;
//    }
//    
//    // 若没有superview
//    if (self.superview == nil) {
//        return FALSE;
//    }
//    
//    // 若size为CGrectZero
//    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
//        return  FALSE;
//    }
//    
//    // 获取 该view与window 交叉的 Rect
//    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
//    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
//        return FALSE;
//    }
//    
//    return TRUE;
//}

- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }

    CGRect screenRect = [UIScreen mainScreen].bounds;

    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }

    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }

    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }

    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }

    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }

    return TRUE;
}

- (void)addisDisplayView:(UIView *)view isShow:(void(^)(UIView *superView,UIView *subView))showView
{
//    if ([view isDisplayedInScreen]==FALSE) {
//        [self addSubview:view];
//    }
    if ([view isDisplayedInScreen]==FALSE) {
        [self addSubview:view];
    }
    
    if (showView!=nil) {
        showView(self,view);
    }

}



- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}
@end
