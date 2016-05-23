//
//  KKHistoryModel.h
//  小帮手
//
//  Created by Kenny.li on 16/5/17.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKHistoryModel : NSObject

@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *day;
@property (nonatomic,copy) NSNumber *month;
@property (nonatomic,copy) NSNumber *year;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *lunar;
@property (nonatomic,copy) NSString *des;

@end


/**
 id = 5251,
	day = 18,
	pic = ,
	month = 5,
	title = 锡伯族迁移到新疆,
	year = 1764,
	lunar = 甲申年四月十八,
	des = 在250年前的今天，1764年5月18日(农历四月十八)，锡伯族迁移到新疆。锡伯......
 
 
 
 id = 5253,
	day = 18,
	pic = http://imgs.haoservice.com//History/201105/18/8614521533.jpg,
	month = 5,
	title = 虾夷共和国为日本所灭,
	year = 1869,
	lunar = 己巳年四月初七,
	des = 在145年前的今天，1869年5月18日(农历四月初七)，虾夷共和国为日本所灭。......
 */