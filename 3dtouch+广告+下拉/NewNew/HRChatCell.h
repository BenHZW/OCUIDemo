//
//  HRChatCell.h
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"
#define RChatFontSize 14.0f
#define RCellHeight 70

@class CommentItem;
@interface HRChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
- (void)bindMessage:(CommentItem *)message;
@property(nonatomic)CommentItem *item;
@end
