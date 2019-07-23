//
//  DragViewController.m
//  UI_14_3
//
//  Created by apple on 15/10/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DragViewController.h"

@interface DragViewController ()
{


    __weak IBOutlet UIView *_redView;


}
@end

@implementation DragViewController

#pragma mark - 拖动手势响应方法


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)panned:(UIPanGestureRecognizer*)sender
{
    
    //1.获取位移量
    CGPoint offset  = [sender translationInView:self.view];
    NSLog(@"offset:%@",NSStringFromCGPoint(offset));
    
    
    //2.让redView的中心发生相同的偏移
    CGPoint redViewCenter = _redView.center;
    
    redViewCenter.x += offset.x;
    redViewCenter.y += offset.y;
    
   _redView.center = redViewCenter;
    //重置手势偏移量
    [sender setTranslation:CGPointZero inView:self.view];
    
}




@end
