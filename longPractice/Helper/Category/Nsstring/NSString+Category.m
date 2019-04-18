//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import "NSString+Category.h"
#import <CoreText/CoreText.h>


#define LOWERCASE_START 65
#define LOWERCASE_END 90
#define UPPERCASE_START 97
#define UPPERCASE_END 122

@implementation NSString (Category)


+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum
{
    NSMutableString *newStr = [NSMutableString stringWithString:phoneNum];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    return newStr;
}

+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo
{
    NSMutableString *newStr = [NSMutableString stringWithString:accountNo];
    NSRange range = NSMakeRange(4, 8);
    if (newStr.length>12) {
        [newStr replaceCharactersInRange:range withString:@" **** **** "];
    }
    return newStr;
    
}

- (CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)//限制最大高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

/*抹除运费小数末尾的0*/
- (NSString *)removeUnwantedZero {
    if ([[self substringWithRange:NSMakeRange(self.length- 3, 3)] isEqualToString:@"000"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-4)]; // 多一个小数点
    } else if ([[self substringWithRange:NSMakeRange(self.length- 2, 2)] isEqualToString:@"00"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-2)];
    } else if ([[self substringWithRange:NSMakeRange(self.length- 1, 1)] isEqualToString:@"0"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-1)];
    } else {
        return self;
    }
}

//去掉前后空格
- (NSString *)trimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

//+ (NSString*) stringMobileFormat:(NSString *)mobile {
//    if ([mobile isValidMobileNumber]) {
//        NSMutableString* value = [[NSMutableString alloc] initWithString:mobile];
//        [value insertString:@" " atIndex:3];
//        [value insertString:@" " atIndex:8];
//        return value;
//    }
//    
//    return nil;
//}


+ (NSString*) stringChineseFormat:(double)value{
    
    if (value / 100000000 >= 1) {
        return [NSString stringWithFormat:@"%.0f亿",value/100000000];
    }
    else if (value / 10000 >= 1 && value / 100000000 < 1) {
        return [NSString stringWithFormat:@"%.0f万",value/10000];
    }
    else {
        return [NSString stringWithFormat:@"%.0f",value];
    }
    
}

+ (BOOL)isNullOrEmpty:(NSString *)value {
    // 判断是否为 nil 或长度为0
    return !value || [value length] == 0;
}

+ (NSArray*)SeparatedByString:(NSString*)str separate:(NSString*)sep
{
    if (![str containsString:sep]) {
        return nil;
    }
    return [str componentsSeparatedByString:sep];
}

+ (NSString*)ReplacingOccurrencesOfString:(NSString*)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (instancetype)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    NSMutableString *tempStr = num.mutableCopy;
    NSRange range = [num rangeOfString:@"."];
    NSInteger index = 0;
    if (range.length > 0) {
        index = range.location;
    } else {
        index = num.length;
    }
    while ((index - 3) > 0) {
        index -= 3;
        [tempStr insertString:@"," atIndex:index];
    }
    return tempStr;
}

+ (BOOL)isPureNumber:(NSString *)str
{
    [NSCharacterSet decimalDigitCharacterSet];
    if ([[str stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]]trim].length >0) {
        return NO;
    }else{
        return YES;
    }
}


+ (NSString *)convertNumberTraditional:(NSInteger)number
{
    NSString *numMonth;
    switch (number) {
        case 1:
            numMonth = @"壹月";
            break;
        case 2:
            numMonth = @"贰月";
            break;
        case 3:
            numMonth = @"叁月";
            break;
        case 4:
            numMonth = @"肆月";
            break;
        case 5:
            numMonth = @"伍月";
            break;
        case 6:
            numMonth = @"陆月";
            break;
        case 7:
            numMonth = @"柒月";
            break;
        case 8:
            numMonth = @"捌月";
            break;
        case 9:
            numMonth = @"玖月";
            break;
        case 10:
            numMonth = @"拾月";
            break;
        case 11:
            numMonth = @"十一月";
            break;
        case 12:
            numMonth = @"十二月";
            break;
            
        default:
            break;
    }
    return numMonth;
}

+ (NSString *)convertNumberMonth:(NSInteger)number
{
    NSString *numMonth;
    switch (number) {
        case 1:
            numMonth = @"一月";
            break;
        case 2:
            numMonth = @"二月";
            break;
        case 3:
            numMonth = @"三月";
            break;
        case 4:
            numMonth = @"四月";
            break;
        case 5:
            numMonth = @"五月";
            break;
        case 6:
            numMonth = @"六月";
            break;
        case 7:
            numMonth = @"七月";
            break;
        case 8:
            numMonth = @"八月";
            break;
        case 9:
            numMonth = @"九月";
            break;
        case 10:
            numMonth = @"十月";
            break;
        case 11:
            numMonth = @"十一月";
            break;
        case 12:
            numMonth = @"十二月";
            break;
            
        default:
            break;
    }
    return numMonth;
}

+ (NSString *)convertIntForNSString:(NSInteger)number {
    NSString *stringInt = [NSString stringWithFormat:@"%ld",number];
    return stringInt;
}

+ (NSString *)convertfloatForNSString:(CGFloat)number
{
    NSString *stringInt = [NSString stringWithFormat:@"%f",number];
    return stringInt;
}

+ (NSString *)convertTwofloatForNSString:(CGFloat)number{
    NSString *stringInt = [NSString stringWithFormat:@"%.2f",number];
    return stringInt;
}

+ (NSString *)convertTwofloatForNSString:(CGFloat)number string:(NSString*)string {
    NSString *stringInt = [NSString stringWithFormat:@"%.2f%@",number,string];
    return stringInt;
}

+ (NSMutableAttributedString *)AttributeFontForLabel:(NSString*)text  needLength:(NSInteger)needLength font:(UIFont*)font;
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    //在固定单位长度内的内容显示样式
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(needLength , [text length] - needLength)];
    return str;
}

+ (NSMutableAttributedString *)AttributeColorForLabel:(UILabel*)textlbl wholeLength:(NSInteger)wholeLength needLength:(NSInteger)needLength
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textlbl.text];
    //在固定单位长度内的内容显示样式
    [str addAttribute:NSForegroundColorAttributeName value:textlbl.font range:NSMakeRange(needLength , wholeLength - needLength)];
    return str;

}

//MARK: - 自适应字体宽度跟高度  ios7以后的方法
+ (CGSize)initResizeLabelWithText:(NSString*)text size:(CGSize)size attribute:(NSDictionary *)attribute
{
    return  [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
}

//- (NSString *)convertPinYinFirstLetters {
//    if (![NSString isNullOrEmpty:self]) {
//        NSString *result = @"";
//        for (NSUInteger i = 0, count = self.length; i < count; ++i) {
//            unichar c = [self characterAtIndex:i];
//            if (!((c >= LOWERCASE_START && c <= LOWERCASE_END) ||
//                  (c >= UPPERCASE_START && c <= UPPERCASE_END))) {
//                c = pinyinFirstLetter(c);
//            }
//
//            result = [result stringByAppendingFormat:@"%c", c];
//        }
//        return [result uppercaseString];
//    }
//    return self;
//}

- (NSString *)getDate:(NSString *)dateString
{
    NSDate          *datefromString  = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter   = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+5:30"]];
    [dateFormatter setTimeZone: [NSTimeZone systemTimeZone]];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    datefromString                   = [dateFormatter dateFromString:dateString];
    NSLog(@"dateString1   = %@",datefromString);
    
    //NSDate convert to NSString
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+5:30"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString       *strDate          = [dateFormatter stringFromDate:datefromString];
    NSLog(@"strDate   = %@",strDate);
    
    return strDate;
}

- (UIColor *)getColor
{
    unsigned int r,g,b;
    NSRange range = NSMakeRange(0, 2);
    NSString *string1 = [self substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&r];
    
    range = NSMakeRange(2, 2);
    string1 = [self substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&g];
    
    range = NSMakeRange(4, 2);
    string1 = [self substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&b];
    
    return RGB(r, g, b);
}

//MARK: -获得Label每行的文本字符串数组
+ (NSArray *)getLinesArrayOfStringInLabel:(UIView*)view labelString:(NSString *)labelString font:(UIFont *)tetFont {
    NSString *text = labelString;
    UIFont *font   =  tetFont;
    CGRect rect    = [view bounds];
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}



@end




static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

@implementation NSString (Base64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1) {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext) {
                input[i] = raw[ix];
            }
            else {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++) {
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length)) {
            charsonline = 0;
        }
    }     
    return result;
}

@end


@implementation NSString (Format)


@end
