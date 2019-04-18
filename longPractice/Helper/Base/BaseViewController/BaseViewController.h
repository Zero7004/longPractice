//
//  BaseViewController.h
//  CarManager
//
//  Created by 刘献亭 on 15/3/21.
//  Copyright (c) 2015年 David. All rights reserved.
//
#import "BaseViewControllerProtocol.h"

@interface BaseViewController : UIViewController <UITextFieldDelegate,BaseViewControllerProtocol>

@property (nonatomic, assign) BOOL isDisappearView;//是否要离开页面

//@property(nonatomic, assign) NSInteger statusBarStyle;
//
//@property(nonatomic, assign) BOOL navigationBarHidden;
//
//@property(nonatomic, strong) id sendObject;
////
//@property(nonatomic, strong) id resultObject;

//- (void)pushViewController:(Class)class object:(id)sendObject;
//
//- (void)popViewController:(Class)class object:(id)sendObject;
//
//- (void)presentViewController:(Class)class object:(id)sendObject;

@end
