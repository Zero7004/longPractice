//
//  RYButton.m
//  XinYiYiLiao
//
//  Created by ryan on 2018/10/18.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import "RYButton.h"

@implementation RYButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = self.bounds;
    
    // top
    rect.origin.y += _touchInsets.top;
    rect.size.height -= _touchInsets.top;
    // left
    rect.origin.x += _touchInsets.left;
    rect.size.width -= _touchInsets.left;
    // bottom
    rect.size.height -= _touchInsets.bottom;
    // right
    rect.size.width -= _touchInsets.right;
    
    if (CGRectContainsPoint(rect, point)) {
        return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

@end
