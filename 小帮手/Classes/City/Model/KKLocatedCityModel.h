//
//  KKLocatedCityModel.h
//  小帮手
//
//  Created by Kenny.li on 16/5/15.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface KKLocatedCityModel : NSObject
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
