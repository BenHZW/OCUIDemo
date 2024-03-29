//
//  UIView_extra.h
//  Woyoli
//
//  Created by jamie on 14-11-25.
//  Copyright (c) 2014年 Missionsky. All rights reserved.
//

#define vAlertTag    10086

#import <UIKit/UIKit.h>

@interface UIView (UIView)

@property (nonatomic, assign) CGFloat   x;
@property (nonatomic, assign) CGFloat   y;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, assign) CGFloat   centerX;
@property (nonatomic, assign) CGFloat   centerY;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

/**
 * @brief 移除此view上的所有子视图
 */
- (void)removeAllSubviews;


@end
