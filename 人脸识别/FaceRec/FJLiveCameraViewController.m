//
//  ViewController.m
//  opencvtest
//
//

#import "FJLiveCameraViewController.h"
#import "FJFaceDetector.h"
#import "FJFaceRecognitionViewController.h"
@interface FJLiveCameraViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;

//脸部识别器
@property (nonatomic, strong) FJFaceDetector *faceDetector;

//手势识别器
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation FJLiveCameraViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化
    self.faceDetector = [[FJFaceDetector alloc] initWithCameraView:_cameraView scale:2.0];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.faceDetector startCapture];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.faceDetector stopCapture];
}

//点击识别的矩形
- (void)handleTap:(UITapGestureRecognizer *)tapGesture
{
    NSArray *detectedFaces = [self.faceDetector.detectedFaces copy];
    CGSize windowSize = self.view.bounds.size;
    for (NSValue *val in detectedFaces)
    {
        CGRect faceRect = [val CGRectValue];
        
        CGPoint tapPoint = [tapGesture locationInView:nil];
        //scale tap point to 0.0 to 1.0
        CGPoint scaledPoint = CGPointMake(tapPoint.x/windowSize.width, tapPoint.y/windowSize.height);
        if(CGRectContainsPoint(faceRect, scaledPoint)){
            NSLog(@"tapped on face: %@", NSStringFromCGRect(faceRect));
            UIImage *img = [self.faceDetector faceWithIndex:[detectedFaces indexOfObject:val]];
            [self performSegueWithIdentifier:@"RecognizeFace" sender:img];
        }
        else {
            NSLog(@"tapped on no face");
        }
    }
}

//跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"RecognizeFace"]) {
        NSAssert([sender isKindOfClass:[UIImage class]],@"RecognizeFace segue MUST be sent with an image");
        FJFaceRecognitionViewController *frvc = segue.destinationViewController;
        frvc.inputImage = sender;

    }
}


@end
