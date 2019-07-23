//
//  AppDelegate.m
//  UI_6_5
//
//  Created by Ibokan_Teacher on 15/9/17.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //1.实验：创建若干个视图控制器，并放入数组中
    NSMutableArray *controllers = [NSMutableArray new];
    
    
    //1.1.四五个以上
    /*
    for (NSInteger i = 0; i < 10; ++i)
    {
        UIViewController *vc = [UIViewController new];
        
        //设置视图控制器的标题，它会被显示在标签按钮上
        vc.title = [NSString stringWithFormat:@"number%ld", i];
        
        [controllers addObject:vc];
    }
    */
    
    
    //1.2.用1st、2nd、3rd
    FirstViewController *first = [FirstViewController new];
    [controllers addObject:first];
    
    SecondViewController *second = [SecondViewController new];
    [controllers addObject:second];
    
    
    [controllers addObject:[ThirdViewController new]];
    
    
    
    
    //2.创建标签栏视图控制器
    MyTabBarViewController *tabBarController = [MyTabBarViewController new];
    
    //设定它要管理的众多视图控制器
    tabBarController.viewControllers = controllers;
    
    
    //标签栏视图控制器作为根视图控制器
    self.window.rootViewController = tabBarController;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
