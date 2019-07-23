//
//  Student.h
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵守NSCoding才能被归档和反归档
@interface Student : NSObject<NSCoding>

@property(nonatomic, copy)NSString *name;
@property(nonatomic)NSInteger age;

@end












