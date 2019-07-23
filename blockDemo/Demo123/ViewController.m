//
//  ViewController.m
//  Demo123
//
//  Created by ANAN on 16/1/19.
//  Copyright © 2016年 ANAN. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)gotoSecondVC:(UIButton *)sender {
    
    SecondViewController* second = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    second.contentStr = self.myTextField.text;
    
    second.Callback = ^(NSString* string1,NSString* string2){
        NSString* string = [NSString stringWithFormat:@"%@ -- %@",string1,string2];
        [self.displayL setText:string];
    };
    
    [self.navigationController pushViewController:second animated:YES];
}

@end
