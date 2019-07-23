//
//  IdiomRequestModel.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "IdiomRequestModel.h"
#import "NSObject+PostModel.h"
#import "AppDelegate.h"

#define IDRE @"idiom/query"
@implementation IdiomRequestModel

+ (void)idiomParameters:(NSDictionary *)parameters andCallback:(void (^)(NSDictionary *))callback
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    [self postParameters:parameters andURL:IDRE withCallback:^(NSDictionary *dic, NSError *error)
    {
        hud.hidden = YES;
        if (!error)
        {
            callback(dic[@"result"]);
        }
        else
        {
            callback(nil);
        }
    }];
}


@end
