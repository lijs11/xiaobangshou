//
//  KKLifeViewController.h
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKWeatherModel;
@interface KKLifeViewController : UICollectionViewController
@property (nonatomic,strong,readonly)KKWeatherModel *weatherModel;
@end
