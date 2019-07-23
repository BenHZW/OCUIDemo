//
//  FJFaceRecognitionViewController.m
//  opencvtest
//
//

#import "FJFaceRecognitionViewController.h"
#import "FJFaceRecognizer.h"

//这里是用了sb连接控件
@interface FJFaceRecognitionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *confidenceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inputImageView;

@property (nonatomic, strong) FJFaceRecognizer *faceModel;
@end

@implementation FJFaceRecognitionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _inputImageView.image = _inputImage;
    
    //获取脸部模型
    NSURL *modelURL = [self faceModelFileURL];
    self.faceModel = [FJFaceRecognizer faceRecognizerWithFile:[modelURL path]];
    
    double confidence;
    
    //初次使用记person次数为0
    if (_faceModel.labels.count == 0)
    {
        [_faceModel updateWithFace:_inputImage name:@"Person 1"];
    }

    NSString *name = [_faceModel predict:_inputImage confidence:&confidence];
    NSLog(@"-------%@--------\n",name);
    _nameLabel.text = name;
    _confidenceLabel.text = [@(confidence) stringValue];
    
    
}

//存储
- (NSURL *)faceModelFileURL
{
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSURL *modelURL = [documentsURL URLByAppendingPathComponent:@"face-model.xml"];
    return modelURL;
}

//点击正确的操作
- (IBAction)didTapCorrect:(id)sender
{
    [_faceModel updateWithFace:_inputImage name:_nameLabel.text];
    [_faceModel serializeFaceRecognizerParamatersToFile:[[self faceModelFileURL] path]];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//点击错误的操作
- (IBAction)didTapWrong:(id)sender
{
    NSString *name = [@"Person " stringByAppendingFormat:@"%lu", (unsigned long)_faceModel.labels.count];
    [_faceModel updateWithFace:_inputImage name:name];
    [_faceModel serializeFaceRecognizerParamatersToFile:[[self faceModelFileURL] path]];
    //返回跳转操作
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
