//
//  ImageViewController.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    
    __weak IBOutlet UIImageView *_imageView;
}
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.常用的两种读取资源图片的方法
    //用imageNamed方法
    UIImage *img1 = [UIImage imageNamed:@"aButton.png"];
    
    //通过bundle获得
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"aButton" ofType:@"png"];
    UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    
    _imageView.image = img1;
    
    //3.把图片写入存储器
    //3.1.将图片以它本身的格式数据存储起来
    NSData *img2Data = UIImagePNGRepresentation(img2);
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *img2Path = [documentsPath stringByAppendingPathComponent:@"img2.png"];
    NSLog(@"img2Path: %@", img2Path);
    
    [img2Data writeToFile:img2Path atomically:YES];
    
    
    //3.2.通过归档存储图片
    
    
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
