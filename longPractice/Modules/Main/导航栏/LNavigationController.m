//
//  LNavigationController.m
//  longPractice
//
//  Created by forms on 2019/4/18.
//  Copyright © 2019 Long. All rights reserved.
//

#import "LNavigationController.h"

@interface LNavigationController () <UINavigationControllerDelegate>

@end

@implementation LNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.navigationBar.barStyle = UIStatusBarStyleDefault;
    [[UINavigationBar appearance] setBarTintColor:kWhiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBA(51, 51, 51, 1), NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        NSArray *typesLeft = @[@(kCustomBarButtonItemTypeBack)];
        viewController.navigationItem.leftBarButtonItems = [CustomBarButtonItem barButtonItemsWithTypes:typesLeft delegate:viewController];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
