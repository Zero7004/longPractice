//
//  UIWebView+Category.m
//  YunFu
//
//  Created by ryan on 2017/10/26.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "UIWebView+Category.h"

@implementation UIWebView (Category)

/** 判断webView是否完全加载完数据 */
- (BOOL)isFinishLoading {
    NSString *readyState = [self stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && !self.isLoading) {
        return YES;
    }else{
        return NO;
    }
}

@end
