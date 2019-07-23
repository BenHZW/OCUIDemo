//
//  NSObject+PostModel.h
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PostModel)

+ (void)postParameters:(NSDictionary *)parameters andURL:(NSString *)url withCallback:(void(^)(NSDictionary *dic,NSError *error))callback;

@end
