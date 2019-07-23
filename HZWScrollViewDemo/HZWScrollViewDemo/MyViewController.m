//
//  MyViewController.m
//  HZWScrollViewDemo
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyViewController.h"
#import "UIImage+Scale.h"
//原始高度
#define ORIGINAL_RECT (int)50

//边距
#define MARGIN (int)20

#define MAIN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define MAIN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface MyViewController ()
{
     //图片宽度
     int _Width;
    
    //左侧图片高度
    int _left_Height;
    
    //右侧图片高度
    int _right_Height;
    
    //图片库
    NSArray *_picArr;
 
    //滚动视图
    UIScrollView *_srcollView;
}
@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化左右高度
    _left_Height =  ORIGINAL_RECT + MARGIN;
    
    _right_Height = ORIGINAL_RECT + MARGIN;
    
    //取图片
    _picArr = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"pic"];
    [self initWithScrollView];
    
    [self initWithMainView];
    
    
    
}

- (void)initWithScrollView
{
    _srcollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    _srcollView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:_srcollView];
    
}



-(void)initWithMainView
{
    for (int i = 0; i < _picArr.count; i++)
    {
        UIImage *image = [UIImage imageWithContentsOfFile:_picArr[i]];
        if (image.size.width > (MAIN_WIDTH / 2 - 2 * MARGIN))
        {
            image = [UIImage imageWithCompressForWidth:image targetWidth:MAIN_WIDTH / 2 - 2 * MARGIN];
        }
        UIImageView *imageview = [UIImageView new];
        imageview.image = image;
        //第一
        if (i == 0)
        {
            [self leftUI:imageview image:image];
        }
        
        //第二
        else if (i == 1)
        {
            [self rightUI:imageview image:image];
            
        }
        else
        {
          //第二张之后
          if(_left_Height <= _right_Height)
          {
              [self leftUI:imageview image:image];
          
          
          }
            else
            {
                [self rightUI:imageview image:image];
            
            }
            [_srcollView addSubview:imageview];
        }
        
    }
   

}

//左
- (void)leftUI:(UIImageView*)imageview
         image:(UIImage*)image
{
    
    _Width = MARGIN;
    imageview.frame = CGRectMake(_Width, _left_Height, MAIN_WIDTH/2-2*MARGIN, image.size.height);
    _srcollView.contentSize = CGSizeMake(0, (image.size.height + _left_Height ));
   _left_Height +=  (image.size.height+MARGIN);
    
}

//右
- (void)rightUI:(UIImageView*)imageview
          image:(UIImage*)image
{
    
    _Width = MAIN_WIDTH/2;
    imageview.frame = CGRectMake(_Width, _right_Height, MAIN_WIDTH/2-2*MARGIN, image.size.height);
    _srcollView.contentSize = CGSizeMake(0, (image.size.height + _right_Height ));
   _right_Height += (image.size.height+MARGIN);
    
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
