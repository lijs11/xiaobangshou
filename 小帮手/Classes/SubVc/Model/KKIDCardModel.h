//
//  KKIDCardModel.h
//  小帮手
//
//  Created by Kenny.li on 16/5/19.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKIDCardModel : NSObject

/**身份证号码*/
@property (nonatomic,copy) NSString *idcard;
/**性别*/
@property (nonatomic,copy) NSString *gender;
/**生日*/
@property (nonatomic,copy) NSString *birthday;
/**生肖*/
@property (nonatomic,copy) NSString *zodiac;
/**星座*/
@property (nonatomic,copy) NSString *constellation;
/**地址*/
@property (nonatomic,copy) NSString *address;


@end


/**
 {
 "data": {
 "address": "湖南省茶陵县", //地址
 "birthday": "1985-08-08", //生日
 "constellation": "狮子座",//星座
 "gender": "男",//性别
 "idcard": "430224198508085219", //身份证号码
 "zodiac": "牛"//生肖
 },
 "error": 0,//返回code
 "msg": "succeed"//返回信息
 }
 
 */