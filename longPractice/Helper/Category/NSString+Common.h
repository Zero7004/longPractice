//
//  NSString+Common.h
//  XSYTcounselor
//
//  Created by ryan on 2018/4/12.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+ (NSAttributedString *)getAttr:(NSString *)attributedString lineSpace:(CGFloat)lineSpace;
+ (NSString *)getHexStringByColor:(UIColor *)originColor;


- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode align:(NSTextAlignment)alignment;

- (BOOL)isHasNumber;
@end
