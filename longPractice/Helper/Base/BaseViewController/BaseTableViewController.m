//
//  BaseTableViewController.m
//  CarManager
//
//  Created by 刘献亭 on 15/5/2.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseTableViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yd_addSubviews];
        [viewController yd_subviewClick];
        [viewController yd_buttonClick];
        [viewController yd_textVerify];
        [viewController yd_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController yd_layoutNavigation];
        [viewController yd_getNewData];
    }];

    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isDisappearView = YES;
}

- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    
    if (!parent) {
        [self yd_willMoveToParentViewController];
    }
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
}

- (void)dealloc {
    LogBlue(@"%@---delloc", self.title);
}

/**
 *  添加控件
 */
- (void)yd_addSubviews {}


- (void)yd_subviewClick {}
/**
 *  一些事件的处理，如button
 */
- (void)yd_buttonClick {}

- (void)yd_textVerify {}

/**
 *  绑定
 */
- (void)yd_bindViewModel {}

/**
 *  设置navation
 */
- (void)yd_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)yd_getNewData {}

- (void)yd_willMoveToParentViewController {}

- (void)yd_didMoveToParentViewController{}
@end
