//
//  HZWjsonModel.h
//  HZWHistory
//
//  Created by Gemll on 16/3/7.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface HZWjsonModel : NSObject

@end
@interface HZWCategorySearchModel : MTLModel<MTLJSONSerializing>
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *event;
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *title;



@end