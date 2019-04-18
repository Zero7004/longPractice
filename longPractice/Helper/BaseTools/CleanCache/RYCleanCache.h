//
//  RYCleanCache.h
//  XinYiYiLiao
//
//  Created by ryan on 2018/7/18.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cleanCacheBlock)();

@interface RYCleanCache : NSObject

/**
 *  清理缓存
 */
//+(void)cleanCache:(cleanCacheBlock)block;
///**
// *  整个缓存目录的大小
// */
//+(float)folderSizeAtPath;

/**
 *  计算目录大小
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (float)folderSizeAtPath:(NSString *)path;

/**
 *  清理缓存文件(简单处理下)
 *
 *  @param path <#path description#>
 */
+(void)clearCache:(NSString *)path finishBlock:(cleanCacheBlock)block;

@end
