//
//  AppDelegate.m
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//外部3dtouch
-(void)application:(UIApplication*)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    
    if([shortcutItem.type isEqualToString:@"-11.UITouchText.share"]){
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        //设置当前的VC 为rootVC
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    }
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //向微信注册
    NSLog(@"%d",[WXApi registerApp:@"wxa9de09151d988985" withDescription:@"news domo"]);
    
    NSNumber *number = [NSNumber numberWithBool:NO];
    
    [[NSUserDefaults standardUserDefaults] setValue:number forKeyPath:@"setOrCancelNightMode" ];
    
    
    
    return YES;
}

//重写AppDelegate的handleOpenURL和openURL方法：
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)reqonReq
{
    NSLog(@"req");
}//是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void) onResp:(BaseResp*)resp
{
    NSLog(@"resp");
}//如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}



@end
