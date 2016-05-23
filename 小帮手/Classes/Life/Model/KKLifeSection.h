//
//  KKLifeSection.h
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KKLifeItem;
@interface KKLifeSection : NSObject
// 头部标题
@property (nonatomic, copy) NSString *headerTitle;
// 尾部标题
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UIView *footerView;


@property (nonatomic,strong)NSMutableArray *items;

+(instancetype)section;

@end
