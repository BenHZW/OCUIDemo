//
//  NSObject+GetRequest.h
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetRequest)
+ (void)postParameters:(NSDictionary *)parameters andURL:(NSString *)url withCallback:(void(^)(NSDictionary *post_dic,NSError *error))callback;


@end
