//
//  CustomWebViewController.m
//  jfeimao
//
//  Created by ryan on 16/10/9.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "CustomWebViewController.h"

@interface CustomWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)UIProgressView *progressView;

@end

@implementation CustomWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIViews];
}

- (void)setUIViews {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.left.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.webView);
        make.height.mas_equalTo(3);
    }];
 
    //通过监听estimatedProgress可以获取它的加载进度 还可以监听它的title ,URL, loading
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark -- 加载web url
- (void)loadWebViewUrl:(NSString *)url
{
    NSURL *webURL             = [NSURL URLWithString:url];
    
    NSTimeInterval webTimeOut = 10.0;  //timeout時間設定為10秒
    
    NSURLRequest *request = [NSURLRequest requestWithURL:webURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:webTimeOut];
    
    [self.webView loadRequest:request];
}

- (void)loadWebHtmlString:(NSString *)htmlString
{
    NSString *htmlFormt = @"<head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><meta name = \"viewport\" content = \"initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0,user-scalable =yes,\"/><style>img{max-width:%f !important;}</style></head>%@";
 
    NSString *HtmlString = [NSString stringWithFormat:htmlFormt,SCREEN_WIDTH - 10,htmlString];
    [self.webView loadHTMLString:HtmlString baseURL:nil];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"当内容返回的时候调用");
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"这是服务器请求跳转的时候调用");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    // 内容加载失败时候调用
    NSLog(@"这是加载失败时候调用");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    NSLog(@"通过导航跳转失败的时候调用");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 首先，判断是哪个路径
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        // 判断是哪个对象
        if (object == self.webView) {
            NSLog(@"进度信息：%lf",self.webView.estimatedProgress);
            if (self.webView.estimatedProgress == 1.0) {
                //隐藏
                self.progressView.hidden = YES;
            }else{
                // 添加进度数值
                self.progressView.progress = self.webView.estimatedProgress;
            }
        }
    }
}
//注意，观察的移除
- (void)dealloc{
    if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0) {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [WKWebView new];
        _webView.navigationDelegate = self;
        _webView.UIDelegate         = self;
        _webView.backgroundColor = kWhiteColor;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        //滑动返回看这里
        _webView.allowsBackForwardNavigationGestures = NO;
    }
    return _webView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [UIProgressView new];
//        _progressView.progressTintColor = kGreenColor;
        _progressView.tintColor = kBlueColor;
        _progressView.trackTintColor = kGrayColor;
        _progressView.hidden = YES;
    }
    return _progressView;
}
@end
