//
//  MSTBaseModel.h
//  Jiehuo
//
//  Created by ZhongSheng on 16/3/16.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MCBaseModel : JSONModel

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *code;

- (BOOL)isSuccess;

@end
