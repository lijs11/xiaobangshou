//
//  KKExpressModel.h
//  小帮手
//
//  Created by Kenny.li on 16/5/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKExpressModel : NSObject

/**请求的快递单号*/
@property (nonatomic,copy) NSNumber *nu;


/**运单的当前状态码：0 物流单号暂无结果， 3 在途，4 揽件，5 疑难，6 签收，7 退签，8 派件，9 退回*/
@property (nonatomic,copy) NSNumber *status;

/**快递公司短码*/
@property (nonatomic,copy) NSNumber *exname;
/**快递公司中文名*/
@property (nonatomic,copy) NSString *company;

/**返回状态：true 1 成功 ，false 0 失败*/
@property (nonatomic,copy) NSNumber *success;
/**如果请求失败，失败原因*/
@property (nonatomic,copy) NSString *reason;

/**运单路由信息，数组形式，元素为 {"time":"时间点","context":"详情"}*/
@property (nonatomic,copy) NSArray *data;

/**快递公司官方客服电话*/
@property (nonatomic,copy) NSString *phone;
/**快递公司官网地址*/
@property (nonatomic,copy) NSString *url;
/**快递公司 logo 图标地址*/
@property (nonatomic,copy) NSString *ico;


@end

/**
 
 {
	reason = ,
	status = 6,
	exname = yuantong,
	data = [
 {
	context = 客户 签收人: 本人 已签收 感谢使用圆通速递，期待再次为您服务,
	time = 2016-4-26 20:36:01
 },

 ],
	phone = 021-69777888,
	ico = http://www.kuaidi.com/data/upload/201407/yt_logo.gif,
	success = 1,
	nu = 806820160474,
	company = 圆通速递,
	url = http://www.yto.net.cn
 }

 
 
 查询成功返回数据字段含义（Unicode编码方式，使用如下数据前请先判断errNum字段）
 success           返回状态：true 成功 ，false 失败
 reason             如果请求失败，失败原因
 data                 运单路由信息，数组形式，元素为 {"time":"时间点","context":"详情"}。
 time为时间点，context为路由详情。
 status              运单的当前状态码：0 物流单号暂无结果， 3 在途，4 揽件，5 疑难，6 签收，7 退签，8 派件，9 退回
 exname            快递公司短码
 company          快递公司中文名
 phone               快递公司官方客服电话
 url                    快递公司官网地址
 ico                   快递公司 logo 图标地址
 nu                    请求的快递单号
 
 */