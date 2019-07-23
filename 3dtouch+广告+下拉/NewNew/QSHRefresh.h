//
//  QSHRefresh.h
//  TableViewPull
//
//  Created by ma c on 15/10/26.
//
//

#import <UIKit/UIKit.h>
typedef enum{
    //正在拉动
    QSHPullRefreshPulling = 0,
    //原始状态，从没拉动
    QSHPullRefreshNormal,
    //结束拉动，加载中
    QSHPullRefreshLoading,
} QSHPullRefreshState;

typedef enum
{
    QSHRefreshImageArrow,//箭头
    QSHRefreshImageWatch,//表盘
}QSHRefreshImageType;

@protocol QSHRefreshDelegate;
@interface QSHRefresh : UIView
@property (nonatomic, assign) NSObject<QSHRefreshDelegate>* delegate;
@property (nonatomic, assign) QSHPullRefreshState state;
/**上次刷新时间*/
@property (nonatomic, strong) UILabel *lastUpdatedLabel;
/**当前状态*/
@property (nonatomic, strong) UILabel *statusLabel;
/**小菊花*/
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
/**刷新图片样式 默认是箭头*/
@property (nonatomic, assign) QSHRefreshImageType imageType;



- (void)refreshLastUpdatedDate;
- (void)qshRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)qshRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)qshRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end

@protocol QSHRefreshDelegate
- (void)qshRefreshDidTriggerRefresh:(QSHRefresh *)view;
- (BOOL)qshRefreshDataSourceIsLoading:(QSHRefresh *)view;
- (NSDate *)qshRefreshDataSourceLastUpdated:(QSHRefresh *)view;
@end
