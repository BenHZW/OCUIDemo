//
//  VideoCell.m
//  NewNew
//
//  Created by gdm on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    
    _movieView = [[CustomMoviePlayerView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,self.height-35)];
    _movieView.delegate = self;
    _movieView.backImage = self.backImage;
    _movieView.movieURL = _urlStr;
    _movieView.payButton.hidden = NO;
    
    
    [self addSubview:_movieView];
}
#pragma mark - deletage
-(void)playDelegate{
    if ([_delegate respondsToSelector:@selector(moviePlayDelegateFromCell:)]) {
        [_delegate moviePlayDelegateFromCell:self];
    }
}

@end
