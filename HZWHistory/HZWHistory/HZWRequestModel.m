//
//  HZWRequestModel.m
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "HZWRequestModel.h"

#define CATEGORYSEARCH @"query"
@implementation HZWRequestModel
+ (void)searchParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray *))callbackToDataSource
{
    [self postParameters:parameters andURL:CATEGORYSEARCH withCallback:^(NSDictionary *post_dic, NSError *error)
    {
        if (!error)
        {
            if ([post_dic[@"retCode"]isEqualToString:@"200"])
            {
                NSArray *categorySearchModel = [MTLJSONAdapter modelsOfClass:[HZWCategorySearchModel class] fromJSONArray:post_dic[@"result"] error:nil];
                callbackToDataSource(categorySearchModel);
            }
            else
            {
                NSLog(@"请求数据出错");
                callbackToDataSource(nil);
            }
        }
        else
        {
            NSLog(@"网络断开");
            callbackToDataSource(nil);
        }
    }];

}


@end
