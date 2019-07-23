//
//  MyAnnotation.h
//  UI_16
//
//  Created by Ibokan_Teacher on 15/10/26.
//  Copyright © 2015年 ios22. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//大头针模型类
//需要遵守MKAnnotation协议
@interface MyAnnotation : NSObject<MKAnnotation>

//把协议中的三个属性全都改成可读写
@property(nonatomic)CLLocationCoordinate2D coordinate;

@property(nonatomic, copy)NSString *title;

@property(nonatomic, copy)NSString *subtitle;


//自定义增加一个属性，用于表示这个模型的经纬度有没有发生变化
@property(nonatomic)BOOL coordinateHasChanged;



@end










