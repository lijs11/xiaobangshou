//
//  KKWeixinViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeixinViewController.h"
#import "REMenu.h"
#import "KKWeixinNewsModel.h"
#import "KKWeixinNewsViewCell.h"
#import "KKWeixinDetailViewController.h"
#import "MJRefresh.h"
@interface KKWeixinViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)REMenu *menu;
@property (nonatomic,strong)UISearchBar *customView;

//@property (nonatomic,strong)NSMutableDictionary *dictSourse;
@property (nonatomic,strong)NSMutableArray *dictArray;
@property (nonatomic,copy) NSString *searchText;
@property (nonatomic,assign) NSUInteger page;
//判断是上拉还是下拉
@property (nonatomic,assign,getter=isHeaderOrFootering) BOOL isHeaderOrFooter;
//返回顶部按钮
@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation KKWeixinViewController
- (NSMutableArray *)dictArray{
    if (_dictArray == nil) {
        self.dictArray = [NSMutableArray array];
    }
    return _dictArray;
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.backBtn.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.backBtn.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.searchText = @"热门";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highImageName:nil target:self action:@selector(selectMoreNews)];
    
//    // 设置背景
//    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixinjingxuan.jpg"]];
//    backgroundView.frame = self.view.bounds;
//    [self.view insertSubview:backgroundView atIndex:0];
//    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //搜索框
    [self setupSearch];
    //回顶部
    [self setBackToTop];
    
    
    //1. 添加头部控件的方法
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //2. 添加尾部控件的方法
   self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
   [self.tableView.mj_header beginRefreshing];
}



- (void)setBackToTop{
    
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"huidingbu.jpg"] forState:UIControlStateNormal];
//    backBtn.backgroundColor = [UIColor redColor];
    backBtn.frame = CGRectMake(HMScreenW - backBtn.currentImage.size.width - 48, HMScreenH - backBtn.currentImage.size.width - 100, 36, 36);
    
//    backBtn.frame = CGRectMake(350, 600, 36, 36);
   // NSLog(@"%lf--%lf",HMScreenW - backBtn.currentImage.size.width - 48,HMScreenH - backBtn.currentImage.size.width - 100);
    [self.tabBarController.view addSubview:backBtn];
    
    self.backBtn = backBtn;
}

- (void)backBtnClick{
        
    [self.tableView setContentOffset:CGPointMake(0, 15) animated:YES];
}


- (void)selectMoreNews{
    
    if (self.menu.isOpen) {
        [self.menu close];
    }else{
        [self.menu showInView:self.tableView];
    }
    
}

- (void)setupSearch{
    UISearchBar *customView = [[UISearchBar alloc] init];
    customView.barTintColor = HMColor(203, 221, 250, 1);
//    self.searchBar = searchBar;
    customView.placeholder = @"请输入您想要搜索的文字";
    customView.delegate = self;
    
//    UIView *customView = [[UIView alloc] init];
    self.customView = customView;
//    customView.frame = CGRectMake(0, 0, self.tableView.width, 50);
//    searchBar.frame = customView.bounds;
//    customView.backgroundColor = [UIColor redColor];
//    [customView addSubview:searchBar];
//    [self.tableView addSubview:customView];
    
    REMenuItem *item = [[REMenuItem alloc] initWithCustomView:customView];
    self.menu = [[REMenu alloc] initWithItems:@[item]];
//    self.menu.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weixinjingxuan.jpg"]];
    
    self.menu.liveBlur = YES;
    self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleLight;
    self.menu.textColor = [UIColor whiteColor];
    self.menu.subtitleTextColor = [UIColor whiteColor];
    self.menu.borderColor = [UIColor grayColor];
    self.menu.borderWidth = 0.1;
    
  //  [self.menu showInView:self.tableView];
}






-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiduApikey2 forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   [MBProgressHUD showError:@"请检查网络~"];
                               } else {
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
                                   NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                  
                                   if (![dataDict[@"msg"] isEqualToString:@"success"]) {
                                       [MBProgressHUD showError:dataDict[@"msg"]];
                                   }
                                   
                                   if (!self.isHeaderOrFooter) {
                                      
                                       [self.dictArray addObjectsFromArray:dataDict[@"newslist"]];//下拉刷新加到后面
                                       NSLog(@"dataDict%@",dataDict[@"newslist"]);
                                   }else if(self.isHeaderOrFooter){
                                       [self.dictArray removeAllObjects];
//                                   NSRange range = NSMakeRange(0, self.dictArray.count);
//                                   NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                                       [self.dictArray addObjectsFromArray:dataDict[@"newslist"]];
                                   }
                                    NSLog(@"self.dictArray.count %ld",self.dictArray.count);
                                   
                                   [self.tableView reloadData];
                               }
                           }];
    
    
    
}


#pragma mark - UISearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
//    if (searchBar.text.length == 0) {
//        searchBar.returnKeyType = UIReturnKeySearch;
//    }
    self.searchText = self.customView.text;
    if (self.menu.isOpen) {
        [self.menu close];
    }

    [self.tableView.mj_header beginRefreshing];
    
    
}


- (void)loadNewData{
    
        self.page = 1;
        self.isHeaderOrFooter = YES;
        NSString *httpUrl = @"http://apis.baidu.com/txapi/weixin/wxhot";
        NSString *word = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *httpArg = [NSString stringWithFormat:@"num=20&rand=1&word=%@&page=1&src=",word];
        [self request: httpUrl withHttpArg: httpArg];

        [self.tableView.mj_header endRefreshing];
        NSLogg(@"endRefreshing");
    
    
}

- (void)loadMoreData{
    
//    if ([self.tableView.mj_footer isRefreshing]) return;
    
    self.isHeaderOrFooter = NO;
    self.page = self.page + 1;
    NSString *httpUrl = @"http://apis.baidu.com/txapi/weixin/wxhot";
    NSString *word = [self.searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *httpArg = [NSString stringWithFormat:@"num=20&rand=1&word=%@&page=%tu&src=",word,self.page];
    [self request: httpUrl withHttpArg: httpArg];
    NSLog(@"self.page %tu",self.page);
    [self.tableView.mj_footer endRefreshing];
    
    
}







#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dictArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 260;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    NSDictionary *dict = self.dictArray[indexPath.section];
    KKWeixinNewsModel *model = [KKWeixinNewsModel mj_objectWithKeyValues:dict];
    
    static NSString *ID = @"KKWeixinNewsViewCellID";
    KKWeixinNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKWeixinNewsViewCell" owner:nil options:nil] lastObject];

    }
    if (model) {
        cell.model = model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dict = self.dictArray[indexPath.section];
    KKWeixinNewsModel *model = [KKWeixinNewsModel mj_objectWithKeyValues:dict];
    
    KKWeixinDetailViewController *Vc =[[KKWeixinDetailViewController alloc] init];
    Vc.urlStr = model.url;
    Vc.title = model.desc;
    [self.navigationController pushViewController:Vc animated:YES];
    
    
}




@end
