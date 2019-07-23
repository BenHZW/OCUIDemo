//
//  ViewController.m
//  UI_12_3
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    __weak IBOutlet UIProgressView *_progressView;
    
    
    __weak IBOutlet UIImageView *_imageView;

    
    //已下载的数据片段需要暂时保存起来，于是这里定义一个数据片段文件的路径
    NSString *_downloadingPath;
    
    //"下载任务"对象
    NSURLSessionDownloadTask *_downloadTask;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据片段的路径，后面要使用
    NSString * documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //文件名,扩展名随意
    _downloadingPath = [documentsPath stringByAppendingString:@"img.downloading"];
    
    //注意：iOS9之后默认需要使用https请求
    //如果实际中还用http请求，需要在...info.plist文件中加入一个字典名为NSAppTransportSecurity
    //然后在这个字典中加入一个键名为NSAllowsArbitraryLoads值为布尔型的YES
    
    
    
    
    
}


- (IBAction)startButtonPressed:(id)sender
{
    //尝试读取数据片段文件
    NSData * downloadingData = [[NSData alloc] initWithContentsOfFile:_downloadingPath];
    //如果数据片段不存在，则这个对象会是nil
    
    //Session（会话）的一般工作流程
    //1.创建配置对象
    NSURLSessionConfiguration *config =[NSURLSessionConfiguration defaultSessionConfiguration];
    
    //2.使用配置对象，创建会话对象
    //会话对象的作用是创建任务
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    //3.从会话对象创建任务对象
    //但是，根据数据片段的有无，创建的方式也有不同
    if (downloadingData == nil) {
        //3.1没有数据片段，需要重新下载
        
        //创建URL对象和请求对象
        NSURL *imgUrl =[NSURL URLWithString:@"http://image181-c.poco.cn/mypoco/myphoto/20110528/16/55895240201105281659233879391734722_008.jpg"];
        NSURLRequest *imgRequest =[NSURLRequest requestWithURL:imgUrl];
        
       //由用会话对象，根据请求对象，创建下载任务
        _downloadTask = [downloadSession downloadTaskWithRequest:imgRequest];
        
    }
    else
    {
     //3.2.有数据片段，就用这个数据片段创建任务对象
        _downloadTask = [downloadSession downloadTaskWithResumeData:downloadingData];
    
    }
    
    
    //4.开始/恢复下载任务
    [_downloadTask resume];
    
    
}

#pragma mark - 暂停按钮
- (IBAction)pauseButtonPressed:(id)sender
{
    
      //取消下载任务，并处理当前已下载的数据片段
     //注:任务对象一旦取消将不能继续执行，需要另外创建新的任务对象
    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        //从代码块的参数中获取已下载的数据片段
        //将这段数据县持久化
        
        [resumeData writeToFile:_downloadingPath atomically:YES];
        
        NSLog(@"downloadingPath:%@",_downloadingPath);
    }];
    
    
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



#pragma mark - 与下载任务有关的代理方法
//下载任务开始/恢复时
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"开始/恢复下载");
    //利用参数中的两个数据计算百分比
    float percent = (long double)fileOffset / expectedTotalBytes;
    NSLog(@"percent: %.2f%%",percent);
    
    //使用GCD回到主线程更新进度条显示
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress = percent;
    });

}

//每当下载到一部分数据时
-(void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{


    NSLog(@"接受到数据");
    
    //计算百分比
    float percent = (long double)totalBytesWritten / totalBytesExpectedToWrite;
    
    NSLog(@"percent:%.2f%%",percent);
    //使用GCD回到主线程更新进度条显示
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.progress = percent;
    });
   

    
    

}

//下载完成时（此方法必须实现）
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //到此,文件已经完整的下载了，它被保存在tmp文件夹内，其路径用参数location传入
    //location是一个表示本地路径的url
    NSLog(@"location:%@",location);
    
    //位于location的数据只能在这里读取，一旦本方法结束，这个文件将被自动删除
    //通过location加载这个数据
    NSData *imgData = [NSData dataWithContentsOfURL:location];
    
    //如果这个完整的数据需要持久化，应及时保存到其他路径
    
    //另外，别忘记删除刚才的数据片段
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:_downloadingPath error:nil];

    //本例仅将图片显示在界面上,不转存
    UIImage *img =[[UIImage alloc]initWithData:imgData];
    
    //使用GCD回到主线程更新图片显示
    dispatch_async(dispatch_get_main_queue(), ^{
       _imageView.image = img;
    });
   }



@end
