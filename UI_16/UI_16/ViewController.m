//
//  ViewController.m
//  UI_16
//
//  Created by Ibokan_Teacher on 15/10/26.
//  Copyright © 2015年 ios22. All rights reserved.
//

#import "ViewController.h"

//定位服务头文件
#import <CoreLocation/CoreLocation.h>

//地图控件头文件
#import <MapKit/MapKit.h>

//自定义大头针模型头文件
#import "MyAnnotation.h"



@interface ViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
//遵守定位管理器协议
{
    //定位管理器
    CLLocationManager *_locationManager;
    
    //地图控件
    __weak IBOutlet MKMapView *_mapView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

#pragma mark - 1.定位服务
    //1.1.初始化定位管理器
    _locationManager = [CLLocationManager new];
    

    
    
    //1.2.设置代理
    _locationManager.delegate = self;
    
    
    //1.3.设置定位相关的选项
    //定位精度（以米为单位）
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //移动多远（以米为单位）后更新定位主句
    _locationManager.distanceFilter = 5;
    
    
    //1.4.请求定位授权
    [_locationManager requestAlwaysAuthorization];
    
    //info.plist文件还要做配置
    //iOS8，加入"Privacy - Location Usage Description"键（不含引号），值随便填入一个字符串
    //iOS9，加入"NSLocationAlwaysUsageDescription"键（不含引号），值随便填入一个字符串
    
    
    
    //1.5.开始定位
    //[_locationManager startUpdatingLocation];
    //一旦调用此方法，定位功能将持续开启，为了节电，可以在不需要的时候关闭定位
    
#pragma mark - 3.地图控件
    //3.1.初始化地图控件
    /*
     //纯代码创建
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
     */
    
    //3.2.设置用户轨迹追踪模式，设置后会自动开启定位服务
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //3.3.设置是否显示用户当前位置
    _mapView.showsUserLocation = YES;
    
    //3.4.设置代理
    _mapView.delegate = self;
    
    
}


#pragma mark - 1.6.定位服务的代理方法
//每当定位数据更新时都会调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    //locations数组中可能包含多个CLLocation对象，而最后一个一定是最新的
    CLLocation *lastLocation = locations.lastObject;
    
    
    //经纬度结构体
    CLLocationCoordinate2D coordinate = lastLocation.coordinate;
    NSLog(@"纬度:%f, 经度:%f", coordinate.latitude, coordinate.longitude);
    
    //海拔高度
    NSLog(@"海拔:%f", lastLocation.altitude);
    
    
#pragma mark - 2.反地理编码
    //2.1.创建地理编码/反编码器
    CLGeocoder *coder = [CLGeocoder new];
    
    
    //2.2.使用编码/反编码器，提供一个位置对象作参数，调用反地理编码的方法
    [coder reverseGeocodeLocation:lastLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //此代码块会在获取了地理数据后回调
        
        //placemarks数组中可能存着若干个CLPlacemark对象
        
        //一般取出第1个
        CLPlacemark *aPlacemark = placemarks.firstObject;
        
        NSLog(@"placemark: %@", aPlacemark);
        
    }];
    
    
}

#pragma mark - 3.5.地图视图代理方法

#pragma mark - 3.5.1.用户位置更新后
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //MKUserLocation类是用于专门表示用户位置点（蓝色点大头针）的模型
    
    
    //从模型中取出位置对象
    CLLocation *location = userLocation.location;
    
    
    //如果想要把地图中心移动到用户所在的位置
  //  [mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000) animated:YES];
    
    
    //反地理编码，并将地址数据赋值给大头针模型的title
    CLGeocoder *coder = [CLGeocoder new];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *aPlacemark = placemarks.firstObject;
        
        //设置用户大头针模型的title属性和subTitle属性
        userLocation.title = @"我的位置";
        
        userLocation.subtitle = [NSString stringWithFormat:@"%@%@%@", aPlacemark.country, aPlacemark.locality, aPlacemark.name];
        
        
    }];
    
}

#pragma mark - 3.5.2.添加了大头针后
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    //需要注意的是，当用户位置定位成功出现蓝色大头针后也会调用这个方法
    
    //遍历数组中的大头针视图，设置其属性
    for (MKAnnotationView *mav in views)
    {
        //设置这个大头针视图是否能显示气泡
        mav.canShowCallout = YES;
        
        //设置大头针视图是否能拖动
        //判断这个大头针视图对应的模型是否为用户位置的蓝色大头针，因为这个大头针原则上不允许拖动
        //用户位置大头针是MKUserLocation类型的
        if (![mav.annotation isKindOfClass:[MKUserLocation class]])
        {
            //不是用户坐标的大头针才能拖动
            mav.draggable = YES;
        }
        
    }
    
    
}


#pragma mark - 3.5.3.点击大头针后调用的方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //1.从大头针中取出大头针模型
    MyAnnotation *annotation = view.annotation;
    
    //暂且认为这是一个自定义大头针的模型
    //但实际上，点击用户位置大头针，也会触发这个代理方法
    //要先排除用户大头针的情况
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return;
    }
    
    
    //如果大头针没有移动过，则不需要做以下的反地理编码
    if (!annotation.coordinateHasChanged)
    {
        return;
    }
    
    
    //2.从大头针模型中取出经纬度
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    
    //3.使用经纬度创建一个位置对象
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    
    
    annotation.title = annotation.subtitle = @" ";
    //4.对这个位置对象进行反地理编码
    CLGeocoder *coder = [CLGeocoder new];
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        CLPlacemark *aPlacemark = placemarks.firstObject;
        
        //给大头针模型的title赋值
        annotation.title = aPlacemark.name;
        
        annotation.subtitle = [NSString stringWithFormat:@"%@%@%@", aPlacemark.country, aPlacemark.locality, aPlacemark.subLocality];
        
        
        //大头针模型的“经纬度发生了变化”标志位置为NO
        annotation.coordinateHasChanged = NO;
        
    }];
    
    
    
    
    
}


#pragma mark - 4.长按手势添加用户自定义大头针
- (IBAction)addAnnotationByLongPress:(UILongPressGestureRecognizer *)sender
{
    //排除长按的其他状态
    if (sender.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    
    
    //4.1.获取长按手势在地图上的界面坐标点
    CGPoint longPressPoint = [sender locationInView:_mapView];
    
    //4.2.通过这个界面坐标点获取地理坐标点
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:longPressPoint toCoordinateFromView:_mapView];
    
    
    //4.3.构建大头针模型
    MyAnnotation *newAnnotation = [MyAnnotation new];
    
    //经纬度属性赋值
    newAnnotation.coordinate = coordinate;
    
    //两个title暂时赋值为空格字符串，等反地理编码成功后再赋予具体数据
    newAnnotation.title = @" ";
    newAnnotation.subtitle = @" ";
    
    
    //4.4.将大头针模型添加到地图上，地图会自动显示大头针
    [_mapView addAnnotation:newAnnotation];
    
}

@end

