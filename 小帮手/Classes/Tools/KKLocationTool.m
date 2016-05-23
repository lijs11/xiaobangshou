//
//  KKLocationTool.m
//  小帮手
//
//  Created by Kenny.li on 16/5/15.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKLocationTool.h"
#import <MapKit/MapKit.h>


@interface KKLocationTool()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic,strong)KKLocatedCityModel *locatedCityModel;
@end

@implementation KKLocationTool

- (KKLocatedCityModel *)locatedCityModel{
    
    if (_locatedCityModel == nil) {
        self.locatedCityModel = [[KKLocatedCityModel alloc] init];
    }
    
    return _locatedCityModel;
}

- (instancetype)init{
    if (self = [super init]) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.geocoder = [[CLGeocoder alloc] init];
        NSLog(@"init");
    }
    return self;
}


- (void)startLocatedWithPermit{
    
    //判断能否定位，默认第一次可以定位
    BOOL isAllowedLocated = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isAllowedLocated"] == NO) {
        isAllowedLocated = [defaults boolForKey:@"isAllowedLocated"];
    }
    if (isAllowedLocated) {
//        NSLogg(@"1.startLocatedWithPermit");
        [self startLocateUserLocation];//开始定位
    }else{
        //无法定位就显示上海的天气
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"上海" forKey:@"currentCity"];
    }
    
    
}




- (void)startLocateUserLocation{
    
    
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
    self.locationManager.distanceFilter=10; //控制定位服务更新频率。单位是“米”
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        [self.locationManager requestAlwaysAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        //当用户使用的时候授权
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];//开启定位
//    NSLogg(@"2.startLocateUserLocation");
}


#pragma  mark - CLLocationManagerDelegate---要在获取到位置后停止 不然各种出错
/***********************定位到用户位置时调用 定位比较频繁*********************/

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
//    NSLogg(@"3.startLocateUserLocation");
    CLLocation *currLocation = [locations lastObject];
    
    NSLogg(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    NSLogg(@"locationManager---%ld",locations.count);
    
    [self.geocoder reverseGeocodeLocation:currLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         // 取出位置
         CLPlacemark *place = placemarks[0];
//         NSLogg(@"place.locality--%@",place.locality);
         
         NSString *cityName = place.locality;
         cityName = [cityName substringToIndex:cityName.length - 1];
         
         if ([cityName isEqualToString:@"香港特别行政"]) {
             cityName = @"香港特别行政区";
         }
         
         NSLogg(@"cityName--%@",cityName);
         if (cityName) {
             self.locatedCityModel.cityName = cityName;
             self.locatedCityModel.coordinate = currLocation.coordinate;             
             [[NSNotificationCenter defaultCenter] postNotificationName:LocatedTool_GetCityNotification object:nil];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:cityName forKey:@"currentCity"];
             
//             NSString *str = [defaults objectForKey:@"currentCity"];
//             NSLogg(@"Tool存入的locatedCityModel--%@",self.locatedCityModel.cityName);
//             NSLogg(@"Tool存入的defaults--%@",str);
             [self.locationManager stopUpdatingLocation];
         }else{
             
             [MBProgressHUD showError:@"定位失败，请手动选择所在城市!"];
             //无法定位就显示上海的天气
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:@"上海" forKey:@"currentCity"];

         }
        
     }];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
        NSLogg(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLogg(@"无法获取位置信息---%@",error);
    }
}



- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}
















#pragma mark - 唯一性
static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedLocationTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
    
}

//拷贝默认只返回一个。Zone是内存空间
- (id)copyWithZone:(NSZone *)zone{
    
    return _instance;//instance之前肯定创建好的，有对象才能拷贝，所以返回单例。要准守NSCopying
}
@end
