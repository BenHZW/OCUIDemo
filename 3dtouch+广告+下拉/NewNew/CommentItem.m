//
//  CommentItem.m
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem
+(instancetype)commentItemWithCommentId:(NSInteger)commentId Comment:(NSString *)comment commenttime:(NSString *)commenttime userId:(NSInteger)userId newsId:(NSInteger)newsId{
    CommentItem *ci = [self new];
    ci.commentId = commentId;
    ci.comment = comment;
    ci.commenttime = commenttime;
    ci.userId = userId;
    ci.newsId = newsId;
    return ci;
}
@end
