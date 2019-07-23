//
//  UIImage+Scale.h
//  HZWScrollViewDemo
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

//sourceImage为：传入的UIImage defineWidth为缩放需要的宽度
+ (UIImage *)imageWithCompressForWidth:(UIImage*)sourceImage targetWidth:(CGFloat)defineWidth;


@end
