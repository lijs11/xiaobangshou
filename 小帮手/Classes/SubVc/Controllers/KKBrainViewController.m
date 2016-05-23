//
//  KKBrainViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/17.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKBrainViewController.h"

@interface KKBrainViewController ()

- (IBAction)next;
@property (weak, nonatomic) IBOutlet UIButton *answer;
- (IBAction)answerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtnStatus;

@property (weak, nonatomic) IBOutlet UILabel *theAnswerLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionLabel;





@property (nonatomic,strong)NSMutableDictionary *dictSourse;
@end

@implementation KKBrainViewController


- (IBAction)answerBtn {
    
    NSArray *dictArray = self.dictSourse[@"newslist"];
    NSDictionary *dict = dictArray[0];
    self.theAnswerLabel.text = dict[@"result"];
}

- (NSMutableDictionary *)dictSourse{
    if (_dictSourse == nil) {
        self.dictSourse = [NSMutableDictionary dictionary];
    }
    return _dictSourse;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}



- (IBAction)next {
    
    self.nextBtnStatus.enabled = NO;
    self.answer.enabled = NO;
    NSString *httpUrl = @"http://apis.baidu.com/txapi/naowan/naowan";
    NSString *httpArg = @"";
    
    [self request: httpUrl withHttpArg: httpArg];
    
    
}


-(void)request:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiduApikey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
           [MBProgressHUD showError:@"查询失败，请检查网络~"];
        } else {
           NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//           NSLogg(@"HttpResponseCode:%ld", responseCode);
//           NSLogg(@"HttpResponseBody %@",responseString);

            self.dictSourse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            NSLogg(@"dic--%@", self.dictSourse);
            
            NSArray *dictArray = self.dictSourse[@"newslist"];
            NSDictionary *dict = dictArray[0];
            self.questionLabel.text = dict[@"quest"];

        }
    }];
    
    self.nextBtnStatus.enabled = YES;
    self.answer.enabled = YES;
}


@end
