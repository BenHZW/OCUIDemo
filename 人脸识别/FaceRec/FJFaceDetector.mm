//
//  CVCameraProvider.mm
//  opencvtest
//
//

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif


#import "FJFaceDetector.h"
#import "UIImage+OpenCV.h"
using namespace cv;

@interface FJFaceDetector ()
{
    //openCV中人脸识别的控键
    CascadeClassifier _faceDetector;
    
    //选择mm文件，用来引入vector容器，支持c++，这里引用了openCV的sdk
    vector<cv::Rect> _faceRects;
    vector<cv::Mat> _faceImgs;
    
}

//显示长方形范围
@property (nonatomic, assign) CGFloat scale;


@end

@implementation FJFaceDetector

- (instancetype)initWithCameraView:(UIImageView *)view scale:(CGFloat)scale
{
    self = [super init];
    if (self)
    {
        //初始化照相机实例，并设置相关属性
        self.videoCamera = [[CvVideoCamera alloc] initWithParentView:view];
        self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
        self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
        self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
        self.videoCamera.defaultFPS = 30;
        self.videoCamera.grayscaleMode = NO;
        self.videoCamera.delegate = self;
        self.scale = scale;
        
        //设置存取路径
        NSString *faceCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2"
                                                                ofType:@"xml"];
        
        const CFIndex CASCADE_NAME_LEN = 2048;
        char *CASCADE_NAME = (char *) malloc(CASCADE_NAME_LEN);
        CFStringGetFileSystemRepresentation( (CFStringRef)faceCascadePath, CASCADE_NAME, CASCADE_NAME_LEN);
        
        _faceDetector.load(CASCADE_NAME);
        
        free(CASCADE_NAME);
        
//以下是眼睛眨眼识别
//        NSString *eyesCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_eye_tree_eyeglasses"
//                                                                    ofType:@"xml"];
//        
//        CFStringGetFileSystemRepresentation( (CFStringRef)eyesCascadePath, CASCADE_NAME, CASCADE_NAME_LEN);
//        
//        eyesDetector.load(CASCADE_NAME);
    }
    
    return self;
}


- (void)startCapture
{
    [self.videoCamera start];
}

- (void)stopCapture
{
    [self.videoCamera stop];
}

//储存检测到的脸部数据
- (NSArray *)detectedFaces
{
    //创造可变数组收集脸部识别点
    NSMutableArray *facesArray = [NSMutableArray array];
    for( vector<cv::Rect>::const_iterator r = _faceRects.begin(); r != _faceRects.end(); r++ )
    {
        CGRect faceRect = CGRectMake(_scale*r->x/480., _scale*r->y/640., _scale*r->width/480., _scale*r->height/640.);
        [facesArray addObject:[NSValue valueWithCGRect:faceRect]];
    }
    return facesArray;
}

- (UIImage *)faceWithIndex:(NSInteger)idx
{

    cv::Mat img = self->_faceImgs[idx];
    
    UIImage *ret = [UIImage imageFromCVMat:img];
    
    return ret;
}


//获取到脸部图片
- (void)processImage:(cv::Mat&)image
{
    // Do some OpenCV stuff with the image
    [self detectAndDrawFacesOn:image scale:_scale];
}

//检测脸部
- (void)detectAndDrawFacesOn:(Mat&) img scale:(double) scale
{
    int i = 0;
    double t = 0;
    
#pragma mark - 这里使用openCVsdk检测脸部方法
    const static Scalar colors[] =  { CV_RGB(0,0,255),
        CV_RGB(0,128,255),
        CV_RGB(0,255,255),
        CV_RGB(0,255,0),
        CV_RGB(255,128,0),
        CV_RGB(255,255,0),
        CV_RGB(255,0,0),
        CV_RGB(255,0,255)} ;
    Mat gray, smallImg( cvRound (img.rows/scale), cvRound(img.cols/scale), CV_8UC1 );
    
    cvtColor( img, gray, COLOR_BGR2GRAY );
    resize( gray, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
    equalizeHist( smallImg, smallImg );
    


    t = (double)cvGetTickCount();
    double scalingFactor = 1.1;
    int minRects = 2;
    cv::Size minSize(30,30);

    self->_faceDetector.detectMultiScale( smallImg, self->_faceRects,
                             scalingFactor, minRects, 0,
                             minSize );

    t = (double)cvGetTickCount() - t;
//    printf( "detection time = %g ms\n", t/((double)cvGetTickFrequency()*1000.) );
    vector<cv::Mat> faceImages;
    
    for( vector<cv::Rect>::const_iterator r = _faceRects.begin(); r != _faceRects.end(); r++, i++ )
    {
        cv::Mat smallImgROI;
        cv::Point center;
        Scalar color = colors[i%8];
        vector<cv::Rect> nestedObjects;
        rectangle(img,
                  cvPoint(cvRound(r->x*scale), cvRound(r->y*scale)),
                  cvPoint(cvRound((r->x + r->width-1)*scale), cvRound((r->y + r->height-1)*scale)),
                  color, 1, 8, 0);
        
        //eye detection is pretty low accuracy
//        if( self->eyesDetector.empty() )
//            continue;
//        
        smallImgROI = smallImg(*r);
        
        faceImages.push_back(smallImgROI.clone());
//
//        
//        
//        self->eyesDetector.detectMultiScale( smallImgROI, nestedObjects,
//                                       1.1, 2, 0,
//                                            cv::Size(5, 5) );
//        for( vector<cv::Rect>::const_iterator nr = nestedObjects.begin(); nr != nestedObjects.end(); nr++ )
//        {
//            center.x = cvRound((r->x + nr->x + nr->width*0.5)*scale);
//            center.y = cvRound((r->y + nr->y + nr->height*0.5)*scale);
//            int radius = cvRound((nr->width + nr->height)*0.25*scale);
//            circle( img, center, radius, color, 3, 8, 0 );
//        }


    }
   
    @synchronized(self)
    {
        self->_faceImgs = faceImages;
    }
    
}

@end
