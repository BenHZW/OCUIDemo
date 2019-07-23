//
//  ViewController.h
//  NewNew
//
//  Created by 3024 on 15/11/26.
//  Copyright © 2015年 ios25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSHRefresh.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,QSHRefreshDelegate>
{
        QSHRefresh *qshRefreshView1;
        QSHRefresh *qshRefreshView2;
        QSHRefresh *qshRefreshView3;
        BOOL _reloading;
}
@property (retain, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *ListBut;
@property (weak, nonatomic) IBOutlet UIButton *imgBut;
@property (weak, nonatomic) IBOutlet UIButton *videoBut;

@end

