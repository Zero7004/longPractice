//
//  UIButton+LXMImagePosition.m
//  Demo_ButtonImageTitleEdgeInsets
//
//  Created by luxiaoming on 16/1/15.
//  Copyright © 2016年 luxiaoming. All rights reserved.
//

#import "UIButton+LXMImagePosition.h"

@implementation UIButton (LXMImagePosition)

- (void)setImagePosition:(LXMImagePosition)postion spacing:(CGFloat)spacing {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];

    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case LXMImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LXMImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LXMImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case LXMImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    
}

- (void)setImagePosition:(LXMImagePosition)postion spacing:(CGFloat)spacing width:(CGFloat)width {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    //超过4个文字宽度
    if (width > 58) {
        labelWidth = 58;
    }
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    
    switch (postion) {
        case LXMImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LXMImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
            
        case LXMImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case LXMImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    
}


/**
 设置角标的个数（右上角）
 
 @param badgeValue <#badgeValue description#>
 */
- (void)setBadgeValue:(NSInteger)badgeValue {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat badgeW   = self.badgeWidth ? self.badgeWidth : 20;
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageX   = self.imageView.frame.origin.x;
    CGFloat imageY   = self.imageView.frame.origin.y;
    
    UILabel *badgeLabel = [[UILabel alloc]init];
    badgeLabel.text = [NSString stringWithFormat:@"%ld",badgeValue];
    if (badgeValue > 99) {
        badgeLabel.text = [NSString stringWithFormat:@"%ld+",badgeValue];
        badgeW = badgeW + 10;
    }
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = self.badgeTextColor ? self.badgeTextColor : kWhiteColor;
    badgeLabel.font = self.badgeTextFont ? self.badgeTextFont :[UIFont systemFontOfSize:12];
    badgeLabel.layer.cornerRadius = badgeW*0.5;
    badgeLabel.clipsToBounds = YES;
    badgeLabel.backgroundColor = self.badgeBgColor ? self.badgeBgColor : kRedColor;
    
    CGFloat badgeX = imageX + imageSize.width - badgeW*0.5;
    CGFloat badgeY = imageY - badgeW*0.25;

    badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
    [self addSubview:badgeLabel];
}

- (void)setNoticeBadgeValue:(NSInteger)badgeValue {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat badgeW   = self.badgeWidth ? self.badgeWidth : 20;
    CGSize imageSize = self.imageView.image.size;
    CGFloat imageX   = 0;
    CGFloat imageY   = 0;
    
    UILabel *badgeLabel = [[UILabel alloc]init];
    badgeLabel.text = [NSString stringWithFormat:@"%ld",badgeValue];
    if (badgeValue > 99) {
        badgeLabel.text = [NSString stringWithFormat:@"%ld+",badgeValue];
        badgeW = badgeW + 10;
    }
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = self.badgeTextColor ? self.badgeTextColor : kWhiteColor;
    badgeLabel.font = self.badgeTextFont ? self.badgeTextFont :[UIFont systemFontOfSize:12];
    badgeLabel.layer.cornerRadius = badgeW*0.5;
    badgeLabel.clipsToBounds = YES;
    badgeLabel.backgroundColor = self.badgeBgColor ? self.badgeBgColor : kRedColor;
    
    CGFloat badgeX = imageX + imageSize.width - badgeW*0.5 + 10;
    CGFloat badgeY = imageY - badgeW*0.25 + 7;

    badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
    [self addSubview:badgeLabel];
}

- (void)clearBadgeValue {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setBadgeWidth:(NSInteger)badgeWidth {
    objc_setAssociatedObject(self, @selector(badgeWidth), @(badgeWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)badgeWidth {
    NSNumber *badgeWidth = objc_getAssociatedObject(self, @selector(badgeWidth));
    return [badgeWidth integerValue];
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor {
    objc_setAssociatedObject(self, @selector(badgeBgColor), badgeBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeBgColor {
    UIColor *badgeBgColor = objc_getAssociatedObject(self, @selector(badgeBgColor));
    return badgeBgColor;
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    objc_setAssociatedObject(self, @selector(badgeTextColor), badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeTextColor {
    UIColor *badgeTextColor = objc_getAssociatedObject(self, @selector(badgeTextColor));
    return badgeTextColor;
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    objc_setAssociatedObject(self, @selector(badgeTextFont), badgeTextFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)badgeTextFont {
    UIFont *badgeTextFont = objc_getAssociatedObject(self, @selector(badgeTextFont));
    return badgeTextFont;
}
@end
