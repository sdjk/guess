//
//  ViewController.m
//  猜古建
//
//  Created by Hsiao on 16/8/30.
//  Copyright © 2016年 HS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;


// 创建一个遮罩
@property (nonatomic, strong) UIButton *cover;



@end

@implementation ViewController

// 懒加载遮罩
- (UIButton *)cover
{
    if (_cover == nil)
    {
        _cover = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cover.frame = [UIScreen mainScreen].bounds;
        
        // 设置蒙板，默认透明度为0.5
        _cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        _cover.alpha = 0.0;
        
        //  添加进视图
        [self.view addSubview:_cover];
        
        // 添加监听
        [_cover addTarget:self action:@selector(scaleButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cover;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 修改button中图片的填充方式
    self.myButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //  取消button高亮
    self.myButton.adjustsImageWhenHighlighted = NO;
    
    NSLog(@"%@",self.myButton);
    
}




- (IBAction)scaleButton:(UIButton *)sender
{
        NSLog(@"%s", __func__);
    
    
    if (self.cover.alpha == 0.0)
    {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            // 求出大小比例
            CGFloat sx = self.view.bounds.size.width / sender.bounds.size.width;
            
            //  安装这个比例进行缩放
            self.myButton.transform = CGAffineTransformMakeScale(sx, sx);
            
            // 还要添加一个平移的属性
            CGFloat ty = (self.view.bounds.size.height - sender.frame.size.height) * 0.5;
            
            // 在原有的基础上再添加一次动画
            self.myButton.transform = CGAffineTransformTranslate(self.myButton.transform, 0, ty - 40);
            
            // 把myButton推到最前面
            [self.view bringSubviewToFront:self.myButton];
            
            // 修改遮罩的透明度
            self.cover.alpha = 1.0;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.cover.alpha = 0.0;
            
            // 恢复之前的变化
            self.myButton.transform = CGAffineTransformIdentity;
        }];
    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
