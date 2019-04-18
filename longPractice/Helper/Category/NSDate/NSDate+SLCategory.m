//
//  NSDate+SLCategory.m
//  SLStaticLibrary
//
//  Created by mc.sugar on 15/4/3.
//
//

#import "NSDate+SLCategory.h"


@implementation NSDate (SLCategory)

+ (NSDate *)convertDate:(NSString *)valueString formatString:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    //好像不用设置时区  拿的都是系统的时区？ 
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter dateFromString:valueString];
}


- (NSString *)toString:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    //en_US 美国时间
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //TODO UTC 世界时间
//    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//    [dateFormatter setTimeZone:timeZone];
    //获取系统时区
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    [dateFormatter setTimeZone:timeZone];
    return [dateFormatter stringFromDate:self];
}

#pragma mark -- 时间戳转时间 时间戳是13位要除以1000,10位不用除以1000
+ (NSDate *)getTimeToShowWithTimestamp:(NSTimeInterval)timestamp
{
  return [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
}

#pragma mark --配对月份对应的英文
+ (NSString*)matchDateString :(NSInteger)date
{
    NSString *dateString;
    switch (date) {
        case 1:
            dateString = @"Jan";
            break;
        case 2:
            dateString = @"Feb";
            break;
        case 3:
            dateString = @"Mar";
            break;
        case 4:
            dateString = @"Apr";
            break;
        case 5:
            dateString = @"May";
            break;
        case 6:
            dateString = @"Jun";
            break;
        case 7:
            dateString = @"Jul";
            break;
        case 8:
            dateString = @"Aug";
            break;
        case 9:
            dateString = @"Sep";
            break;
        case 10:
            dateString = @"Oct";
            break;
        case 11:
            dateString = @"Nov";
            break;
        case 12:
            dateString = @"Dec";
            break;
        default:
            break;
    }
    return dateString;
}


#pragma mark --两个月份之间的月份差
+ (NSInteger)getUTCFormateDate:(NSString *)newsString oldDate:(NSString *)oldString
{
    NSDate *oldDate = [NSDate convertDate:oldString formatString:@"yyyy MM"];
    NSDate *newDate = [NSDate convertDate:newsString formatString:@"yyyy MM"];
    NSTimeInterval time=[newDate timeIntervalSinceDate:oldDate];//间隔的秒数
    int month=((int)time)/(3600*24*30);
    
    if(month!=0){
        return month;
    }
    else{
        return 1;
    }
}


+ (NSInteger)getUTCFormateDay:(NSString *)newsString oldDate:(NSString *)oldString
{
    NSDate *newDate;
    NSDate *oldDate;
    
    newDate = [NSDate convertDate:newsString formatString:@"yyyy-MM-dd hh:mm:ss"];
    oldDate = [NSDate convertDate:oldString formatString:@"yyyy-MM-dd hh:mm:ss"];
    
    NSInteger unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSDateComponents *comps = [cal components:unitFlags fromDate:newDate];
    NSDate *newBegin  = [cal dateFromComponents:comps];

    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:oldDate];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:newBegin];
    NSInteger beginDays = ((NSInteger)interval)/(3600*24);

    return beginDays;
}

+ (NSString*)getUTCFormateDayString:(NSString *)newsString oldDate:(NSString *)oldString {
    NSDate *newDate;
    NSDate *oldDate;
    
    newDate = [NSDate convertDate:newsString formatString:@"yyyy-MM-dd hh:mm:ss"];
    oldDate = [NSDate convertDate:oldString formatString:@"yyyy-MM-dd hh:mm:ss"];
    
    NSInteger unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [cal components:unitFlags fromDate:newDate];
    NSDate *newBegin  = [cal dateFromComponents:comps];
    
    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:oldDate];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:newBegin];
    NSInteger beginDays = ((NSInteger)interval)/(3600*24);
    
    if (beginDays > 30) {
        return [NSString stringWithFormat:@"%ld月",beginDays/30];
    }
    return  [NSString stringWithFormat:@"%ld周",beginDays/7];
}

+ (NSString *)getLocationTimeString:(NSString *)dateFormatStr
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:dateFormatStr];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

+ (NSTimeInterval)getLocationTimeInterval
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return [dat timeIntervalSince1970];
}


//根据某个日期判断是星期几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];


    // 1.获得年月日
    NSCalendar *calendar;
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        calendar =  [NSCalendar currentCalendar];
    }
    
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:inputDate];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    if ([cmp1 day] == [cmp2 day]) {// 今天
        return @"今天";
    }
    NSDateComponents *theComponents = [calendar components:NSCalendarUnitWeekday fromDate:inputDate];

    if (theComponents.weekday == 1) {
        return @"明天";
    }
    if (theComponents.weekday == 2) {
        return @"后天";
    }
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSString*)nextWeekdayFromDate:(NSDate*)inputDate time:(NSTimeInterval)time
{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *lastWeek = [date dateByAddingTimeInterval:time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    return startDate;
}

+ (NSString*)DateToNextMonth:(NSDate*)monthDate formatString:(NSString *)formatString monthNum:(NSInteger)monthNum
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:monthDate];
    [components setTimeZone:[NSTimeZone timeZoneWithName:@"en_US"]];
    
    [components setMonth:([components month] + monthNum)];
    NSDate *nextMonth = [cal dateFromComponents:components];
    NSString *time = [nextMonth toString:formatString];
    return time;
}

- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1;
        days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    DebugLog(@"%d",ok);
    return startDate;
}

- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
}

- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitMonth forDate:self].length;
}

#pragma mark -- 获取一个月后的日期
-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+ (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *)formate
{
    if ([NSString isNullOrEmpty:dateString]) {
        return  @"";
    }
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    NSDate *nowDate = [NSDate date];
    /////  将需要转换的时间转换成 NSDate 对象
    NSDate *needFormatDate = [dateFormatter dateFromString:dateString];

    /////  取当前时间和转换时间两个日期对象的时间间隔
    /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    //再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = @"";
    
    if (time<=60) {  //// 1分钟以内的
        dateStr = @"刚刚";
    }else if(time<=60*60){  ////  一个小时以内的
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        
    }else if(time<=60*60*24){   //// 在两天内的
        
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            // 在同一天
//            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            //  昨天
//            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            ////  在同一年
            [dateFormatter setDateFormat:@"MM-dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }
    
    return dateStr;
}


+ (NSInteger)formateDateToSecond:(NSString *)dateString withFormate:(NSString *)formate
{
    if ([NSString isNullOrEmpty:dateString]) {
        return  0;
    }
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    
    NSDate *nowDate = [NSDate date];
    /////  将需要转换的时间转换成 NSDate 对象
    NSDate *needFormatDate = [dateFormatter dateFromString:dateString];
    
    NSTimeInterval time = [needFormatDate timeIntervalSinceDate:nowDate];
    
    return time;
}
@end
