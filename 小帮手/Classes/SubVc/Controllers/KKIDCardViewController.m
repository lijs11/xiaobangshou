//
//  KKIDCardViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/19.
//  Copyright (c) 2016年 KK. All rights reserved.
//
#define IDCardHTTPUrl @"http://apis.baidu.com/chazhao/idcard/idcard"

#import "KKIDCardViewController.h"

#import "KKIDCardModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface KKIDCardViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cardNum;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *zodiac;
@property (weak, nonatomic) IBOutlet UILabel *constellation;
@property (weak, nonatomic) IBOutlet UILabel *address;


@property (weak, nonatomic) IBOutlet UITextField *nuNum;


- (IBAction)searchBtn;



@property (nonatomic,strong)NSDictionary *dictSourse;
@end

@implementation KKIDCardViewController


- (NSDictionary *)dictSourse{
    if (_dictSourse == nil) {
        self.dictSourse = [NSDictionary dictionary];
    }
    return _dictSourse;
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"身份证号查询";
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
        [MBProgressHUD showError:@"请输入正确的身份证号码"];
        return;
    }
    
    
    
    NSString *httpArg = [NSString stringWithFormat:@"idcard=%@",self.nuNum.text];
    [self request: IDCardHTTPUrl withHttpArg: httpArg];
    
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
//            NSLogg(@"%@",self.dictSourse);
            
            [self setupData];
            
        }
    }];
}



- (void)setupData{
    
    if (self.dictSourse == nil) return;
    //出错
    if (![self.dictSourse[@"msg"] isEqualToString:@"succeed"]) {
        [MBProgressHUD showError:@"身份证号码有错误!"];
        return;
    }
    
    KKIDCardModel *model = [KKIDCardModel mj_objectWithKeyValues:self.dictSourse[@"data"]];
  
    self.cardNum.text = [NSString stringWithFormat:@"身份证号码:%@",model.idcard];
    self.gender.text = [NSString stringWithFormat:@"性别:%@",model.gender];
    self.birthday.text = [NSString stringWithFormat:@"生日:%@",model.birthday];
    self.zodiac.text = [NSString stringWithFormat:@"生肖:%@",model.zodiac];
    self.constellation.text = [NSString stringWithFormat:@"星座:%@",model.constellation];
    self.address.text = [NSString stringWithFormat:@"地址:%@",model.address];
    
   
    
//    @property (weak, nonatomic) IBOutlet UILabel *cardNum;
//    @property (weak, nonatomic) IBOutlet UILabel *gender;
//    @property (weak, nonatomic) IBOutlet UILabel *birthday;
//    @property (weak, nonatomic) IBOutlet UILabel *zodiac;
//    @property (weak, nonatomic) IBOutlet UILabel *constellation;
//    @property (weak, nonatomic) IBOutlet UILabel *address;
//    
    
    //1202062389888
}

/**
 
 {
	error = 0,
	data = {
	constellation = 魔羯座,
	gender = 男,
	idcard = 342423198912264598,
	birthday = 1989-12-26,
	zodiac = 蛇,
	address = 安徽省霍邱县
 },
	msg = succeed
 }
 2016-05-19 01:08:08.629 小帮手[2105:63680] {
	error = -1,
	msg = 身份证号码有误
 }
 
 */

@end
