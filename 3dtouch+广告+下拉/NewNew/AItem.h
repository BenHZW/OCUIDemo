//
//  AItem.h
//  NewsData
//
//  Created by 3024 on 15/11/16.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AItem : NSObject

@property(nonatomic)NSInteger newsId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic)NSInteger categoryid;
@property(nonatomic)NSInteger authorid;
@property(nonatomic,copy)NSString *publishtime;

//可能为空的属性
@property(nonatomic,retain)NSArray *images;
@property(nonatomic,retain)NSArray *infos;
@property(nonatomic,copy)NSString *videourl;
+(instancetype)aItemWithNewsid:(NSInteger)newsId title:(NSString*)title content:(NSString*)content categoryid:(NSInteger)categoryid authorid:(NSInteger)authorid publishtime:(NSString*)publishtime;
@end
