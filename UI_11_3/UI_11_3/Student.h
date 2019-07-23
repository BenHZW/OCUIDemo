//
//  Student.h
//  UI_11_3
//
//  Created by Ibokan_Teacher on 15/10/10.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Address *address;

@end







