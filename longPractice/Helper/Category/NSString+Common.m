//
//  NSString+Common.m
//  XSYTcounselor
//
//  Created by ryan on 2018/4/12.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import "NSString+Common.h"

#define kCommonMiddleTextFont      [UIFont systemFontOfSize:14]

@implementation NSString (Common)
//利用YYText计算行数
+ (NSAttributedString *)getAttr:(NSString *)attributedString lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *resultAttr = [[NSMutableAttributedString alloc] initWithString:attributedString];
    //对齐方式 这里是 两边对齐
//    resultAttr.yy_alignment = NSTextAlignmentJustified;
//    //设置字体大小
//    resultAttr.yy_font = appFontSize(15);
//    resultAttr.yy_color = RGB(51, 51, 51);
//    //设置行间距
//    resultAttr.yy_lineSpacing = lineSpace;
    
    return resultAttr;
}

+ (NSString *)getHexStringByColor:(UIColor *)originColor

{
    NSDictionary *colorDic
    = [self getRGBDictionaryByColor:originColor];
    
    int r = [colorDic[@"R"] floatValue] * 255;
    
    int g = [colorDic[@"G"] floatValue] * 255;
    
    int b = [colorDic[@"B"] floatValue] * 255;
    
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    
    NSString *blue = [NSString stringWithFormat:@"%02x", b];

    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
    
}

+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor

{
    
    CGFloat r=0,g=0,b=0,a=0;
    
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
        [originColor getRed:&r green:&g blue:&b alpha:&a];
        
    }
    
    else {
        
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        
        r = components[0];
        
        g = components[1];
        
        b = components[2];
        
        a = components[3];
    }

    return @{@"R":@(r),
             
             @"G":@(g),
             
             @"B":@(b),
             
             @"A":@(a)};
    
}

- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font
{
    return [self textSizeIn:size font:font breakMode:NSLineBreakByWordWrapping];
}

- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)afont breakMode:(NSLineBreakMode)breakMode
{
    return [self textSizeIn:size font:afont breakMode:NSLineBreakByWordWrapping align:NSTextAlignmentLeft];
}

- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)afont breakMode:(NSLineBreakMode)abreakMode align:(NSTextAlignment)alignment
{
    NSLineBreakMode breakMode = abreakMode;
    UIFont *font = afont ? afont : kCommonMiddleTextFont;
    
    CGSize contentSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode;
    paragraphStyle.alignment = alignment;
    
    NSDictionary* attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    return contentSize;
}


- (BOOL)isHasNumber{
    [NSCharacterSet decimalDigitCharacterSet];
    
    if ([self stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]].length >0) {
        return NO;
    }else{
        return YES;
    }
}
@end
