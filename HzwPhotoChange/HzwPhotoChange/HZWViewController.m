//
//  HZWViewController.m
//  HzwPhotoChange
//
//  Created by Gemll on 16/2/16.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "HZWViewController.h"
#import "HZWView.h"
#import "Masonry.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define MAIN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define MAIN_WIDTH  [UIScreen mainScreen].bounds.size.width
@interface HZWViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,presentImageDelegate>
{
    //图片的全局变量
    UIImage *_image;
    
    //原图
    UIImage *_theOriginalImage;
    
    //选图次数
    int _times;
    
    //存放imageView里tag的数组
    NSMutableArray *_arr;
    
    //选图控制器
    UIImagePickerController *_picker;

    //滚动view
    UIScrollView *_myScrollView;
    
    //显示屏
    UIImageView *_largeImageView;
}
@end

@implementation HZWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark - 界面适配
    //按钮
   UIButton *reductionButton = [[UIButton alloc]init];
     [self.view addSubview:reductionButton];
    [reductionButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view.mas_top).with.offset(MAIN_HEIGHT/10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(MAIN_WIDTH/2.5);
        make.height.mas_equalTo(@(MAIN_HEIGHT/10));
        make.width.mas_equalTo(@(MAIN_HEIGHT/10));
        
    }];
   
    [reductionButton setTitle:@"原图" forState:UIControlStateNormal];
    reductionButton.backgroundColor = [UIColor yellowColor];
    [reductionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reductionButton addTarget:self action:@selector(restore) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"-----%f",MAIN_HEIGHT);

    
    //view
    _largeImageView =  [[UIImageView alloc] init];
    _largeImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_largeImageView];
    [_largeImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(reductionButton.mas_bottom).with.offset(MAIN_HEIGHT / 20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(MAIN_WIDTH/4);
        make.height.mas_equalTo(@(MAIN_HEIGHT/3.5));
        make.width.mas_equalTo(@(MAIN_HEIGHT/3.5));
    }];
    
    //scrowView
    _myScrollView = [[UIScrollView alloc] init];
    _myScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_myScrollView];
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_largeImageView.mas_bottom).with.offset(MAIN_HEIGHT / 20);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(@(MAIN_HEIGHT/5));
        make.width.mas_equalTo(@(MAIN_WIDTH));
        make.right.mas_equalTo(self.view.mas_right).offset(MAIN_WIDTH);
    
    }];
    
    //选图按钮
    UIButton *selectButton = [[UIButton alloc] init];
    [selectButton setTitle:@"选图" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:selectButton];
    [selectButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_myScrollView.mas_bottom).with.offset(MAIN_HEIGHT / 20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(MAIN_HEIGHT / 10);
        make.height.mas_equalTo(@(MAIN_HEIGHT / 10));
        make.width.mas_equalTo(@(MAIN_HEIGHT / 10));
    }];
    
    //保存按钮
    UIButton *saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:saveButton];
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_myScrollView.mas_bottom).with.offset(MAIN_HEIGHT / 20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-MAIN_HEIGHT / 10);
        make.height.mas_equalTo(@(MAIN_HEIGHT / 10));
        make.width.mas_equalTo(@(MAIN_HEIGHT / 10));
    }];
    
    //---------------------------------------------------------
    _times = 0;
    
    _arr = [[NSMutableArray alloc]init];
    
    _picker = [[UIImagePickerController alloc] init];
    
}

#pragma mark - 选图
- (void)selectImage
{
    _picker.delegate = self;
    
    //设置从哪里选图
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //选图效果
    _picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [_picker setAllowsEditing:YES];
    //呈现
    [self presentViewController:_picker animated:YES completion:nil];
    
    //选图次数加1
    _times += 1;
}

//成功获得相片后回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获去图片裁剪的图
    UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];
    _largeImageView.image = edit;
    _image = edit;
    _theOriginalImage = edit;
    //以模态视图形式退出
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //第一次
    if (_times <= 1)
    {
        [self addUI];
    }
    
    //第二次或以后替换imageview图片
    else
    {
        NSArray *tagArr = [NSArray arrayWithArray:_arr];
        for (int i = 0; i < tagArr.count; i++)
        {
            HZWView *hzw = (HZWView*)[_myScrollView viewWithTag:[tagArr[i] intValue] +1];
            NSLog(@"----------%@",_myScrollView.subviews);
            hzw.myImageView.image = _image;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self addFilter:[tagArr[i] intValue]];
            });
        }
    
    }


}

#pragma mark - 保存
-(void)saveImage
{
    //创建图像处方
    CIImage *saveImage = [CIImage imageWithCGImage:_largeImageView.image.CGImage];
    //联系上下文
    CIContext *softwareContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer :@(YES)}];
    //创建2d图像
    CGImageRef cgImg = [softwareContext createCGImage:saveImage fromRect:[saveImage extent]];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg metadata:[saveImage properties] completionBlock:^(NSURL *assetURL, NSError *error) {
        CGImageRelease(cgImg);
        //警告
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"保存成功");
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    

}

#pragma mark - 代理传值方法
- (void)returnImage:(UIImage *)image
{
    _largeImageView.image = image;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载view
- (void)addUI
{
    _myScrollView.backgroundColor = [UIColor yellowColor];
    for (int i = 0; i < 5; i++)
    {
        HZWView *hzw = [[HZWView alloc] init];
        hzw.delegate = self;
         [_myScrollView addSubview:hzw];
        [hzw mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(_myScrollView.mas_top);
            make.left.equalTo(_myScrollView.mas_left).offset((MAIN_WIDTH / 3)* i);
            make.width.equalTo(_myScrollView).multipliedBy(0.2);
            make.height.equalTo(_myScrollView);
                 }];
        
        //触发事件是否有回应
        hzw.userInteractionEnabled = YES;
        hzw.tag = i + 1;
        hzw.myImageView.image = _image;
        hzw.myLabel.text = [NSString stringWithFormat:@"效果%d",i+1];
        [_myScrollView addSubview:hzw];
        _myScrollView .contentSize = CGSizeMake((MAIN_WIDTH/2)*(i + 1), 0);
        //多线程加载滤镜
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self addFilter:i];
        });
    }


}

//滤镜
- (void)addFilter:(int)num
{
    [_arr addObject:@(num)];
    CIImage *oldImage = [CIImage imageWithCGImage:_image.CGImage];
    CIFilter *filter = nil;
    
    //五种效果
    switch (num) {
        case 0:
        {
            filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
            [filter setValue:@(2) forKey:@"inputShadowAmount"];
        }
            break;
            
        case 1:
        {
            filter = [CIFilter filterWithName:@"CIHueAdjust"];
            [filter setValue:@(3) forKey:@"inputAngle"];
        }
            break;
            
        case 2:
        {
            
            filter = [CIFilter filterWithName:@"CISepiaTone"];
            [filter setValue:@(0.5) forKey:@"inputIntensity"];
        }
            break;
        
        case 3:
        {
            filter = [CIFilter filterWithName:@"CIVibrance"];
            [filter setValue:@(2) forKey:@"inputAmount"];
        }
            break;
        
        case 4:
        {
            filter = [CIFilter filterWithName:@"CIGammaAdjust"];
            [filter setValue:@(2) forKey:@"inputPower"];
        }
            break;
            
        default:
            break;
            
    }
    [filter setValue:oldImage forKey:@"inputImage"];
    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        HZWView *hzw = (HZWView*)[_myScrollView viewWithTag:(num + 1)];
        _image = newImage;
        hzw.myImageView.image = _image;
        CGImageRelease(cgimg);
    });


}

//恢复原图
- (void)restore
{
    _largeImageView.image = _theOriginalImage;


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

