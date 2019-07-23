//
//  UserInfo.m
//  New UI
//
//  Created by Ibokan on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (instancetype)userInfoWithName:(NSString*)name sex:(NSString*)sex age:(NSInteger)age email:(NSString*)email passWord:(NSString*)passWord
{
    UserInfo *userInfo = [self new];
    userInfo.name = name;
    userInfo.sex = sex;
    userInfo.age = age;
    userInfo.email = email;
    userInfo.passWord = passWord;
    return userInfo;
}

#pragma mark - 归档与反归档自动调用的方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //如果父类遵守NSCoding协议则需要先调用父类方法
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    //父类关系同上
    self = [super init];
    
    if (self)
    {
        //对各个属性数据进行反归档，使用解码器
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        _email = [aDecoder decodeObjectForKey:@"email"];
        _passWord = [aDecoder decodeObjectForKey:@"passWord"];
        _userId = [aDecoder decodeIntegerForKey:@"userId"];
        
    }
    return self;
}


@end
