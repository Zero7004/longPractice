//
//  UtilsMacros.h
//  longPractice
//
//  Created by forms on 2019/4/18.
//  Copyright © 2019 Long. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define DebugLog(format, ...) NSLog(@"<%@ - line:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format), ##__VA_ARGS__])

#define appendString(key,value)  [NSString stringWithFormat:@"%@%@",key,value]

#define ConvertToString(value) [NSString stringWithFormat:@"%@",value]

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//判断是否为空
#define ObjNil(__object,__notNil) __object!=nil ?__object:__notNil

#define StrEmpty(value)  value != nil ? value: @""
//是否为空
#define IsNilOrNull(value , __notNil) (value || [value length] != 0) ? value : __notNil

//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//字体
#define appFontSize(size) [UIFont systemFontOfSize:size]      //系统字体
#define appFontNameAndSize(FontName , FontSize) [UIFont fontWithName:FontName size:FontSize]
#define UIFontBoldSize(size) [UIFont boldSystemFontOfSize:size]  //加粗系统字体
#define BoldFont(font) UIFontBoldSize(font.pointSize)               //字体加粗
#define AdditionFontSize(font) UIFontSize(font.pointSize + SCHO_LOCAL_CONFIG.localCacheConfig.additionFontSize)     //系统自动增加字号

#define URL(url,image) [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,image]]

#define URLImage(image) [NSURL URLWithString:[NSString stringWithFormat:@"%@",image]]

#define DefaultImage(image) [UIImage imageNamed:image]

#define appendString(name,string) [NSString stringWithFormat:@"%@%@",name,string]

#define AppendStr(__stringObject_,...) [NSString stringWithFormat:__stringObject_,##__VA_ARGS__]

#define URLFullImage(imageStr)  [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVERIMGURL,imageStr]]

#define VCClass(VCName)  NSStringFromClass([VCName class])

#define WNavigationBarHeight  64.0f
#define WPageBarHeight 50.0f

#ifdef __OPTIMIZE__
# define LogBlue(__FORMAT__, ...) {}
#else
# define LogBlue(frmt, ...) {}
#endif

//项目主颜色
#define APPMainColor [UIColor whiteColor]
#define APPYellowColor [UIColor colorWithRed:250/255.0f green:154/255.0f blue:0/255.0f alpha:1]
#define APPredColor [UIColor colorWithRed:253/255.0f green:81/255.0f blue:55/255.0f alpha:1]

#endif /* UtilsMacros_h */
