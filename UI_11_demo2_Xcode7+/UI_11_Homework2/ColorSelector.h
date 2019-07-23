//
//  ColorSelector.h
//  备忘录
//
//  Created by CJJMac on 15-1-11.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark
#pragma mark - 颜色选择器
#pragma mark - 颜色选择器代理方法
@class ColorSelector;
@protocol ColorSelectorDelegate<NSObject>

- (void)colorSelector:(ColorSelector*)colorSelector selectedColor:(UIColor*)color;

@end


#pragma mark - 颜色选择器主体
@interface ColorSelector:UIView

@property(nonatomic, weak)id<ColorSelectorDelegate>delegate;

- (id)initWithOrigin:(CGPoint)origin;

#pragma mark -这个按钮提供给外部使用
//点击这个按钮，弹出选择面板
@property(nonatomic, strong, readonly)UIBarButtonItem *showColorSelectorButton;

@end
