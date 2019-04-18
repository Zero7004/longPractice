//
//  PayModel.h
//  YunFu
//
//  Created by ryan on 2018/3/26.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import "MCBaseModel.h"
@class AlipayModel,AlipayDataModel,WechatModel,WechatResultModel;

@interface PayModel : MCBaseModel

@end

//支付宝
@interface AlipayModel : MCBaseModel
@property (nonatomic, strong) AlipayDataModel *data;

@end

@interface AlipayDataModel : JSONModel
@property (nonatomic, copy) NSString *params1;
@property (nonatomic, copy) NSString *params2;
@property (nonatomic, copy) NSString *params3;

@end

/****************微信****************/
@interface WechatModel : MCBaseModel

@property (nonatomic, strong) WechatResultModel *data;

@end

@interface WechatResultModel : MCSubBaseModel

@property (nonatomic, strong) NSString *payMoney;

@property (nonatomic, strong) NSString *package;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, strong) NSString *timestamp;

@end
