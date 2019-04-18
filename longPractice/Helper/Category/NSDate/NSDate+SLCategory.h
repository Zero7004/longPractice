//
//  NSDate+SLCategory.h
//  SLStaticLibrary
//
//  Created by mc.sugar on 15/4/3.
//
//

#import <Foundation/Foundation.h>


@interface NSDate (SLCategory)

/**
 将时间字符串转为时间格式
 @param valueString 时间字符串
 @param formatString 时间字符串格式
 @return 时间
 **/
+ (NSDate *)convertDate:(NSString *)valueString formatString:(NSString *)formatString;


/**
 将时间转为字符串格式
 @param formatString 时间字符串格式
 @return 时间字符串
 **/
- (NSString *)toString:(NSString *)formatString;

/**
 *  时间戳转时间 时间戳是13位要除以1000,10位不用除以1000
 *
 *  @param timestamp 时间戳参数
 *
 *  @return NSDate
 */
+ (NSDate *)getTimeToShowWithTimestamp:(NSTimeInterval)timestamp;

/**
 *  配对月份对应的英文
 *
 *  @param date 数字月份
 *
 *  @return 英文月份
 */
+ (NSString*)matchDateString :(NSInteger)date;

/**
 *  两个月份之间的月份差
 *
 *  @param newsDate <#newsDate description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)getUTCFormateDate:(NSString *)newsString oldDate:(NSString *)oldString;


/**
 *  两个日期之间的天数差
 *
 *  @param newsDate <#newsDate description#>
 *
 *  @return <#return value description#>
 */
+ (NSInteger)getUTCFormateDay:(NSString *)newsString oldDate:(NSString *)oldString;

/**
 *  两个日期之间的天数差  返回月份/周数
 *
 *  @param newsDate <#newsDate description#>
 *
 *  @return <#return value description#>
 */
+ (NSString*)getUTCFormateDayString:(NSString *)newsString oldDate:(NSString *)oldString;

/**
 获取当前时间
 @param dateFormatStr 时间显示规格
 @return 时间字符串
 **/
+ (NSString *)getLocationTimeString:(NSString *)dateFormatStr;

/**
 *  获取当前时间戳(精确到秒)
 *
 *  @return NSTimeInterval
 */
+ (NSTimeInterval)getLocationTimeInterval;

/**
 *  //根据某个日期判断是星期几
 *
 *  @param inputDate <#inputDate description#>
 *
 *  @return <#return value description#>
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *  //计算一周的时间
 *
 *  @param inputDate <#inputDate description#>
 *
 *  @return <#return value description#>
 */
+ (NSString*)nextWeekdayFromDate:(NSDate*)inputDate time:(NSTimeInterval)time;

/**
 *  计算Next Month
 *
 *  @param monthDate    要计算的月份
 *  @param formatString 时间字符串格式
 *  @param monthNum     月份个数
 *
 *  @return <#return value description#>
 */
+ (NSString*)DateToNextMonth:(NSDate*)monthDate formatString:(NSString *)formatString monthNum:(NSInteger)monthNum;

- (NSUInteger)numberOfWeeksInCurrentMonth;


/**
 *  NSDate如何获取一个月后的日期
 *
 *  @param date  <#date description#>
 *  @param month <#month description#>
 *
 *  @return <#return value description#>
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;

/**
 *
 *
 *  @return dateString距离现在的日期
 */
+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;

/**
 *
 *
 *  @return dateString距离现在的日期 多少秒
 */
+ (NSInteger)formateDateToSecond:(NSString *)dateString withFormate:(NSString *)formate;
@end
