//
//  KKTopHeaderViewCell.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKTopHeaderViewCell.h"
#import "KKWeatherModel.h"

@interface KKTopHeaderViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *weekLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;

@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UIImageView *wetherImageView;
- (IBAction)BtnClick;
@end


@implementation KKTopHeaderViewCell


- (void)awakeFromNib{
    
    self.userInteractionEnabled = YES;
}

- (void)setWeatherModel:(KKWeatherModel *)weatherModel{
    
    _weatherModel = weatherModel;
    KKWeatherData *weatherData = weatherModel.weather_data[0];
    self.temperatureLable.text = weatherData.temperature;

    
    self.cityLable.text = weatherModel.currentCity;
    self.dateLable.text = weatherModel.date;
    self.windLable.text = [NSString stringWithFormat:@"%@ PM2.5: %@",weatherData.wind,weatherModel.pm25];
    self.temperatureLable.text = weatherData.temperature;
   
    //穿衣指数
    KKWeatherDetail *detail = [weatherModel.index firstObject];
    self.detailLable.text = [NSString stringWithFormat:@"%@",detail.des];
    
    
    self.weekLable.text = [weatherData.date substringToIndex:2];
    self.weatherLable.text = weatherData.weather;
    
    //图片处理
    NSString *weather = weatherData.weather;
    
    NSUInteger strLocation = [weather rangeOfString:@"转"].location;
    if (strLocation != NSNotFound) {
        weather = [weather substringToIndex:strLocation];
    }
    
    self.wetherImageView.image = [UIImage imageWithName:weatherData.weather];
}



//USELESS
- (NSString *)my_description:(NSString *)str {
//    NSString *desc = [self my_description];
    str = [NSString stringWithCString:[str cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return str;
}



/*
@property (nonatomic, copy) NSString *currentCity;
// 当前日期
@property (nonatomic, copy) NSString *date;
// pm25
@property (nonatomic, copy) NSString *pm25;
// 细节信息
@property (nonatomic, strong) NSArray *index;
// 天气详情
@property (nonatomic, strong) NSArray *weather_data;

*/
- (IBAction)BtnClick{
    
    if ([self.delegate respondsToSelector:@selector(topHeaderViewCellDidSelected:)]) {
        [self.delegate topHeaderViewCellDidSelected:self];
    }
    
    
}


@end
