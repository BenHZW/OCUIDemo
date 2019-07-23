//
//  AdView.h
//  UI_4_2
//
//  Created by Ibokan_Teacher on 15/9/14.
//  Copyright (c) 2015年 ios22. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdViewDelegate;


@interface AdView : UIView

@property(nonatomic, weak)id<AdViewDelegate> delegate;

@end


#pragma mark - 广告视图代理人的协议方法

@protocol AdViewDelegate <NSObject>

@optional//可选的

//决定按钮是否应该将广告条关闭的方法
- (BOOL)adViewShouldClose:(AdView*)adView;

//广告条关闭之后要执行的操作
- (void)adViewDidClose:(AdView*)adView;

@end








