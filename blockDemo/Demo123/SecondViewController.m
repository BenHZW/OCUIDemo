//
//  SecondViewController.m
//  Demo123
//
//  Created by ANAN on 16/1/19.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.displayL setText:self.contentStr];
    
    self.Callback(self.myTextField.text,self.myTextField1.text);
    
}



@end
