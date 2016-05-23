//
//  KKLifeItem.m
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKLifeItem.h"

@implementation KKLifeItem



+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon{
    
    return [[self alloc] initWithTilte:title icon:icon];
}

+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc{
    return [[self alloc] initWithTilte:title icon:icon destVc:destVc];
}
+ (instancetype)itemWithTilte:(NSString *)title icon:(NSString *)icon blocker:(void (^)(id item)) blocker{
    return [[self alloc] initWithTilte:title icon:icon blocker:blocker];
}





- (id)init{
    
    return  [super init];
    
}


- (id)initWithTilte:(NSString *)title icon:(NSString *)icon{
    self = [self init];
    self.title = title;
    self.icon = icon;
    return self;
}

- (id)initWithTilte:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc{
    
    self = [self initWithTilte:title icon:icon];
    self.destVcClass = destVc;
    return self;
}


- (id)initWithTilte:(NSString *)title icon:(NSString *)icon blocker:(void (^)(id item))blocker{
    
    self = [self initWithTilte:title icon:icon];
    self.itemBlock = blocker;
    return self;
}


@end
