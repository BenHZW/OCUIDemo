//
//  HZWView.h
//  HzwPhotoChange
//
//  Created by Gemll on 16/2/16.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol presentImageDelegate <NSObject>

//呈现新的图片
- (void)returnImage:(UIImage*)image;

@end


@interface HZWView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property(weak,nonatomic)id<presentImageDelegate> delegate;

@end



