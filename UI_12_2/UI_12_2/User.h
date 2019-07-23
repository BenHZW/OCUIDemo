//
//  User.h
//  UI_12_2
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic)NSInteger userID;

@property(nonatomic,copy)NSString * firstName;

@property(nonatomic,copy)NSString *lastName;

@property(nonatomic)NSInteger age;

@property(nonatomic)double height;

@property(nonatomic)BOOL is_married;




@end
