//
//  QSHRefresh.m
//  TableViewPull
//
//  Created by ma c on 15/10/26.
//
//

#import "QSHRefresh.h"
#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]


@interface QSHRefresh ()

/**箭头*/
@property (nonatomic, strong) UIImageView *arrowImage;
/**表针*/
@property (nonatomic, strong) UIImageView *watchImage;
/**表盘*/
@property (nonatomic, strong) UIImageView *biaopanImage;
/**frame*/
@property (nonatomic, assign) CGRect passFrame;
/**上次拖拽的偏移量*/
@property (nonatomic, assign) CGFloat lastOffsetY;
/**设置图片类型为箭头的次数*/
@property (nonatomic, assign) int arrowImgCount;

- (void)setState:(QSHPullRefreshState)pullState;
@end

@implementation QSHRefresh

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.passFrame = frame;
        self.lastOffsetY = 0;
        self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.imageType = QSHRefreshImageArrow;
        self.arrowImgCount = 1;
        //上次刷新
        self.lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, self.frame.size.width, 20)];
        self.lastUpdatedLabel.font = [UIFont systemFontOfSize:12];
        self.lastUpdatedLabel.textColor = TEXT_COLOR;
        self.lastUpdatedLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        self.lastUpdatedLabel.shadowOffset = CGSizeMake(0, 1);
        self.lastUpdatedLabel.backgroundColor = [UIColor clearColor];
        self.lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lastUpdatedLabel];
        
        //当前状态
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 48, self.frame.size.width, 20)];
        self.statusLabel.font = [UIFont boldSystemFontOfSize:13];
        self.statusLabel.textColor = TEXT_COLOR;
        self.statusLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        self.statusLabel.shadowOffset = CGSizeMake(0, 1);
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.statusLabel];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.frame = CGRectMake(25, frame.size.height - 38, 20, 20);
        [self addSubview:self.activityView];
        
        [self setState:QSHPullRefreshNormal];
        
    }
    
    return self;
    
}

- (void)setImageType:(QSHRefreshImageType)imageType
{
    //图片
    switch (imageType) {
        case QSHRefreshImageArrow:
        {
            if (self.arrowImgCount == 1) {
                return ;
            }
            self.arrowImage = [[UIImageView alloc] initWithFrame: CGRectMake(25, self.passFrame.size.height - 65, 30, 55)];
            self.arrowImage.image = [UIImage imageNamed:@"blueArrow"];
            
            [self addSubview:self.arrowImage];
        }
            break;
        case QSHRefreshImageWatch:
        {
            self.biaopanImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.passFrame.size.height - 65, 55, 55)];
            self.biaopanImage.image = [UIImage imageNamed:@"biaopan"];
            [self addSubview:self.biaopanImage];
            
            self.watchImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.passFrame.size.height - 65, 55, 55)];
            self.watchImage.image = [UIImage imageNamed:@"biaozhen"];
            [self addSubview:self.watchImage];
            
            self.arrowImage.hidden = YES;
        }
            break;
        default:
            break;
    }
    _imageType = imageType;
}


#pragma mark - ---------------设置控件----------------

- (void)refreshLastUpdatedDate {
    
    
    if ([_delegate respondsToSelector:@selector(qshRefreshDataSourceLastUpdated:)]) {
    
        NSDate *date = [_delegate qshRefreshDataSourceLastUpdated:self];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:date]];
        
        //存储
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"QSHRefresh_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    } else {
        _lastUpdatedLabel.text = nil;
    }
    
}

- (void)setState:(QSHPullRefreshState)pushState{
   
    switch (pushState) {
        case QSHPullRefreshPulling:
        {
            _statusLabel.text = @"释放刷新";
            
            [UIView animateWithDuration:0.2 animations:^{
                switch (self.imageType) {
                    case QSHRefreshImageArrow:
                    {
                        _arrowImage.transform = CGAffineTransformRotate(_arrowImage.transform, M_PI);
                    }
                        break;
                    default:
                        break;
                }

            }];
        }
            break;
    
        case QSHPullRefreshNormal:
        {
            if (_state == QSHPullRefreshPulling) {

                [UIView animateWithDuration:0.2 animations:^{
                    _arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
        
            _statusLabel.text = @"下拉刷新";
            [_activityView stopAnimating];
            if (self.imageType == QSHRefreshImageArrow) {
                _arrowImage.hidden = NO;
                [self setWatchHidden:YES];
            }else if(self.imageType == QSHRefreshImageWatch){
                _arrowImage.hidden = YES;
                [self setWatchHidden:NO];
            }
            [self refreshLastUpdatedDate];
        }
            break;
        case QSHPullRefreshLoading:
        {
            _statusLabel.text = @"加载中...";
            [_activityView startAnimating];
            _arrowImage.hidden = YES;
            [self setWatchHidden:YES];
            self.arrowImage.transform = CGAffineTransformIdentity;
        }
            break;
        default:
            break;
    }
    
    _state = pushState;
}

- (void) setWatchHidden:(BOOL)isHid
{
    _watchImage.hidden = isHid;
    _biaopanImage.hidden = isHid;
}

- (void)qshRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    //正在加载
    if (_state == QSHPullRefreshLoading) {

        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0, 0, 0);
    } else if (scrollView.isDragging) {//正在拉
        //是否加载
        BOOL loading = NO;
        if ([self.delegate respondsToSelector:@selector(qshRefreshDataSourceIsLoading:)]) {
            //loading取空
            loading = [_delegate qshRefreshDataSourceIsLoading:self];
        }

        if (scrollView.contentOffset.y > -60 && scrollView.contentOffset.y < 0 && !loading) {
                if (self.imageType == QSHRefreshImageWatch) {
                    CGFloat angle = (self.lastOffsetY-scrollView.contentOffset.y)*3/60;
                    self.watchImage.transform = CGAffineTransformRotate(self.watchImage.transform, angle *(M_PI_2));
                    self.lastOffsetY = scrollView.contentOffset.y;
                }
                //如果还在拉，设置当前为原始状态
                if (self.state == QSHPullRefreshPulling) {
                    self.state = QSHPullRefreshNormal;
                }
        }else if(self.state == QSHPullRefreshNormal && scrollView.contentOffset.y < -60.0f && !loading){//如果是原始状态并且拉倒一定程度
            //设置当前为正在拉动
            self.state = QSHPullRefreshPulling;
        }
        //如果顶端不是0位置，恢复0位置
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
            //表盘恢复
            self.watchImage.transform = CGAffineTransformIdentity;
        }
        
    }
    
}
//结束拖动
- (void)qshRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    //是否加载
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(qshRefreshDataSourceIsLoading:)]) {
        //取空
        _loading = [_delegate qshRefreshDataSourceIsLoading:self];
    }
    //如果拖动过多
    if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(qshRefreshDidTriggerRefresh:)]) {
            //告诉代理，结束拖动，并且拖动距离达到
            [_delegate qshRefreshDidTriggerRefresh:self];
        }
        //设置状态是正在加载
        [self setState:QSHPullRefreshLoading];
        [UIView animateWithDuration:0.2 animations:^{
             scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        }];
        
    }
    
}

//结束加载后
- (void)qshRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
   
    [UIView animateWithDuration:0.3 animations:^{
         //设置表格位0坐标
        [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        //当前状态是原始状态
        [self setState:QSHPullRefreshNormal];
    }];
    
}

@end
