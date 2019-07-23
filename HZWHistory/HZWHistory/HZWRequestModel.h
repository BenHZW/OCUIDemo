//
//  HZWRequestModel.h
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
#import "NSObject+GetRequest.h"
#import "HZWjsonModel.h"
@interface HZWRequestModel : NSObject

+ (void)searchParameters:(NSDictionary *)parameters andCallback:(void (^)(NSArray *categorySearchModel))callbackToDataSource;


@end
