//
//  A_aViewController.m
//  New UI
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Detail_ListViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
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
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    

    CGRect a = [self.str boundingRectWithSize:CGSizeMake(_label.frame.size.width, 0) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _label.font} context:nil];
//    [_label sizeThatFits:]

    _labelHeightConstrain.constant = a.size.height;
        
    _myViewHeightConstrain.constant = a.size.height+ 400;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
