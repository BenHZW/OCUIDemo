//
//  ColorPalette.h
//  UI-4-Homework
//
//  Created by CJJMac on 15-5-12.
//  Copyright (c) 2015年 CJJMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPaletteDelegate;

@interface ColorPalette : UIView

//通过一个获取或设置调色板的调出颜色
@property(nonatomic)UIColor *color;


//一个代理，当调色板颜色发生变化时，调用代理人得代理方法
@property(nonatomic, assign)id<ColorPaletteDelegate> delegate;

@end


@protocol ColorPaletteDelegate <NSObject>

@optional
//表示调色发生变化的代理方法
- (void)colorPaletteColorDidChange:(ColorPalette*)colorPalette;

@end




