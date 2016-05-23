//
//  KKHistoryIssuesViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/17.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKHistoryIssuesViewController.h"
#import "KKHistoryModel.h"
#import "MJExtension.h"
#import "KKHisTableViewCell.h"
#import "KKHisHeaderViewCell.h"
#import "KKHisDetailViewController.h"
#import "KKNavigationController.h"

@interface KKHistoryIssuesViewController ()
@property (nonatomic,strong)NSMutableArray *dictArray;
@end

@implementation KKHistoryIssuesViewController

- (NSMutableArray *)dictArray{
    if (_dictArray == nil) {
        self.dictArray = [NSMutableArray array];
    }
    return _dictArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.title = @"历史上的今天";
    
    NSDate *dateNow;
    int dayDelay = 1;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:dateNow];
    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    
  //  NSLogg(@"%ld %ld",day,month);
    
    
    
    
    NSString *httpUrl2 = [NSString stringWithFormat:@"http://apis.haoservice.com/lifeservice/toh?month=%ld&day=%ld&key=%@",month,day,HaoSerViceKey];
    [self request:httpUrl2 withHttpArg: nil];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dictArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKHistoryModel *model = self.dictArray[indexPath.row];
    //1.创建cell
    static NSString *ID = @"history";
    KKHisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KKHisTableViewCell" owner:nil options:nil] lastObject];
    }
    
    cell.title.text = model.title;
    cell.subTitle.text = [NSString stringWithFormat:@"%@-%@-%@",model.year,model.month,model.day];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     KKHistoryModel *model = self.dictArray[indexPath.row];
    KKHisDetailViewController *detailVc = [[KKHisDetailViewController alloc] init];
    KKNavigationController *detailNav = [[KKNavigationController alloc] initWithRootViewController:detailVc];
   [self.navigationController pushViewController:detailVc animated:YES];
    
 //    [self.navigationController pushViewController:detailVc animated:YES];
    detailVc.model = model;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    KKHisHeaderViewCell *headerCell = [[[NSBundle mainBundle] loadNibNamed:@"KKHisHeaderViewCell" owner:nil options:nil] lastObject];
    
    headerCell.title.text = [NSString stringWithFormat:@"历史上的今天共发生了%ld件大事",self.dictArray.count];
    return headerCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 70;
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
//    NSLogg(@"%@",httpUrl);
    NSURL *url = [NSURL URLWithString: httpUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest: request  queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        
       if (error) {
           NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
       } else {
//           NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode:%ld", responseCode);
//                                   NSLog(@"HttpResponseBody %@",responseString);
           
           
           NSDictionary *dictSourse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
           
           NSArray *dataArray = dictSourse[@"result"];
           self.dictArray = [KKHistoryModel mj_objectArrayWithKeyValuesArray:dataArray];
          
           [self.tableView reloadData];
             }
           }];
}

@end
