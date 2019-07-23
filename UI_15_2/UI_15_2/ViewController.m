//
//  ViewController.m
//  UI_15_2
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
   //创建一个用于实现动画的图层
    CALayer *_myLayer;
    
    
    
    

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //1.创建layer对象
    _myLayer = [CALayer layer];
    
    //要把这个layer添加到某个父图层上
    [self.view.layer addSublayer:_myLayer];
    
    _myLayer.backgroundColor = [UIColor redColor].CGColor;
    
    //设置边框
    _myLayer.borderWidth = 2;
    
    _myLayer.borderColor = [UIColor blackColor].CGColor;
    
    //设置阴影
    _myLayer.shadowColor = [UIColor blueColor].CGColor;
    
    _myLayer.shadowOffset = CGSizeMake(10, 10);
    
    _myLayer.shadowOpacity =  1;//阴影的深度(透明度)(0~1)
    
    //设置圆角
    _myLayer.cornerRadius = 20;//圆角半径的值
    
    
    
    
    
    
    

    
    
    //设置各种属性
    _myLayer.frame = CGRectMake(50, 100, 70, 70);
    
    
    
    
    
}

#pragma mark - 2.基本核心动画
- (IBAction)coreAnimation1
{
    //进行三维变形
    //1.创建基本核心动画对象
    CABasicAnimation *ba = [CABasicAnimation animation];
    
    ba.duration = 6; //动画时长
    
    //如果想让动画结束后维持结束状态
    /*
    ba.removedOnCompletion = NO;
    
    ba.fillMode = kCAFillModeForwards;
    */
    
    
    //2.声明动画开始和结束的三维变形结构体
    CATransform3D startTransform = _myLayer.transform;
    
    
    //比如结束时,发生旋转
    CATransform3D endTransform = CATransform3DRotate(startTransform, M_PI, 1, 2, 3);
    
    //3.把初始值和结束值设置给动画对象
    ba.fromValue = [NSValue valueWithCATransform3D:startTransform];
    
    ba.toValue = [NSValue valueWithCATransform3D:endTransform];
    
   
    
    
    //4.把动画对象添加到layer上开始执行
    //forKey填入的是:这个动画作用于图层的哪个属性，运用了KVC原理
    [_myLayer addAnimation:ba forKey:@"transform"];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 3.关键帧动画
- (IBAction)coreAnimation2
{
   //关键帧允许一个动画中设置多个时间点的状态值
    //1.创建关键帧动画对象
    CAKeyframeAnimation *ka = [CAKeyframeAnimation animation];
    ka.duration  = 10;
    
    //2.构建不同时间点的属性值
    //比如这里要构建四个时间点的position值
    
    NSValue *startPoint = [NSValue valueWithCGPoint:_myLayer.position];
    
    NSValue *endPoint = startPoint;
    
    NSValue *point1 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    
    NSValue *point2 = [NSValue valueWithCGPoint:CGPointMake(10, 100)];
    
    //3.把各个时间点的值按顺序设置给动画对象
    ka.values = @[startPoint,point1,point2,endPoint];
    
    //4.可以设置各关键帧时间进度百分比
    ka.keyTimes = @[@0, @0.1, @0.9, @1];
    
    
    
    
    //5.把动画添加到layer上
    [_myLayer addAnimation:ka forKey:@"position"];
    
    
    
    
}


#pragma mark - 4.组合动画
- (IBAction)coreAnimation3
{
    
   //将多个动画对象组合在一起
    
   //1.创建并配置好各个分动画
   //1.1.基本动画
    //这时创建的时候要指定动画作用的属性
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
  
    
     ba.fromValue =(__bridge id _Nullable)(_myLayer.backgroundColor);
    
     ba.toValue = (__bridge id _Nullable)(([UIColor greenColor].CGColor));

    
    ba.duration = 10;
    
    
    //1.2.关键帧动画
    CAKeyframeAnimation *ka = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *startPoint = [NSValue valueWithCGPoint:_myLayer.position];
    
    NSValue *middlePoint = [NSValue valueWithCGPoint:CGPointMake(100, 310)];
    
    NSValue *endPoint = [NSValue valueWithCGPoint:CGPointMake(300, 100)];
    
    ka.values = @[startPoint,middlePoint,endPoint];
    
    ka.duration = 10;
    
     //2.创建组合动画对象
    CAAnimationGroup *ag = [CAAnimationGroup animation];
    //设置组合动画时间，这个时间应该大于等于最长分动画的时间
    ag.duration = 10;
    
    //3.把分动画添加到组合动画中
    ag.animations = @[ba,ka];
    
    //4.把组合动画添加到layer上
    //这里不用指定key,因为分动画已经指定了
    [_myLayer addAnimation:ag forKey:nil];
    
    
}


#pragma mark - 在传值的方法中设置转场动画
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //1.创建转场动画对象
    CATransition *tran = [CATransition animation];
    
    //2.设置动画效果
    tran.duration = 3;
    
    tran.type = kCATransitionReveal;//动画样式
   //苹果预留了一些不公开的动画效果，如果使用了，app将不能上架
   //tran.type = @"cube";
    
    tran.subtype =kCATransitionFromTop;//动画方向
    //3.把动画对象添加到导航控制器的layer上
    [self.navigationController.view.layer addAnimation:tran forKey:nil];
    
    
}






@end
