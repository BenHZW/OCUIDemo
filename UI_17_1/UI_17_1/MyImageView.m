//
//  MyImageView.m
//  UI_17_1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    [self.image drawInRect:rect];
    [self.image drawInRect:rect blendMode:kCGBlendModeNormal alpha:0.8];
    
    
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setNeedsDisplay];
}

#pragma mark - 添加对image属性的观察
-(void)awakeFromNib
{

    [self addObserver:self forKeyPath:@"image" options:0 context:NULL];

}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"image"];
}





@end
