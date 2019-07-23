//
//  MyLabel.m
//  UI_17_1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //画文字
    
    //1.构建文字属性字典
    NSMutableDictionary *attrDict = [NSMutableDictionary new];
    
    //把两个属性加入到字典中
    if(self.textColor != nil)
    {
        attrDict[NSForegroundColorAttributeName] = self.textColor;
    
    }
    if (self.font != nil) {
        attrDict[NSFontAttributeName] = self.font;
    }
    
    //2.把文字画在一个rect内
    [self.text drawInRect:rect withAttributes:attrDict];
    
    
    
    
}

#pragma mark - 从storyboard或xib加载时初始化
-(void)awakeFromNib
{

    [super awakeFromNib];
    
    //通过KVO监听三个属性的变化
    [self addObserver:self forKeyPath:@"text" options:0 context:NULL];
    [self addObserver:self forKeyPath:@"textColor" options:0 context:NULL];
    [self addObserver:self forKeyPath:@"font" options:0 context:NULL];
    
    
  
}

#pragma mark - 监听到属性改变后重新绘图
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
  //调用此方法,会间接调用drawRect方法
    [self setNeedsDisplay];


}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"text"];
    [self removeObserver:self forKeyPath:@"textColor"];
    [self removeObserver:self forKeyPath:@"font"];
    
}


@end
