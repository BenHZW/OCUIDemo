//
//  FaceRecognizer.h
//  opencvtest
//
//


#import <UIKit/UIKit.h>

@interface FJFaceRecognizer : NSObject

//获取脸部识别数据
+ (FJFaceRecognizer *)faceRecognizerWithFile:(NSString *)path;

//序列号数据
- (BOOL)serializeFaceRecognizerParamatersToFile:(NSString *)path;

//识别结果预测
- (NSString *)predict:(UIImage*)img confidence:(double *)confidence;

//更新脸部的名称
- (void)updateWithFace:(UIImage *)img name:(NSString *)name;

//脸部名称的数组
- (NSArray *)labels;


@end
