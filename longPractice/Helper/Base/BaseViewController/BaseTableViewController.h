//
//  BaseTableViewController.h
//  CarManager
//
//  Created by 刘献亭 on 15/5/2.
//  Copyright (c) 2015年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController<BaseViewControllerProtocol>

@property (nonatomic, assign) BOOL isDisappearView;//是否要离开页面

@end
