//
//  ButtonHeaderView.h
//  表视图折叠
//
//  Created by Ibokan_Teacher on 15/9/23.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonHeaderViewDelegate;

//创建一个分区头控件的子类，在上面添加按钮
@interface ButtonHeaderView : UITableViewHeaderFooterView


//不建议直接暴露分区头上的按钮
//@property(nonatomic,retain,readonly)UIButton *headerButton;


//按钮标题属性
@property(nonatomic, copy)NSString *buttonTitle;

//代理
@property(nonatomic, assign)id<ButtonHeaderViewDelegate> delegate;

@end


//分区头本身不能addTarget，但可以通过代理的形式将点击的时刻传给代理人
@protocol ButtonHeaderViewDelegate <NSObject>

@optional
- (void)buttonHeaderViewDidPress:(ButtonHeaderView*)buttonHeaderView;

@end








