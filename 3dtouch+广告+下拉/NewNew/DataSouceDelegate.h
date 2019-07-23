//
//  DataSouceDelegate.h
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSouceDelegate : NSObject
@property(nonatomic,copy)NSString *url;

-(NSData*)getData:(NSString*)url;
@end
