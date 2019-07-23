//
//  TableViewControllerA.h
//  New UI
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSHRefresh.h"
@interface NewsListTableViewController : UITableViewController<NSURLSessionDownloadDelegate,QSHRefreshDelegate>
{
    QSHRefresh *qshRefreshView;
    BOOL _reloading;
}
@property(nonatomic)NSInteger value;


@end
