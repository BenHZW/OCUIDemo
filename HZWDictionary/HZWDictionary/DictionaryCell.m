//
//  DictionaryCell.m
//  HZWDictionary
//
//  Created by Gemll on 16/4/12.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "DictionaryCell.h"

@implementation DictionaryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.dicLabel = [[UILabel alloc] init];
        [self addSubview:self.dicLabel];
        [self.dicLabel mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.mas_equalTo(self.mas_left).with.offset(10);
            make.width.mas_equalTo(@100);
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-10);
            make.top.mas_equalTo(self.mas_top).with.offset(10);
        }];
        
        self.showLabel = [[UILabel alloc] init];
        self.showLabel.numberOfLines = 3;
        self.showLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.showLabel];
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.left.mas_equalTo(self.dicLabel.mas_right).with.offset(10);
             make.height.mas_equalTo(self.dicLabel.mas_height);
             make.right.mas_equalTo(self.mas_right).with.offset(-10);
             make.top.mas_equalTo(self.dicLabel.mas_top);
         }];
    }
    return self;
}

@end
