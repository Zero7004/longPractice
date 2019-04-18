//
//  CustomBarButtonItem.h
//  HighSpeed
//
//  Created by ryan on 16/9/17.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SLSetFrame.h"

typedef NS_ENUM(NSUInteger, CustomBarButtonItemType) {
    
    kCustomBarButtonItemTypeBack = 1,   //返回,默认
    kCustomBarButtonItemTypeAboutUsBack    //关于我们
};

@protocol CustomBarButtonItemDelegate <NSObject>
@optional
/**
 *  点击按钮的代理
 *
 *  @param sender 按钮
 *  @param type   类型
 *
 *  @return 是否继续
 */
- (void)clickBarButtonItem:(UIBarButtonItem *)sender withType:(CustomBarButtonItemType)type;
- (void)clickBackBarButtonItem:(UIBarButtonItem *)sender;

@end


@interface CustomBarButtonItem : UIBarButtonItem
@property (nonatomic, strong) UIButton *rigthButton;
@property (nonatomic, weak) id<CustomBarButtonItemDelegate> delegate;
+ (NSArray *)barButtonItemsWithTypes:(NSArray *)types delegate:(id)delegate;

@end
