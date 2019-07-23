//
//  A_aViewController.m
//  New UI
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Detail_ListViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "CommitViewController.h"
@interface Detail_ListViewController ()
{


    __weak IBOutlet UIView *_myView;
    __weak IBOutlet UIScrollView *_srcollView;
    
   
    __weak IBOutlet NSLayoutConstraint *_labelHeightConstrain;
    
    __weak IBOutlet NSLayoutConstraint *_myViewHeightConstrain;
    
    __weak IBOutlet UILabel *_label;
    
    __weak IBOutlet UIImageView *_imageView;
    
    
    __weak IBOutlet UITextView *_textView;
}
   @end

@implementation Detail_ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    _label.text = self.str;
    
    UIFont *labelFont = [UIFont systemFontOfSize:20];
    
    _label.font = labelFont;

   
    NSURL *url = [NSURL URLWithString:self.pic];
    
    [_imageView sd_setImageWithURL:url];
    
    _textView.selectable = NO;
    
    _textView.text = @"1.新闻标题新颖\n2.哈哈不错\n3.看了还想看\n4.真过瘾";
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect a = [self.str boundingRectWithSize:CGSizeMake(_label.frame.size.width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : _label.font} context:nil];

    _labelHeightConstrain.constant = a.size.height+40;
    

    _myViewHeightConstrain.constant = a.size.height + 440;
    
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
