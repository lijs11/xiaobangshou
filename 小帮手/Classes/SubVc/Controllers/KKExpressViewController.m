//
//  KKExpressViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//
#define ExpressHTTPUrl @"http://apis.baidu.com/kuaidicom/express_api/express_api"

#import "KKExpressViewController.h"
#import "KKExpressDetailModel.h"
#import "KKExpressModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface KKExpressViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *companyUrl;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *companyPhone;


@property (weak, nonatomic) IBOutlet UITextField *nuNum;
@property (weak, nonatomic) IBOutlet UITextView *ResultTextView;

- (IBAction)searchBtn;



@property (nonatomic,strong)NSDictionary *dictSourse;
@end

@implementation KKExpressViewController


- (NSDictionary *)dictSourse{
    if (_dictSourse == nil) {
        self.dictSourse = [NSDictionary dictionary];
    }
    return _dictSourse;
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"快递单号查询";
    self.nuNum.delegate = self;
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.nuNum becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.nuNum resignFirstResponder];
}






- (IBAction)searchBtn {
    
    [self.nuNum resignFirstResponder];
    
    if (self.nuNum.text.length == 0 || [self.nuNum.text isEqualToString:@" "]) {
        [MBProgressHUD showError:@"请输入正确的快递单号"];
        return;
    }
    
    
    NSString *httpArg = [NSString stringWithFormat:@"com=&nu=%@&muti=0&order=desc",self.nuNum.text];
    [self request: ExpressHTTPUrl withHttpArg: httpArg];
    
}


-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: BaiduApikey forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
       if (error) {
           NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
       } else {
//           NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//           NSLog(@"HttpResponseCode:%ld", responseCode);
//           NSLog(@"HttpResponseBody %@",responseString);
           
           self.dictSourse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
           NSLogg(@"%@",self.dictSourse);
           
           [self setupData];
           
       }
   }];
}



- (void)setupData{
    
    if (self.dictSourse == nil) return;
    KKExpressModel *model = [KKExpressModel mj_objectWithKeyValues:self.dictSourse];
    //快递公司信息
    if (model.ico) {
        [self.picView sd_setImageWithURL:[NSURL URLWithString:model.ico] placeholderImage:nil];
        self.companyUrl.text = model.url;
        self.companyName.text = model.company;
        self.companyPhone.text = [NSString stringWithFormat:@"客服电话:%@",model.phone];
    }
    //快递出错
    if (model.status == 0) {
        if (model.reason.length) {
             self.ResultTextView.text = model.reason;
        }else{
             self.ResultTextView.text = @"没有快递信息!";
        }
       
        return;
    }
    
   
    
    //快递信息拼接
    NSString *reslutStr = [[NSString alloc] init];
    for (KKExpressDetailModel *deModel in model.data) {
        
        reslutStr = [reslutStr stringByAppendingString:deModel.time];
        reslutStr = [reslutStr stringByAppendingString:@"\n"];
        reslutStr = [reslutStr stringByAppendingString:deModel.context];
        reslutStr = [reslutStr stringByAppendingString:@"\n\n"];
    }
    
    if (reslutStr.length == 0) {
        self.ResultTextView.text = model.reason;
    }else{
        self.ResultTextView.text = reslutStr;
    }
    
   
    
    //1202062389888
}










@end
