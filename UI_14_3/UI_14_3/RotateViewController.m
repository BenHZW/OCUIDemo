//
//  RotateViewController.m
//  UI_14_3
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()
{


    __weak IBOutlet UIImageView *_imageView;
  
    CGAffineTransform _imageViewTransform;
}
@end

@implementation RotateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //旋转手势识别器
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotated:)];
    [self.view addGestureRecognizer:rotate];
    //记录最开始的imageViewTransform
    _imageViewTransform = _imageView.transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 旋转手势响应方法
-(void)rotated:(UIRotationGestureRecognizer*)rotate
{

 //1.获取旋转弧度
    CGFloat rad = rotate.rotation;
    NSLog(@"rad:%f π",rad / M_PI);
    
 //2.利用仿射变换旋转图片
    _imageView.transform = CGAffineTransformRotate(_imageViewTransform, rad);
    
    //3.如果旋转手势结束了
    if (rotate.state == UIGestureRecognizerStateEnded) {
        //更新记录的transform,以备下次旋转计算使用
        _imageViewTransform = _imageView.transform;
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
