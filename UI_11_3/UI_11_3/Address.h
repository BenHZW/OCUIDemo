//
//  Address.h
//  UI_11_3
//
//  Created by Ibokan_Teacher on 15/10/10.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSSet *student;
@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addStudentObject:(Student *)value;
- (void)removeStudentObject:(Student *)value;
- (void)addStudent:(NSSet *)values;
- (void)removeStudent:(NSSet *)values;

@end
