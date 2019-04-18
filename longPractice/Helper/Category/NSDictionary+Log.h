//
//  NSDictionary+Log.h
//  XinYiYiLiao
//
//  Created by ryan on 2018/7/9.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale;
@end

@interface NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale;
@end
