//
//  CommentItem.h
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject
@property(nonatomic)NSInteger commentId;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic)NSString *commenttime;
@property(nonatomic)NSInteger userId;
@property(nonatomic)NSInteger newsId;
+(instancetype)commentItemWithCommentId:(NSInteger)commentId Comment:(NSString*)comment commenttime:(NSString*)commenttime userId:(NSInteger)userId newsId:(NSInteger)newsId;
@end
