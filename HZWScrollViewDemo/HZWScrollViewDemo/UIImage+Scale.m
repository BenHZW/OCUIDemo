//
//  UIImage+Scale.m
//  HZWScrollViewDemo
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

//按指定宽度比例缩放
+ (UIImage *)imageWithCompressForWidth:(UIImage*)sourceImage targetWidth:(CGFloat)defineWidth
{
    UIImage *newImage;
    
    //UIImage为传入的UIimage的size
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //缩进后的宽度和高度
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeigh = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeigh);
    
    //缩进的比例
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeigh;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize,size) == NO)
    {
        //宽度缩进因子
        CGFloat widthFactor = targetWidth / width;
        
        //高度缩进因子
        CGFloat heightFactor = targetHeigh / height;
        
        //判断宽高比例，取最大的赋值给scaleFactor
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
        }
        else
        {
            scaleFactor = heightFactor;
            
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeigh - scaledHeight) * 0.5;
        }
        else if(widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (newImage == nil) {
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}



@end

