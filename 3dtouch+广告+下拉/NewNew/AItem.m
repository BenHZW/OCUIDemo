//
//  AItem.m
//  NewsData
//
//  Created by 3024 on 15/11/16.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import "AItem.h"

@implementation AItem

+(instancetype)aItemWithNewsid:(NSInteger)newsId title:(NSString *)title content:(NSString *)content categoryid:(NSInteger)categoryid authorid:(NSInteger)authorid publishtime:(NSString *)publishtime
{
    AItem *item = [self new];
    item.newsId = newsId;
    item.title = title;
    item.content = content;
    item.categoryid = categoryid;
    item.authorid = authorid;
    item.publishtime = publishtime;
    return item;
}

@end
