//
//  VideoCommitViewController.h
//  New UI
//
//  Created by 3024 on 15/11/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSHRefresh.h"
@interface CommitViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,QSHRefreshDelegate>
{
    QSHRefresh *qshRefreshView;
    BOOL _reloading;
}

@property(nonatomic)NSInteger newsId;
@end
