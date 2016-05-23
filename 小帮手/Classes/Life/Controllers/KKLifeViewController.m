//
//  KKLifeViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKLifeViewController.h"
#import "KKHeaderCellViewCell.h"
#import "KKTopHeaderViewCell.h"
#import "KKLifeCollectionViewCell.h"
#import "CSStickyHeaderFlowLayout.h"

#import "KKHTTPTool.h"
#import "KKWeatherModel.h"
#import "KKLocatedCityModel.h"
#import "KKLocationTool.h"
#import "KKWeatherModel.h"

#import "KKNavigationController.h"
#import "KKWeatherViewController.h"

#import "KKLifeSection.h"
#import "KKLifeItem.h"

#import "KKIPSearchViewController.h"
#import "KKBrainViewController.h"
#import "KKHistoryIssuesViewController.h"
#import "KKWebViewController.h"
#import "KKExpressViewController.h"
#import "KKIDCardViewController.h"

@interface KKLifeViewController ()<KKTopHeaderViewCellDelegate>

@property (nonatomic,strong)NSMutableArray *dataSourseArray;
@property (nonatomic,weak) KKTopHeaderViewCell *weatherCell;
@property (nonatomic,strong)KKWeatherModel *weatherModel;
@property (nonatomic,strong)NSMutableArray *sections;

@end

@implementation KKLifeViewController

static NSString * const reuseCellIdentifier = @"reuseCellIdentifier";
static NSString * const reuseHeaderCellIdentifier = @"reuseHeaderCellIdentifier";
static NSString * const reuseTopHeaderViewIdentifier = @"reuseTopHeaderViewIdentifier";


#pragma mark - 懒加载

- (NSMutableArray *)dataSourseArray{
    if (_dataSourseArray == nil) {
        self.dataSourseArray = [NSMutableArray array];
    }
    return _dataSourseArray;
}
- (KKWeatherModel *)weatherModel{
    if (_weatherModel == nil) {
        self.weatherModel = [[KKWeatherModel alloc] init];
    }
    return _weatherModel;
}
- (NSMutableArray *)sections{
    if (_sections == nil) {
        self.sections = [NSMutableArray array];
    }
    return _sections;
}


#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //修改layout
    [self setupLayout];
    //注册
    [self registerClass];
    
    
    self.collectionView.backgroundColor = HMColor(250, 250, 250, 1);
    
    //城市选择按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"ios7_top_navigation_locationicon" highImageName:nil target:self action:@selector(selectCity)];
    
    //开始定位
    [[KKLocationTool sharedLocationTool] startLocatedWithPermit];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLocatedCity) name:LocatedTool_GetCityNotification object:nil];
    
    
    //无法定位就显示上海的天气
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cityName = [defaults objectForKey:@"currentCity"];
    if (cityName == nil) {
        cityName = @"上海";
    }
    [self loadWeatherData:cityName];
    
    
    
    //添加Items
    [self setSection1];
    [self setSection2];
    [self setSection3];
}

- (void)setupLayout{
    
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 240);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 240);
    }
    //   layout.parallaxHeaderAlwaysOnTop = NO;
    //  layout.disableStickyHeaders = NO;
//    CGFloat pitchX = (HMScreenW - 80 * 4 ) / 5;
    layout.itemSize = CGSizeMake(80,80);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    
    layout.headerReferenceSize = CGSizeMake(200, 50);
    layout.sectionInset = UIEdgeInsetsMake(15, 0, 10, 0);
    
}



//注册
- (void)registerClass {
    
    // 注册内容cell
    UINib *nib1 = [UINib nibWithNibName:@"KKLifeCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib1 forCellWithReuseIdentifier:reuseCellIdentifier];
    
    // 注册headercell
    UINib *nib2 = [UINib nibWithNibName:@"KKHeaderCellViewCell" bundle:nil];
    [self.collectionView registerNib:nib2 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderCellIdentifier];
    
    // 注册TopheaderCell--天气
    UINib *nib3 = [UINib nibWithNibName:@"KKTopHeaderViewCell" bundle:nil];
    [self.collectionView registerNib:nib3 forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:reuseTopHeaderViewIdentifier];
    
    
}
//定位完成通知
- (void)getLocatedCity{
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *city = [defaults objectForKey:@"currentCity"];
    //    NSLog(@"life defaults city -- %@",city);
    
    KKLocatedCityModel *model = [KKLocationTool sharedLocationTool].locatedCityModel;
    NSString *cityName = model.cityName;
    if (cityName == nil) {
        cityName = @"上海";
    }
    [self loadWeatherData:cityName];
    
}

- (void)selectCity{
    
    
    
}


#pragma mark 获取城市天气数据
- (void)loadWeatherData:(NSString *)city
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    if (city == nil) {
        [MBProgressHUD showError:@"没有获取城市值！"];
        return;
    }
    [KKHTTPTool getWeatherDataWithCity:city success:^(id json) {
        
        NSArray *weatherArray = [KKWeatherModel mj_objectArrayWithKeyValuesArray:json[@"results"]];
        //NSLog(@"%@",weatherInfo);
        self.weatherModel = weatherArray[0];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        self.weatherModel.date = currentDateStr;
        
        //NSLog(@"%@",self.weatherModel.mj_keyValues);
        // 设置weatherView
        self.weatherCell.weatherModel = self.weatherModel;
    } failure:^(NSError *error) {
        NSLog(@"加载天气失败!");
    }];
        
    });
}


#pragma mark 添加cell

- (void)setSection1{
    
    KKLifeSection *lifeSection = [KKLifeSection section];
    lifeSection.headerTitle = @"生活查询";
    KKLifeItem *item1 = [KKLifeItem itemWithTilte:@"IP地址查询" icon:@"a5" destVc:[KKIPSearchViewController class]];
    KKLifeItem *item2 = [KKLifeItem itemWithTilte:@"身份证查询" icon:@"s3" destVc:[KKIDCardViewController class]];
    KKLifeItem *item3 = [KKLifeItem itemWithTilte:@"快递查询" icon:@"expre" destVc:[KKExpressViewController class]];
    
    [lifeSection.items addObjectsFromArray:@[item1,item2,item3]];
    [self.sections addObject:lifeSection];
}
- (void)setSection2{
    
    KKLifeSection *yuleSection = [KKLifeSection section];
    yuleSection.headerTitle = @"娱乐休闲";
    KKLifeItem *item1 = [KKLifeItem itemWithTilte:@"脑筋急转弯" icon:@"nao2" destVc:[KKBrainViewController class]];
    KKLifeItem *item2 = [KKLifeItem itemWithTilte:@"历史上的今天" icon:@"shuji" destVc:[KKHistoryIssuesViewController class]];

    [yuleSection.items addObjectsFromArray:@[item1,item2]];
    [self.sections addObject:yuleSection];
}
- (void)setSection3{
    
    KKLifeSection *caipiaoSection = [KKLifeSection section];
    caipiaoSection.headerTitle = @"彩票";
    KKLifeItem *item1 = [KKLifeItem itemWithTilte:@"网易彩票" icon:@"a2" destVc:[KKWebViewController class]];
    
    [caipiaoSection.items addObjectsFromArray:@[item1]];
    [self.sections addObject:caipiaoSection];
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.sections.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    KKLifeSection *itemSection = self.sections[section];
    return itemSection.items.count;
//    if (section == 0) {
//        return 5;
//    }else{
//        return 4;
//    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KKLifeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    KKLifeSection *itemSection = self.sections[indexPath.section];
    cell.item = itemSection.items[indexPath.item];
    return cell;
}



#pragma mark - 代理方法

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //        ProductSection *section = self.sections[indexPath.section];
        
        KKHeaderCellViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderCellIdentifier forIndexPath:indexPath];
        //        cell.titleLable.text = section.headerTitle;
        
        return cell;
        
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        KKTopHeaderViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseTopHeaderViewIdentifier forIndexPath:indexPath];
        // 添加点击事件 不管用
        //        [cell addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWeatherView)]];
        //        if (self.weatherModel == nil) {
        //        } else {
        //            cell.weatherModel = self.weatherModel;
        //        }
        cell.userInteractionEnabled = YES;
        cell.delegate = self;
        self.weatherCell = cell;
        return cell;
    }
    return nil;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KKLifeSection *lifeSection = self.sections[indexPath.section];
    KKLifeItem *lifeItem = lifeSection.items[indexPath.item];
    if (lifeItem.destVcClass) {
        UIViewController *vc = [[lifeItem.destVcClass alloc] init];
        vc.title = lifeItem.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}




#pragma mark - Top代理方法
- (void)topHeaderViewCellDidSelected:(KKTopHeaderViewCell *)cell{
    
    KKWeatherViewController *weatherVc = [[KKWeatherViewController alloc] init];
    
    [self.navigationController presentViewController:weatherVc animated:YES completion:nil];
    weatherVc.weatherModel = self.weatherModel;
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}


@end
