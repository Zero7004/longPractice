//
//  UIViewController+Utils.m
//  JinFengHuang
//
//  Created by ryan on 2017/5/27.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)


+ (UIViewController*) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+ (UIViewController*) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+ (instancetype)NDNViewControllerInstan{
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *svc = (UITabBarController*) viewController;
        for (id vc  in svc.viewControllers) {
            NSLog(@"vc %@",vc);
        }
    }
    
    return viewController;
}

+ (UIImageView *)findHairlineImageViewUnder:(UINavigationController *)navi {
    UIView *backgroundView = [navi.navigationBar subviews].firstObject;
    UIImageView *navLine = backgroundView.subviews.firstObject;
    return navLine;
}

- (void)requestCommand:(RACCommand *)command success:(void (^)(id))success error:(void (^)(id))error {
    [command.errors subscribeNext:^(id x) {
        error(x);
    }];
    
    [command.executionSignals subscribeNext:^(RACSignal *subscribeSignal) {
        
        [[subscribeSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id result) {
            success(result);
        }];
    }];
}

@end
