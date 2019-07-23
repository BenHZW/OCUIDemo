//
//  IdiomRequestModel.h
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdiomRequestModel : NSObject
+ (void)idiomParameters:(NSDictionary *)parameters andCallback:(void(^)(NSDictionary *dic))callback;

@end
