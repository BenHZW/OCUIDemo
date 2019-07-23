//
//  VideoCell.h
//  NewNew
//
//  Created by gdm on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AItem.h"
#import "CustomMoviePlayerView.h"

@protocol MoviePlayDelegate <NSObject>

-(void)moviePlayDelegateFromCell:(id)sender;

@end

@interface VideoCell : UITableViewCell<CustomMoviePlayerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleBut;
@property(nonatomic)NSString* backImage;

//视频
@property (strong,nonatomic)  CustomMoviePlayerView *movieView;
@property (nonatomic,copy) NSString *urlStr;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (nonatomic, weak) id<MoviePlayDelegate> delegate;


//下一个视图的数据
@property(nonatomic)AItem *item;
@end
