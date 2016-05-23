//
//  KKNetTool.m
//  小帮手
//
//  Created by Kenny.li on 16/5/15.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKNetTool.h"
#import "AFNetworking.h"
@implementation KKNetTool

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发生请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}











@end
