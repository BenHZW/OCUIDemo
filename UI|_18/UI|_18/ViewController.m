//
//  ViewController.m
//  UI|_18
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;

@property (weak, nonatomic) IBOutlet UITextField *portTextField;

@property (weak, nonatomic) IBOutlet UISwitch *connectSwitch;

@property (weak, nonatomic) IBOutlet UITextField *number1TextField;

@property (weak, nonatomic) IBOutlet UITextField *number2TextField;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
//客户端的socket对象

@property(strong,nonatomic) GCDAsyncSocket *clientSocket;




@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化socket对象
    //delegateQueue表示回调代理方法是在哪个线程队列中进行
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    
}


#pragma mark - 连接通断开关
- (IBAction)connectOrDisconnect:(UISwitch *)sender
{
    
    if (sender.isOn)
    {
        
        
        //开始连接
        
        NSError *err = nil;
      if ( ![self.clientSocket connectToHost:self.ipTextField.text onPort:self.portTextField.text.intValue withTimeout:20 error:&err])
      {
      
          NSLog(@"Could not connect, err:%@ ",err);
          [sender setOn:NO animated:YES];
      
      }
        
    
    }
    else
    {
       //断开连接
        [self.clientSocket disconnect];
        
    
    }
}


#pragma mark - 发送消息
- (IBAction)sendNumbers
{
    //发送的数据的格式要按照服务器的要求而定
    
    //比如这个服务器要求数据格式是连续2个int共8个字节
    
    int integers[2];
    
    integers[0] = self.number1TextField.text.intValue;
    
    integers[1] = self.number2TextField.text.intValue;
    
   //打包成NSData对象
    NSData * numberData = [NSData dataWithBytes:integers length:sizeof(integers)];
    
    //写入socket
    //tag值用于区分每次的写入操作
    [self.clientSocket writeData:numberData withTimeout:20 tag:0];
    
    
    
}

#pragma mark - 成功写入socket时
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    NSLog(@"Socket wrote successfully!");
    //从socket中读取数据
    //这个操作会导致子线程阻塞
    //参数②:存放接受的数据和的容器
    //参数③:从全部数据的第几个字节开始读取
    //参数④:区分每次的读取操作
     [self.clientSocket readDataWithTimeout:20 buffer:[NSMutableData new] bufferOffset:0 tag:0];

}

#pragma mark - 读取socket完成
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
   //读取回来的数据格式由服务器定义
    
    //比如此服务器发回来的数据是一个4字节的int
    
    int sum;
    [data getBytes:&sum length:sizeof(sum)];
    
    NSLog(@"sum  = %d",sum);
    

}

#pragma mark - socket成功连接到服务器时
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"Connected successfully! Now Please send numbers.");
    
    self.sendButton.enabled = YES;
    
    
   

}

#pragma mark - socket连接断开时
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"Disconnected with err :%@",err);
    
    self.sendButton.enabled = NO;
    
    [self.connectSwitch setOn:NO animated:YES];
   
   

}

@end
