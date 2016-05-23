//
//  KKExpressModel.m
//  小帮手
//
//  Created by Kenny.li on 16/5/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKExpressModel.h"
#import "KKExpressDetailModel.h"
#import "MJExtension.h"

@implementation KKExpressModel

+ (NSDictionary *)mj_objectClassInArray{
    
    
    return  @{@"data" : [KKExpressDetailModel class]};
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
}
@end
