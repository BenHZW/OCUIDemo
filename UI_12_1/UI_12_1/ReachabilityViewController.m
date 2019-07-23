//
//  ReachabilityViewController.m
//  
//
//  Created by apple on 15/10/14.
//
//

#import "ReachabilityViewController.h"
#import "Reachability.h"

@interface ReachabilityViewController ()
{


    __weak IBOutlet UILabel *_label;
    
   
    Reachability *_reachability;
   
}
@end




@implementation ReachabilityViewController


//检查网络状态
- (IBAction)checkNetworkStatus:(id)sender
{
    
    //调用设置label的方法
    [self setLabelTextByReachability:_reachability];
    
   
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
  //初始化reachability对象
    _reachability = [Reachability reachabilityForInternetConnection];
    
    
    //为了随时对网络状态做出反应，可以监听来自reachability的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
   [_reachability startNotifier];
    
     [self setLabelTextByReachability: _reachability];
    
    
}

#pragma mark - 收到网络状态变化通知的方法
-(void)reachabilityChanged:(NSNotification*)notification
{
    //通知的发送者
    Reachability *rb = notification.object;
    
  //设置标签文本
    [self setLabelTextByReachability:rb];
    
    

}



-(void)dealloc
{

    //停止发送通知
    [_reachability stopNotifier];
    
    //移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kReachabilityChangedNotification object:nil];
 
}





#pragma mark - 封装一个方法，根据一个reachability对象设置label的文字
-(void)setLabelTextByReachability:(Reachability*)reachability
{
  //声明一个label上的文字
    NSString *statusText;
    
    //判断reachability的连通状态，这个状态来自于它的枚举属性
    
    switch (reachability.currentReachabilityStatus) {
        case NotReachable:
            statusText = @"无网络";
         
            break;
         
         case ReachableViaWiFi:
        
           statusText = @"WiFi";
        
            break;
            
            
         case ReachableViaWWAN:
            statusText = @"移动网络";
            break;
            
            
        default:
            break;
    }
    
    _label.text = statusText;

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
