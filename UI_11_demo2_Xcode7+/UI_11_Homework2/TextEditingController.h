//
//  TextEditingController.h
//  备忘录
//
//  Created by Ibokan on 14-12-30.
//  Copyright (c) 2014年 fghf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FontSizeSelector.h"
#import "ColorSelector.h"

#pragma mark - 文本编辑器主体

@protocol TextEditingControllerDelegate;

@interface TextEditingController : UIViewController<FontSizeSelectorDelegate, ColorSelectorDelegate, UITextViewDelegate>

//一个带格式的字符串，用于传入显示
@property(nonatomic, copy)NSAttributedString *attrText;

//代理
@property(nonatomic, weak)id<TextEditingControllerDelegate>delegate;

//记录文件名
@property(nonatomic, copy)NSString *textFileName;


@end



#pragma mark - 文本编辑器代理方法
@class TextEditingController;
@protocol TextEditingControllerDelegate <NSObject>

@optional
- (void)textEditingControllerDidSaveEditing:(TextEditingController*)textEditingController;

- (void)textEditingControllerDidCancelEditing:(TextEditingController*)textEditingController;

@end



