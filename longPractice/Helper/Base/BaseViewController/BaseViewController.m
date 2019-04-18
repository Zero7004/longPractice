//
//  BaseViewController.m
//  CarManager
//
//  Created by 刘献亭 on 15/3/21.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "SDImageCache.h"
#import "BaseTableViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    BaseViewController *viewController = [super allocWithZone:zone];
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
    self.view.backgroundColor = kWhiteColor;
    
    if (@available(iOS 11, *)) {
        
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isDisappearView = YES;
}

//- (void)pushViewController:(Class)class object:(id)sendObject {
//    if (![class isSubclassOfClass:[BaseViewController class]] && ![class isSubclassOfClass:[BaseTableViewController class]]) {
//        return;
//    }
//
//    BaseViewController *vc = [class new];
//    vc.sendObject = sendObject;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)presentViewController:(Class)class object:(id)sendObject {
//    if (![class isSubclassOfClass:[BaseViewController class]] && ![class isSubclassOfClass:[BaseTableViewController class]]) {
//        return;
//    }
//    BaseViewController *vc = [class new];
//
//    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:vc];
//    vc.sendObject = sendObject;
//    [self presentViewController:navigationController animated:YES completion:nil];
//}
//
//- (void)popViewController:(Class)class object:(id)resultObject {
//    if (![class isSubclassOfClass:[BaseViewController class]] && ![class isSubclassOfClass:[BaseTableViewController class]]) {
//        return;
//    }
//    BaseViewController *vc = (BaseViewController *) [self findViewController:class];
//    vc.resultObject = resultObject;
//    [self.navigationController popToViewController:vc animated:YES];
//}

- (UIViewController *)findViewController:(Class)aClass {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:aClass]) {
            return controller;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    LogBlue(@"%@---didReceiveMemoryWarning", self.title);
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    //清除所有的内存中图片缓存，不影响正在显示的图片
    [[SDImageCache sharedImageCache] clearMemory];
    //停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];

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

@end
