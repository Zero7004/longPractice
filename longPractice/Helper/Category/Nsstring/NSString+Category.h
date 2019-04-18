//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSString (Category)


//电话号码中间4位****显示
+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum;

//银行卡号中间8位显示
+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo;

//计算文字高度
- (CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

/**抹除运费小数末尾的0*/
- (NSString *) removeUnwantedZero;

//去掉前后空格
- (NSString *) trimmedString;

/**
 *  判断是否为 nil 或空字符串
 *
 *  @param value value 字符串变量
 *
 *  @return BOOL
 */
+ (BOOL)isNullOrEmpty:(NSString *)value;

/**
 *  //分隔字符串
 *
 *  @param str 目标string
 *  @param sep 条件 某个字符
 *
 *  @return NSArray
 */
+ (NSArray*)SeparatedByString:(NSString*)str separate:(NSString*)sep;


/**
 *  替换空格
 *
 *  @param str 目标string
 *  @param sep 某个字符或者空格
 *
 *  @return NSString
 */
+ (NSString*)ReplacingOccurrencesOfString:(NSString*)str;

/**
 *  删除前后所有空格字符
 *
 *  @return 新字符串
 */
- (instancetype)trim;


/**
 *  数字格式，每隔3位添加一个逗号
 *
 *  @param num
 *
 *  @return NSString
 */
+(NSString *)countNumAndChangeformat:(NSString *)num;

/*
 判断字符串是否为纯数字
 */
+ (BOOL)isPureNumber:(NSString *)str;


/**
 数字转月份繁体
 @return NSString
 **/
+ (NSString *)convertNumberTraditional:(NSInteger)number;

/**
 数字转中文月份
 @return NSString
 **/
+ (NSString *)convertNumberMonth:(NSInteger)number;

/**
 *  int 转NSString
 *
 *  @return NSString
 */
+ (NSString *)convertIntForNSString:(NSInteger)number;
+ (NSString *)convertfloatForNSString:(CGFloat)number;
+ (NSString *)convertTwofloatForNSString:(CGFloat)number;
+ (NSString *)convertTwofloatForNSString:(CGFloat)number string:(NSString*)string;

/**
 *  在固定单位长度内的内容显示样式
 *
 *  @param number <#number description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)AttributeFontForLabel:(NSString*)text  needLength:(NSInteger)needLength font:(UIFont*)font;

/**
 *  在固定单位长度内的内容显示样式 color
 *
 *  @param number <#number description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)AttributeColorForLabel:(NSString*)text wholeLength:(NSInteger)wholeLength needLength:(NSInteger)needLength;

/**
 *  自适应字体宽度跟高度  ios7以后的方法
 *
 *  @param text      text
 *  @param size      size
 *  @param attribute attribute
 *
 *  @return CGSize
 */
+ (CGSize)initResizeLabelWithText:(NSString*)text size:(CGSize)size attribute:(NSDictionary *)attribute;


/**
 将字符串中中文字符转为拼音首字母
 @return 拼音首字符串
 **/
//- (NSString *)convertPinYinFirstLetters;


/**
 在字符串中提取日期
 **/
- (NSString *)getDate:(NSString *)dateString;

//RGB字符串转UICOLOR
- (UIColor *)getColor;

+ (NSArray *)getLinesArrayOfStringInLabel:(UIView*)view labelString:(NSString *)labelString font:(UIFont *)tetFont;
@end


@interface NSString (Base64)
//Data类型转换为Base64
+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;
@end


@interface NSString (Format)
//转为电话格式
//+ (NSString*) stringMobileFormat:(NSString*)mobile;
//
////数组中文格式（几万）可自行添加
//+ (NSString*) stringChineseFormat:(double)value;
@end

