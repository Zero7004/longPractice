//
//  UIViewController+Utils.h
//  JinFengHuang
//
//  Created by ryan on 2017/5/27.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+ (UIViewController*) currentViewController;
+ (instancetype)NDNViewControllerInstan;

+ (UIImageView *)findHairlineImageViewUnder:(UINavigationController *)navi;

/**
 请求数据时返回的结果（包括成功和失败）
 command是对应的请求
 success请求成功后返回的数据
 error请求失败返回的数据
 **/
- (void)requestCommand:(RACCommand *)command
               success:(void(^)(id success))success
                 error:(void(^)(id x))error;
@end
