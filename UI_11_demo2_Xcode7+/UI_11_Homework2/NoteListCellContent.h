//
//  NoteListCellContent.h
//  备忘录
//
//  Created by CJJMac on 15-1-3.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import <Foundation/Foundation.h>

//这个模型记录了笔记的日期和摘要

//实现NSCoding协议，以便归档和反归档
@interface NoteListCellContent : NSObject<NSCoding>


@property(nonatomic, copy)NSString *dateString;

@property(nonatomic, copy)NSString *abstract;

@end
