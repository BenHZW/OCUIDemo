//
//  AppDelegate.h
//  UI_11_3
//
//  Created by Ibokan_Teacher on 15/10/10.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//托管上下文，用于app和数据库之间的交流
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//表示数据库的数据模型
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

//负责掌管数据库的数据存储
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;//保存上下文，通常在操作完成之后调用
- (NSURL *)applicationDocumentsDirectory;


@end










