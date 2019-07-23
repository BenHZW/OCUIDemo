//
//  ImageViewController.h
//  New UI
//
//  Created by Ibokan on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate>

//图片链接数组
@property(nonatomic, copy)NSArray *imageArray;

//图片介绍
@property(nonatomic, copy)NSArray *infoArray;

@property(nonatomic, copy)NSString *myTitle;

@property(nonatomic)NSInteger newsId;
@end
