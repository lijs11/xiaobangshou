//
//  KKWeixinNewsModel.m
//  小帮手
//
//  Created by Kenny.li on 16/5/21.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeixinNewsModel.h"
#import "MJExtension.h"
@implementation KKWeixinNewsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"desc" : @"description",@"ID" : @"id"};
}


@end
