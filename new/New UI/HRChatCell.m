//
//  HRChatCell.m
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import "HRChatCell.h"
#import "CommentItem.h"

#define RMarginSize 5
#define RBtnX 70
#define RIconSide 50

@implementation HRChatCell

- (void)awakeFromNib
{
    _msgButton.titleLabel.numberOfLines = 0;
    _msgButton.titleLabel.font = [UIFont systemFontOfSize:RChatFontSize];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = _msgButton.frame;
    rect.size.height = self.bounds.size.height - 2*RMarginSize;
    _msgButton.frame = rect;
}

- (void)bindMessage:(CommentItem *)message
{
    UIImage *headerImage;
    UIImage *normalImage;
    UIImage *highlightedImage;
    
    CGRect iconRect = _headerView.frame;
    CGRect btnRect = _msgButton.frame;
    
    UIEdgeInsets insets;
    
    if (message.userId == 66)
    {
        headerImage = [UIImage imageNamed:@"me"];
        normalImage = [UIImage imageNamed:@"mychat_normal"];
        highlightedImage = [UIImage imageNamed:@"mychat_focused"];
        
        iconRect.origin.x = RMarginSize;
        btnRect.origin.x = RBtnX;
        
        insets = UIEdgeInsetsMake(0, 20, 0, 30);
    }
    else
    {
        headerImage = [UIImage imageNamed:@"other"];
        normalImage = [UIImage imageNamed:@"other_normal"];
        highlightedImage = [UIImage imageNamed:@"other_focused"];
        
        iconRect.origin.x = self.bounds.size.width - RMarginSize - RIconSide;
        btnRect.origin.x = self.bounds.size.width - iconRect.origin.x - RMarginSize;
        
        insets = UIEdgeInsetsMake(0, 30, 0, 30);
    }
    _headerView.frame = iconRect;
    _headerView.image = headerImage;
    
    normalImage = [normalImage stretchableImageWithLeftCapWidth:normalImage.size.width*0.5 topCapHeight:normalImage.size.height*0.6];
    highlightedImage = [highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width*0.5 topCapHeight:highlightedImage.size.height*0.6];
    
    [_msgButton setContentEdgeInsets:insets];
    _msgButton.frame = btnRect;
    [_msgButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_msgButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    NSMutableString *str = [NSMutableString stringWithFormat:@"%ld:%@ \nsendin:[%@]",message.userId,message.comment,message.commenttime];
    [_msgButton setTitle:str forState:UIControlStateNormal];
    self.item = message;
}

@end
