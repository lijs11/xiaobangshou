//
//  KKWeatherViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeatherViewController.h"
#import "KKWeatherModel.h"

@interface KKWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *weekLable;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable2;
@property (weak, nonatomic) IBOutlet UILabel *detailLable3;

@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UIImageView *wetherImageView;
@end

@implementation KKWeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加右滑手势
    [self addSwipeRecognizer];
}

#pragma mark 添加右滑手势
- (void)addSwipeRecognizer
{
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(return)];
    
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

#pragma mark 返回上一级
- (void)return
{
   
    // pop返回上一级
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)setWeatherModel:(KKWeatherModel *)weatherModel{
    
    if (weatherModel.currentCity == nil) return;
    
    _weatherModel = weatherModel;
    KKWeatherData *weatherData = weatherModel.weather_data[0];
    self.temperatureLable.text = weatherData.temperature;
    
    
    self.cityLable.text = weatherModel.currentCity;
    self.dateLable.text = weatherModel.date;
    self.windLable.text = [NSString stringWithFormat:@"%@ PM2.5: %@",weatherData.wind,weatherModel.pm25];
    self.temperatureLable.text = weatherData.temperature;
    
    //穿衣指数
    KKWeatherDetail *detail1 = [weatherModel.index firstObject];
    self.detailLable.text = [NSString stringWithFormat:@"%@",detail1.des];
    KKWeatherDetail *detail2 = weatherModel.index[1];
    self.detailLable2.text = [NSString stringWithFormat:@"%@",detail2.des];
    KKWeatherDetail *detail3 = weatherModel.index[2];
    self.detailLable3.text = [NSString stringWithFormat:@"%@",detail3.des];
    
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


@end
