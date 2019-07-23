//
//  VideoTableViewCell.h
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AItem.h"
@interface VideoTableViewCell : UITableViewCell

//下一个视图的数据
@property(nonatomic)AItem *item;

//视频初始图
@property(nonatomic,retain)NSString *videoImageUrl;

//视频状态
@property(nonatomic)BOOL isPlay;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberComment;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UIImageView *aImageVIew;
-(void)stopVideo;

@end
