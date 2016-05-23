//
//  KKWeixinDetailViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/21.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeixinDetailViewController.h"

@interface KKWeixinDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation KKWeixinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    
    
}

- (void)dealloc{
    
    [self.webView removeFromSuperview];
}




@end
