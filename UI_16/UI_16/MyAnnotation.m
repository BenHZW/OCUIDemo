//
//  MyAnnotation.m
//  UI_16
//
//  Created by Ibokan_Teacher on 15/10/26.
//  Copyright © 2015年 ios22. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

//为了实现changed属性有效，需要通过KVO，自己观察自己的坐标点结构体是否发生改变
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"coordinate" options:0 context:nil];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //这个方法被调用，就说明坐标发生了改变
    if ([object isKindOfClass:[self class]])
    {
        //设置标志位为YES
        self.coordinateHasChanged = YES;
    }
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"coordinate"];
}


@end










