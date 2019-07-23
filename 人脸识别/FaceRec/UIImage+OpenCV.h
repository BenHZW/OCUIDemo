//
//  UIImage+OpenCV.h
//  opencvtest
//
//

#import <UIKit/UIKit.h>

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

//OpenCV 转 UIImage 类别
@interface UIImage (OpenCV)

+ (UIImage *)imageFromCVMat:(cv::Mat)mat;

- (cv::Mat)cvMatRepresentationColor;
- (cv::Mat)cvMatRepresentationGray;

@end
