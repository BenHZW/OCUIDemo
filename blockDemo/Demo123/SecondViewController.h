//
//  SecondViewController.h
//  Demo123
//
//  Created by ANAN on 16/1/19.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *displayL;
@property (weak, nonatomic) IBOutlet UITextField *myTextField1;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;


@property (nonatomic, copy) NSString *contentStr;

@property (nonatomic, copy) void(^Callback)(NSString* str1 , NSString* str2);


@end
