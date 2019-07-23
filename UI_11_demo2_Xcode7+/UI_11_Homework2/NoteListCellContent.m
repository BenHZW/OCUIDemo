//
//  NoteListCellContent.m
//  备忘录
//
//  Created by CJJMac on 15-1-3.
//  Copyright (c) 2015年 fghf. All rights reserved.
//

#import "NoteListCellContent.h"

#define dateStringKey @"dateString"
#define abstractKey @"abstract"


@implementation NoteListCellContent

#pragma mark - 归档反归档协议方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        _dateString = [aDecoder decodeObjectForKey:dateStringKey];
        _abstract = [aDecoder decodeObjectForKey:abstractKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dateString forKey:dateStringKey];
    [aCoder encodeObject:self.abstract forKey:abstractKey];
}

@end
