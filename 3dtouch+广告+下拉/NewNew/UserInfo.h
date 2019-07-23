//
//  UserInfo.h
//  New UI
//
//  Created by Ibokan on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property(nonatomic)NSInteger userId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *sex;

@property(nonatomic)NSInteger age;

@property(nonatomic,copy)NSString *email;

@property(nonatomic,copy)NSString *passWord;

+ (instancetype)userInfoWithName:(NSString*)name sex:(NSString*)sex age:(NSInteger)age email:(NSString*)email passWord:(NSString*)passWord;


@end
