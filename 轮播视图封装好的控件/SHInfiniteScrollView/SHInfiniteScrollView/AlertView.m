//
//  AlertView.m
//  8bitdo
//
//  Created by 8Bitdo_Dev on 16/4/21.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+(void)persendDialogBoxTitle:(NSString *)alertTitle message:(NSString *)message targer:(id)targer{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:NSLocalizedString(alertTitle, nil) message:NSLocalizedString(message, nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert presentedViewController];
    }];
    [alert addAction:action];
    [targer presentViewController:alert animated:YES completion:nil];
}

@end
