//
//  KKMainTabBarController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKMainTabBarController.h"
#import "KKTabBar.h"
#import "KKWeixinViewController.h"
#import "KKLifeViewController.h"
#import "KKMoreViewController.h"
#import "KKNewsViewController.h"
#import "KKWeatherViewController.h"

#import "KKNavigationController.h"
#import "CSStickyHeaderFlowLayout.h"

@interface KKMainTabBarController ()
@property (nonatomic,strong) KKTabBar *customTabbar;

@property (nonatomic,weak) KKLifeViewController *lifeVc;
@property (nonatomic,weak) KKNewsViewController *newsVc;
@property (nonatomic,weak) KKWeixinViewController *weixinVc;
@property (nonatomic,weak) KKMoreViewController *moreVc;



@end

@implementation KKMainTabBarController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (UIView *childView in self.view.subviews) {
        if ([childView isKindOfClass:[UIControl class]]) {
            [childView removeFromSuperview];
        }
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self setupTabBar];
    [self setupVc];

}

- (void)setupTabBar{
    
    KKTabBar *customTabbar = [[KKTabBar alloc] init];
    customTabbar.delegate = self;
    customTabbar.frame = self.tabBar.bounds;

    [self.tabBar addSubview:customTabbar];
    self.customTabbar = customTabbar;
    
}


- (void)setupVc{
    
    
    CSStickyHeaderFlowLayout *layout = [[CSStickyHeaderFlowLayout alloc] init];
    KKLifeViewController *lifeVc = [[KKLifeViewController alloc] initWithCollectionViewLayout:layout];
    
    KKNewsViewController *newsVc = [[KKNewsViewController alloc] init];
    KKWeixinViewController *dealsVc = [[KKWeixinViewController alloc] init];
    KKMoreViewController *moreVc = [[KKMoreViewController alloc] init];
    
    self.lifeVc = lifeVc;
    self.newsVc = newsVc;
    self.weixinVc = dealsVc;
    self.moreVc = moreVc;
    
    [self addChildVc:lifeVc withTitle:@"生活" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addChildVc:newsVc withTitle:@"新闻" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self addChildVc:dealsVc withTitle:@"精选" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self addChildVc:moreVc withTitle:@"更多" image:@"tabbar_more"selectedImage:@"tabbar_more_selected"];
    
    //公共
    // 设置文本样式 (UIControlStateNormal + UIControlStateSelected 都需要设置)
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                        NSFontAttributeName            : [UIFont fontWithName:@"Avenir-BookOblique" size:13.f]}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor],
                                                        NSFontAttributeName            : [UIFont fontWithName:@"Avenir-BookOblique" size:13.f]}
                                             forState:UIControlStateSelected];

//    // 修改tabBar背景色 + 去除顶部线条
//    [[UITabBar appearance] setBackgroundImage:[[[UIColor whiteColor] colorWithAlphaComponent:0.5f] imageWithFrame:CGRectMake(0, 0, 10, 10)]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
   
    self.customTabbar.barStyle = UIBarStyleDefault;
    
    
}

- (void)addChildVc:(UIViewController *)childVc withTitle:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    
    KKNavigationController *navVC = [[KKNavigationController alloc] initWithRootViewController:childVc];
    UIImage *image = [UIImage imageWithName:imageName];
    UIImage *selectedimage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedimage];
    childVc.navigationItem.title = title;
    
    [self addChildViewController:navVC];
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
