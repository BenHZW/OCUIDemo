//
//  MyStepper.h
//  UI-15-Homework1
//
//  Created by CJJMac on 15-6-4.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStepper : UIControl

//当前值，默认是0，必须在最大值与最小值之间
@property(nonatomic) double value;

//能取的最小值，必须比最大值小
@property(nonatomic) double minimumValue;

//能取的最大值，必须比最小值大
@property(nonatomic) double maximumValue;

//步进值，默认是1，必须大于0
@property(nonatomic) double stepValue;

@end









