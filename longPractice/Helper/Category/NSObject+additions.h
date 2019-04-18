//
//  NSObject+additions.h
//  JinFengHuang
//
//  Created by ryan on 2017/6/12.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (additions)
/**
 *  判断对象是否为空
 *  PS：nil、NSNil、@""、@0 以上4种返回YES
 *
 *  @return YES 为空  NO 为实例对象
 */
+ (BOOL)dx_isNullOrNilWithObject:(id)object;
@end
