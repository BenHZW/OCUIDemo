//
//  AlertView.h
//  8bitdo
//
//  Created by 8Bitdo_Dev on 16/4/21.
//  Copyright © 2016年 8Bitdo_Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : NSObject
+(void)persendDialogBoxTitle:(NSString *)alertTitle message:(NSString *)message targer:(id)targer;
@end
