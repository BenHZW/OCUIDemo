//
//  DataSouceDelegate.m
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import "DataSouceDelegate.h"
@interface DataSouceDelegate ()
{
    NSData *_data;
}
@end

@implementation DataSouceDelegate

-(NSData *)getData:(NSString *)url
{

//    //创建会话对象
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
//    
//    NSURLSessionDownloadTask *downloadingTask;
//    
//    //根据片段建立请求
//    //从会话对象创建任务对象
//
//        NSURL *imageUrl = [NSURL URLWithString:url];
//        
//        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageUrl];
//        
//        downloadingTask = [downloadSession downloadTaskWithRequest:imageRequest];
//
//    [downloadingTask resume];
    
        
    _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    if (_data != nil) {
        return _data;
    }
    return nil;
    
    
   
    
    
}


////下载完成
//- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
//{
//     _data = [NSData dataWithContentsOfURL:location];
//    
//}
@end
