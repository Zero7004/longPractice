//
//  RYDropDownMenuButton.h
//  XinYiYiLiao
//
//  Created by ryan on 2018/5/25.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RYDropDownMenuButton : UIButton
+ (instancetype)createButtonWithImageName:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)btnFrame target:(id)target action:(SEL)action;
@end
