//
//  BaseViewControllerProtocol.h
//  YunFu
//
//  Created by ryan on 2017/7/15.
//  Copyright © 2017年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BaseViewControllerProtocol <NSObject>

@optional
//- (instancetype)initWithViewModel:(id <YDViewModelProtocol>)viewModel;
- (void)yd_buttonClick;
- (void)yd_textVerify;
- (void)yd_bindViewModel;
- (void)yd_addSubviews;
- (void)yd_subviewClick;
- (void)yd_layoutNavigation;
- (void)yd_getNewData;
- (void)recoverKeyboard;
//监听侧滑返回
- (void)yd_willMoveToParentViewController;

- (void)yd_didMoveToParentViewController;

@end
