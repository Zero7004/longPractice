//
//  NSObject+additions.m
//  JinFengHuang
//
//  Created by ryan on 2017/6/12.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "NSObject+additions.h"

@implementation NSObject (additions)
+ (BOOL)dx_isNullOrNilWithObject:(id)object;
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}
@end
