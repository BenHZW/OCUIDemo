//
//  NSObject+GetRequest.m
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "NSObject+GetRequest.h"
#import <AFNetworking.h>

#define HTTPSERVER @"http://apicloud.mob.com/appstore/history/"
@implementation NSObject (GetRequest)

#pragma mark - GET网络请求
+ (void)postParameters:(NSDictionary *)parameters andURL:(NSString *)url withCallback:(void (^)(NSDictionary *, NSError *))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *URL = [NSString stringWithFormat:@"%@%@",HTTPSERVER,url];
    
    NSMutableDictionary *parametersMutable = [[NSMutableDictionary alloc] init];
    [parametersMutable setObject:@"fa0cf9eed7bc"forKey:@"key"];
    [parametersMutable addEntriesFromDictionary:parameters];
    
    //Get请求
    [manager GET:URL parameters:parametersMutable success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
    {
        NSDictionary *receiveDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        callback(receiveDict,nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSDictionary *errorDict = @{@"msg":@"网络似乎断开了哦"};
        if (callback)
        {
            callback(errorDict,[[NSError alloc] init]);
        }
    }];
    
}




@end
