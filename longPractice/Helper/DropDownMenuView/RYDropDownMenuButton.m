//
//  RYDropDownMenuButton.m
//  XinYiYiLiao
//
//  Created by ryan on 2018/5/25.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import "RYDropDownMenuButton.h"

@implementation RYDropDownMenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 默认设置
        [self setTitleColor:HexColor(0x666666) forState:UIControlStateNormal];
        self.titleLabel.font = appFontSize(15.0);
        
        
    }
    return self;
}

+ (instancetype)createButtonWithImageName:(NSString *)imgName title:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)btnFrame target:(id)target action:(SEL)action
{
    RYDropDownMenuButton *btn = [self buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.frame = btnFrame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat imageWidth = self.imageView.width+1;
    CGFloat labelWidth = self.titleLabel.width+1;
    
    // 图片 位置（右）
    self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    
    
    // 文字 位置（左边）
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}

@end
