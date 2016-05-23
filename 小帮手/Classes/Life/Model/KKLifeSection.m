//
//  KKLifeSection.m
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKLifeSection.h"
#import "KKLifeItem.h"

@implementation KKLifeSection

+ (instancetype)section
{
    return [[self alloc]init];
}

- (id)init
{
    if (self = [super init]) {
        _items = [NSMutableArray array];
    }
    return self;
}


@end
