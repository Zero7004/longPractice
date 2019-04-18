//
//  RYDropDownMenuView.h
//  XinYiYiLiao
//
//  Created by ryan on 2018/5/25.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseConditionBlock)(NSString *titleName, NSInteger itemIndex, NSInteger lastClickedBtnIndex);


@interface RYDropDownMenuView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) ChooseConditionBlock chooseConditionBlock;

@property (nonatomic, strong) UITableView *targetTableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

/* 默认显示的 */
@property (nonatomic, strong) NSArray *defaulTitleArray;

/* 分类按钮 数组 */
@property (nonatomic, strong) NSMutableArray *titleBtnArr;

/* 分类内容 动画起始位置 */
@property (nonatomic, assign) CGFloat startY;

/* 选中状态和未选中状态
 * 默认  选中状态:蓝色文字,蓝色箭头
 *      未选中状态:黑色文字,黑色箭头
 * 使用注意: 参数格式
 @{
 @"selected" : @[[UIColor BlueColor], @"蓝箭头"],  // 选中状态
 @"normal" : @[[UIColor BlackColor], @"黑箭头"]  // 未选中状态
 };
 可以不传 / 也可以只传其中一对键值对 / 也可以都传 (key必须为@"selected"  @"normal")
 */
@property (nonatomic, strong) NSDictionary *stateConfigDict;

//- (void)addInView:(UIView*)superView;

/**
 * 公有方法, 供外界使用
 */
- (void)show;

@end
