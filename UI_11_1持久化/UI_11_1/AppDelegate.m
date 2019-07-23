//
//  AppDelegate.m
//  UI_11_1
//
//  Created by Ibokan_Teacher on 15/10/8.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //1.应用程序资源路径
    //例如获取这个图片的路径
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"aButton" ofType:@"png"];
    NSLog(@"path1: %@", path1);
    
    //资源路径下的文件只读不可写
    
    
    //2.Documents路径
    //建议存储文档性质的数据，可读可写
    
    //2.1.获得含有Documents路径的一个数组
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //2.2.这个数组里面只有一个对象，那就是Documents的路径
    NSString *path2 = paths.firstObject;
    
    NSLog(@"path2: %@", path2);
    
    
    
    //3.获取Library路径
    //建议存储与程序配置设置有关的数据
    NSString *path3 = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    
    NSLog(@"path3: %@", path3);
    
    
    
    //4.获取tmp路径
    //建议读写临时存放的文件数据，这些数据在个人文件备份时不会被备份
    NSString *path4 = NSTemporaryDirectory();
    NSLog(@"path4: %@", path4);
    
    
    
    
    
    return YES;
}

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
