//
//  ListCell.h
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
