//
//  KKWeixinNewsModel.h
//  小帮手
//
//  Created by Kenny.li on 16/5/21.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKWeixinNewsModel : NSObject
@property (nonatomic,copy) NSString *ctime;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *picUrl;
@end


/**
 {
	msg = success,
	newslist = [
 {
	ctime = 2016-05-13,
	title = 独家专访|张杰：出道12年，我敢为音乐冒任何险，包括在镜头前侃侃而谈,
	description = 橘子娱乐,
	url = http://mp.weixin.qq.com/s?__biz=MjM5MjcwMzI1Ng==&idx=3&mid=2650360526&sn=f71ea53dfd76e62fb285f254221fc015,
	picUrl = http://zxpic.gtimg.com/infonew/0/wechat_pics_-5302122.jpg/640
 },
 
 */