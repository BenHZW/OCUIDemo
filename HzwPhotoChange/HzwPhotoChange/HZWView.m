//
//  HZWView.m
//  HzwPhotoChange
//
//  Created by Gemll on 16/2/16.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "HZWView.h"

@implementation HZWView

- (instancetype)init
{
    return [[NSBundle mainBundle]loadNibNamed:@"HZWCell" owner:self options:nil].firstObject;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击图片呈现在大view上
    [self.delegate returnImage:self.myImageView.image];


}

@end
