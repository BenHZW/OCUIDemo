//
//  NSObject+PostModel.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "NSObject+PostModel.h"
#define HTTPServer @"http://apicloud.mob.com/appstore/"

@implementation NSObject (PostModel)
+ (void)postParameters:(NSDictionary *)parameters andURL:(NSString *)url withCallback:(void (^)(NSDictionary *, NSError *))callback
{
    NSString *URL = [NSString stringWithFormat:@"%@%@",HTTPServer,url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *receiveDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([receiveDict[@"msg"] isEqualToString:@"success"])
        {
            callback(receiveDict,nil);
        }
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"请求失败");
        callback(nil,error);
    }];
}


@end
