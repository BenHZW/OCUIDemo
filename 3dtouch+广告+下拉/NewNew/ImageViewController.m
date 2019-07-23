//
//  ImageViewController.m
//  New UI
//
//  Created by Ibokan on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ImageViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "CommitViewController.h"

@interface ImageViewController ()

{
    
    IBOutlet UILabel *_titleLabel;
    
    UIScrollView *_scrollImage;
    
    __weak IBOutlet UIPageControl *_pageControl;
    
}

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题文字
    _titleLabel.text = self.myTitle;
    
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    float width = CGRectGetWidth(screenFrame);
    
    //设置滚动视图
    _scrollImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, width , 500)];
    
    _scrollImage.contentSize = CGSizeMake( width * self.imageArray.count, 500);
    
    [self.view addSubview:_scrollImage];
    
    _scrollImage.pagingEnabled = YES;
    
    //批量添加图片、文本框、标签
    for (NSInteger i = 0;  i < self.imageArray.count; ++i)
    {
        UIImageView *newsImage = [[UIImageView alloc]initWithFrame:CGRectMake(i * width, 50, width, 300)];
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width + width/2 - 20, 475, 40, 30)];
        
        infoLabel.backgroundColor = [UIColor clearColor];
        
        infoLabel.textColor = [UIColor whiteColor];
        
        NSString *count = [NSString stringWithFormat:@"%ld / %ld", i + 1, self.imageArray.count];
        
        UITextView *infoView = [[UITextView alloc]initWithFrame:CGRectMake(i * width, 350, width, 130)];
        
        UIFont *infoFont = [UIFont systemFontOfSize:15];
        
        infoView.font = infoFont;
        
        infoView.backgroundColor = [UIColor clearColor];
        
        infoView.textColor = [UIColor whiteColor];
        
        infoView.text = self.infoArray[i];
        
        infoView.delegate = self;
        
        NSURL *url = [NSURL URLWithString:self.imageArray[i]];
        
        [newsImage sd_setImageWithURL:url];
        
        infoLabel.text = count;
        
        
        [_scrollImage addSubview:newsImage];
        [_scrollImage addSubview:infoLabel];
        [_scrollImage addSubview:infoView];
        
    }
    
    //设置pageControl属性
    CGPoint pageControlCenter = _pageControl.center;
    pageControlCenter.x = _scrollImage.center.x;
    _pageControl.center = pageControlCenter;
    
    _pageControl.numberOfPages = self.imageArray.count;
    
    _pageControl.defersCurrentPageDisplay = YES;
    
    _pageControl.backgroundColor = [UIColor blackColor];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    _scrollImage.delegate = self;
    
    [_pageControl addTarget:self action:@selector(pageControlPageNumberChange:) forControlEvents:UIControlEventValueChanged];
    
    // UIImageView *imageView = [UIImageView alloc]initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
}

- (void)pageControlPageNumberChange:(UIPageControl*)pageControl
{
    NSLog(@"页面改变");
    //    NSInteger pageNumber = pageControl.currentPage;
    //
    //    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    //
    //    float width = CGRectGetWidth(screenFrame);
    //
    //    CGPoint offset = CGPointMake(width * pageNumber, 0);
    //    [_scrollImage setContentOffset:offset animated:YES];
}

//ScrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"停止滑动");
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    float width = CGRectGetWidth(screenFrame);
    
    
    
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x) / width;
    
}

//textView代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //阻止键盘弹出
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     CommitViewController *vcvc = segue.destinationViewController;
     vcvc.newsId = self.newsId;

 }


@end

