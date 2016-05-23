//
//  KKIPSearchViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/16.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKIPSearchViewController.h"
#import "KKHTTPTool.h"
@interface KKIPSearchViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *textRmindName;
@property (weak, nonatomic) IBOutlet UILabel *result;


- (IBAction)btnClick;
@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (nonatomic,strong)NSMutableDictionary *dictSourse;


@end

@implementation KKIPSearchViewController

- (NSMutableDictionary *)dictSourse{
    if (_dictSourse == nil) {
        self.dictSourse = [NSMutableDictionary dictionary];
    }
    return _dictSourse;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"IP地址查询";
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.delegate = self;
}




- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.textField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.textField resignFirstResponder];
}

- (IBAction)btnClick {
    
    [self.textField resignFirstResponder];
    self.btn.enabled = NO;
    
//    NSLogg(@"%lu--%@",(unsigned long)self.textField.text.length,self.textField.text);
    
    if (self.textField.text.length == 0 || [self.textField.text isEqualToString:@" "] ) {
        self.result.text = @"请输入IP地址!";
        self.btn.enabled = YES;
        return;
    }
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/ip/ip";
    NSString *httpArg = [NSString stringWithFormat:@"ip=%@",self.textField.text];
    
    
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
//           NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//          NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"HttpResponseCode:%ld", responseCode);
//            NSLog(@"HttpResponseBody %@",responseString);
            
            self.dictSourse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
 //           NSLog(@"dic--%@", self.dictSourse);
            NSDictionary *dict = self.dictSourse[@"showapi_res_body"];
            
            if (dict[@"city"] == nil) {
                self.result.text = @"IP地址错误!";
                return;
            }
            
            
            if ([dict[@"region"] isEqualToString:dict[@"city"]]) {
                self.result.text = [NSString stringWithFormat:@"%@ %@ %@",dict[@"country"],dict[@"city"],dict[@"isp"]];
            }else{
            self.result.text = [NSString stringWithFormat:@"%@ %@ %@ %@",dict[@"country"],dict[@"region"],dict[@"city"],dict[@"isp"]];
            }
        }
    }];
    
    self.btn.enabled = YES;
}





@end
