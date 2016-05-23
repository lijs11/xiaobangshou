//
//  KKLocationTool.h
//  小帮手
//
//  Created by Kenny.li on 16/5/15.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKLocatedCityModel.h"

@interface KKLocationTool : NSObject
+ (instancetype)sharedLocationTool;

- (void)startLocatedWithPermit;

@property (nonatomic,strong,readonly)KKLocatedCityModel *locatedCityModel;
@end
