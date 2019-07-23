//
//  CVCameraProvider.h
//  opencvtest
//
//

#import <opencv2/highgui/cap_ios.h>
#import <Foundation/Foundation.h>

@interface FJFaceDetector : NSObject <CvVideoCameraDelegate>

@property (nonatomic, strong) CvVideoCamera* videoCamera;

//初始化
- (instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale;

//开始识别
- (void)startCapture;

//关闭识别
- (void)stopCapture;

//检测脸部返回数组
- (NSArray *)detectedFaces;

//脸部检测，输入指定域返回图像
- (UIImage *)faceWithIndex:(NSInteger)idx;
@end
