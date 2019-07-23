//
//  FilterViewController.m
//  HZWFilterDemo
//
//  Created by Gemll on 16/1/25.
//  Copyright © 2016年 Huangzhiwen. All rights reserved.
//

#import "FilterViewController.h"
#define CONTROLPANEL_FONTSIZE 12

@interface FilterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    //系统照片选择控制器
    UIImagePickerController *_imagePickerController;
    
    //显示板
    UIImageView *_imageView;
    
    //Core Image联系上下文
    CIContext *_context;
    
    //需要编辑的图片
    CIImage *_image;
    
    //处理后的图片
    CIImage *_outputImage;
    
    //色彩滤镜
    CIFilter *_colorControlsFilter;
    
}

@end
@implementation FilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initLayout];
    
}

- (void)initLayout
{
    //图片选择器的创建
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    //显示板的创建
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 500, 630)];
    _imageView.backgroundColor = [UIColor blackColor];
    //这个枚举为除了原图片其他区域都为透明
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    //上方导航按钮,style的枚举为：完成一些任务后并返回到前视图
    self.navigationItem.title = @"HZWPicChange";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStyleDone target:self action:@selector(openThePhoto)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveThePhoto)];
    
    //下方控制板
    UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(10, 520,400, 200)];
    //controlView.backgroundColor = [UIColor redColor];
    [self.view addSubview:controlView];
    
    //饱和度label
    UILabel *saturatingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 100)];
    saturatingLabel.text = @"饱和度";
    saturatingLabel.textColor = [UIColor redColor];
    //saturatingLabel.font = [UIFont systemFontOfSize:CONTROLPANEL_FONTSIZE];
    [controlView addSubview:saturatingLabel];
    
    //光亮度label
    UILabel *brightnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
    brightnessLabel.text = @"光亮度";
    brightnessLabel.textColor = [UIColor redColor];
    [controlView addSubview:brightnessLabel];
    
    //对比度label
    UILabel *contrastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 100, 100)];
    contrastLabel.text = @"对比度";
    contrastLabel.textColor = [UIColor redColor];
    [controlView addSubview:contrastLabel];
    
    
    //饱和度的滚动条
    UISlider *saturatingSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 80, 350, 30)];
    saturatingSlider.minimumValue = 0;
    saturatingSlider.maximumValue = 2;
    saturatingSlider.value = 1;
    [saturatingSlider addTarget:self action:@selector(changeStaturation:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:saturatingSlider];
    
    //光亮度的滚动条
    UISlider *brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 120, 350, 30)];
    brightnessSlider.minimumValue = 0;
    brightnessSlider.maximumValue = 2;
    brightnessSlider.value = 1;
    [brightnessSlider addTarget:self action:@selector(changeBrightness:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:brightnessSlider];
    
    //对比度的滚动条
    UISlider *contrastSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 160, 350, 30)];
    contrastSlider.minimumValue = 0;
    contrastSlider.maximumValue = 2;
    contrastSlider.value = 1;
    [contrastSlider addTarget:self action:@selector(changeContrast:) forControlEvents:UIControlEventValueChanged];
    [controlView addSubview:contrastSlider];
    
    
    
    //初始化CIContext,创建基于CPU的上下文
    _context = [CIContext contextWithOptions:nil];
    
    //取得滤镜
    _colorControlsFilter = [CIFilter filterWithName:@"CIColorControls"];
    
}

#pragma mark - 打开图片选择器
-(void)openThePhoto
{
    [self presentViewController:_imagePickerController animated:YES completion:nil];
    
    
}

#pragma mark - 保存图片
-(void)saveThePhoto
{
    //保存照片到相册
    UIImageWriteToSavedPhotosAlbum(_imageView.image, nil, nil, nil);
    NSLog(@"已保存");
    
    
}

#pragma mark - 成功获得相片后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
    //取得选择图片
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = selectedImage;
    //初始化CIImage源图片
    _image = [CIImage imageWithCGImage:selectedImage.CGImage];
    //设置滤镜的输入图片
    [_colorControlsFilter setValue:_image forKey:@"inputImage"];
}

#pragma mark - 将图片设置到UIImageView
-(void)setImage
{
    //取得输出图像
    CIImage *outputImage = [_colorControlsFilter outputImage];
    //创建CGImageRef对象,CGImageRef需要手动释放
    CGImageRef temp = [_context createCGImage:outputImage fromRect:[outputImage extent]];
    //显示
    _imageView.image = [UIImage imageWithCGImage:temp];
    //释放CGImageRef对象
    CGImageRelease(temp);
    
}

#pragma mark - 调整饱和度
-(void)changeStaturation:(UISlider*)slider
{
    //设置滤镜参数
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputSaturation"];
    [self setImage];
}


#pragma mark - 调节亮度
- (void)changeBrightness:(UISlider*)slider
{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputBrightness"];
    [self setImage];
    
}

#pragma mark - 调整对比度
- (void)changeContrast:(UISlider*)slider
{
    [_colorControlsFilter setValue:[NSNumber numberWithFloat:slider.value] forKey:@"inputContrast"];
    [self setImage];
    
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
