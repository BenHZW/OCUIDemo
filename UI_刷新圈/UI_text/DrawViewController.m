//
//  DrawViewController.m
//  UI_text
//
//  Created by apple on 15/11/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
@interface DrawViewController ()
{

    IBOutlet DrawView *_drawView;

    __weak IBOutlet UISlider *_slider;
}
@end

@implementation DrawViewController
#pragma mark 调用

- (IBAction)chaged:(id)sender {
    _drawView.value = _slider.value;
//        [_drawView setNeedsDisplay];
    
    NSLog(@"%f",_slider.value);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   CGFloat a =  _slider.value;
    _slider.maximumValue = 1;
    
    _slider.minimumValue = 0;
    
    
    _drawView.value = _slider.value;
//    NSString * b = [NSString stringWithFormat:@"%f",a];
    
    
//    [_drawView setValue: b forKey:@"value"];
    
    

    
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
