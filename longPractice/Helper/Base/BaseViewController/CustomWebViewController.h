//
//  CustomWebViewController.h
//  jfeimao
//
//  Created by ryan on 16/10/9.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <WebKit/WKWebView.h>
#import "BaseViewController.h"

@interface CustomWebViewController : BaseViewController
@property (nonatomic, strong) WKWebView *webView;

- (void)loadWebViewUrl:(NSString*)url;
- (void)loadWebHtmlString:(NSString*)htmlString;

- (void)setUIViews;
@end
