//
//  KKWeatherModel.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeatherModel.h"
#import "MJExtension.h"
@implementation KKWeatherModel
+ (NSDictionary *)objectClassInArray
{
    return @{@"index": [KKWeatherDetail class], @"weather_data": [KKWeatherData class]};
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    
//}


@end


@implementation KKWeatherDetail

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    
//}
@end

@implementation KKWeatherData

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    
//}
@end