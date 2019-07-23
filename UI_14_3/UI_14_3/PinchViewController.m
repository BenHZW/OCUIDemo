//
//  PinchViewController.m
//  UI_14_3
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PinchViewController.h"

@interface PinchViewController ()
{

    __weak IBOutlet UIImageView *_imageView;

}
@end

@implementation PinchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinching:)];
    
    [self.view addGestureRecognizer:pinch];
    
}

#pragma mark - 捏合手势响应方法
-(void)pinching:(UIPinchGestureRecognizer*)pinch
{
   //1.获取捏合缩放比例
    CGFloat scale = pinch.scale;
    NSLog(@"scale:%f",scale);

    //2.根据比例调整图片大小
    _imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
