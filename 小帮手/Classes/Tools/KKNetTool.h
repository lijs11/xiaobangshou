//
//  KKNetTool.h
//  小帮手
//
//  Created by Kenny.li on 16/5/15.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNetTool : NSObject


+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;



@end
