//
//  Student.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student

#pragma mark - NSCoding协议必须实现的方法

//归档时自动调用的方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //aCoder是一个编码器，下面会用到它。它在这个方法被调用时会自动传入
    
    //如果父类也遵守了NSCoding协议，则可能需要先调用父类方法
    //[super encodeWithCoder:aCoder];
    
    
    
    //调用编码器的编码方法，对需要归档的数据进行编码
    //注意：被编码的对象必须也遵守NSCoding协议
/*
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
 */
    
#pragma mark - 作业：
#warning 使用属性列表批量编码
    NSArray *propertyNames = [self getPropertyNames];
    
    for (NSString *aPropertyName in propertyNames)
    {
        //通过KVC获得属性值
        id obj = [self valueForKey:aPropertyName];
        
        //编码
        [aCoder encodeObject:obj forKey:aPropertyName];
    }
    
}


//反归档时自动调用的方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //如果父类也遵守NSCoding协议，可能需要首先调用父类方法
    //self = [super initWithCoder:aDecoder];
    
    //否则直接写
    self = [super init];
    
    if (self)
    {
        //对各个数据进行反归档，这里使用的是解码器
/*
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
 */
    
#pragma mark - 作业：
#warning 使用属性列表进行解码
        NSArray *propertyNames = [self getPropertyNames];
        for (NSString *aPropertyName in propertyNames)
        {
            //解码
            id obj = [aDecoder decodeObjectForKey:aPropertyName];
            
            //通过KVC给属性赋值
            [self setValue:obj forKey:aPropertyName];
        }
        
        
    }
    return self;
}


#pragma mark - 作业：
#warning 获取对象属性列表
- (NSArray*)getPropertyNames
{
    //关于以下代码的解说，参见OC的runtime章节
    
    unsigned propertyCount;
    
    objc_property_t *propertyArray = class_copyPropertyList([self class], &propertyCount);
    
    
    //用一个可变数组存放属性名字的字符串
    NSMutableArray *propertyNames = [[NSMutableArray alloc] initWithCapacity:propertyCount];
    
    
    for (unsigned i = 0; i < propertyCount; ++i)
    {
        objc_property_t aProperty = propertyArray[i];
        
        const char *aPropertyName = property_getName(aProperty);
        
        NSLog(@"%s", aPropertyName);
        
        //把属性名添加到数组
        [propertyNames addObject:@(aPropertyName)];
    }
    
    
    //返回不可变数组
    return [NSArray arrayWithArray:propertyNames];
    
}


@end















