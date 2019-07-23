//
//  ImageDownloadViewController.m
//  
//
//  Created by apple on 15/10/14.
//
//

#import "ImageDownloadViewController.h"

@interface ImageDownloadViewController ()
{


    __weak IBOutlet UIImageView *_imageView;
    
    
    __weak IBOutlet UIProgressView *_progressView;
    
    //要下载的总字节数
    long long _totalBytes;
    
    //记录已下载的字节数
    long long _downloadedBytes;
    
    //数据容器
    NSMutableData  * _mutableImgData;
}



@end

@implementation ImageDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - 同步请求

#pragma mark - NSURLConnection的代理方法


//刚开始收到服务器响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"接收到响应");
    
    _mutableImgData = [NSMutableData new];
    
    _totalBytes = response.expectedContentLength;
    
    
    
}



-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到部分数据");
    
    //参数data包含了数据的片段，将它加入到数据容器中
    [_mutableImgData appendData:data];
    
    //计算百分比
    _downloadedBytes = _mutableImgData.length;
    
    float percent = (long double)_downloadedBytes / _totalBytes;
    
   _progressView.progress = percent;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"数据接收完毕");
    //将数据转为图片，显示出来
    
    UIImage *img = [[UIImage alloc]initWithData:_mutableImgData];
    _imageView.image =img;
    
    
}






- (IBAction)asynRequest:(id)sender
{
    
    //1.创建URL对象
    NSURL *imgUrl = [NSURL URLWithString:@"http://image181-c.poco.cn/mypoco/myphoto/20110528/16/55895240201105281659233879391734722_008.jpg"];
    
    //2.创建请求对象
//    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:imgUrl];
  
    //其实创建请求对象时还可以指定更多参数
    //参数②：缓存策略
    //参数③：超时秒数
    
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:imgUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    
    
   //3.发送异步请求
    //同时设定代理，剩下的事情交给代理解决
    //这个方法的返回值是一个连接NSURLConnection对象
    [NSURLConnection connectionWithRequest:imgRequest delegate:self];
    
    
    
    
    
}

- (IBAction)synRequest:(id)sender
{
    
    //1.创建URL对象
    NSURL * imgUrl = [NSURL URLWithString: @"http://image181-c.poco.cn/mypoco/myphoto/20110528/16/55895240201105281659233879391734722_008.jpg"];
  
    /*
    //2.创建请求对象
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:imgUrl];
    
    //3.创建连接的同时发送同步请求
    //这个方法的返回值是一个data，就是服务器返回的数据
  NSData *imgData  = [NSURLConnection sendSynchronousRequest:imgRequest returningResponse:nil error:nil];
   */
   //EX.很多系统提供的类都自带同步请求的方法，通过一个URL直接初始化获得数据
    NSData *imgData = [NSData dataWithContentsOfURL:imgUrl];
    
#pragma mark - 异步请求按钮

    
    //4.通过data生成图片，并显示
    UIImage *img = [[UIImage alloc] initWithData:imgData];
    _imageView.image = img;
    
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
