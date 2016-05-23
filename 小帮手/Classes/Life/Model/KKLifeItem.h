//
//  KKLifeItem.h
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKLifeItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
// 点击cell 运行的控制器
@property (nonatomic, assign) Class destVcClass;
@property (nonatomic,copy) void (^itemBlock)();


+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc;
+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon blocker:(void (^)(id item)) blocker;
@end
