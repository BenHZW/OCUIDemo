//
//  DictionaryRequestModel.h
//  HZWDictionary
//
//  Created by Gemll on 16/4/11.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryRequestModel : NSObject

+ (void)dictionaryParamters:(NSDictionary *)parameters andCallback:(void(^)(NSDictionary *dic))callback;

@end
