//
//  BaseNavigationController.m
//  CarWin
//
//  Created by 李昀 on 15/3/6.
//  Copyright (c) 2015年 李昀. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.navigationBar.barStyle = UIStatusBarStyleDefault;
    [[UINavigationBar appearance] setBarTintColor:kWhiteColor];//设置当行条颜色
//    int fontSize = isIPhone6P ? 18 : 18;
    int fontSize = 18;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBA(51, 51, 51, 1), NSForegroundColorAttributeName, [UIFont systemFontOfSize:fontSize], NSFontAttributeName, nil]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        NSArray *typesLeft = @[@(kCustomBarButtonItemTypeBack)];
        viewController.navigationItem.leftBarButtonItems = [CustomBarButtonItem barButtonItemsWithTypes:typesLeft delegate:viewController];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
@end
