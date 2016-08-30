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
    
    [self createAnswerButton];
    
    [self createOptionButton];
   
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

// 创建答案区按钮,测试
-(void) createAnswerButton
{
    for (int i = 0 ; i < 3; i++)
    {
        // 创建UIButton
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //  设置背景图
        [but setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        
        [but setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置每个Button的frame
        
        
        // 宽度要等于高度
        CGFloat width = self.answerView.frame.size.height;
        
        // 设置每个button的边距
        CGFloat margin = (self.answerView.frame.size.width - 150 - 3 * width) / (3 - 1);
        
        // 要设置X值，设置两边的间距分别为50
        CGFloat x = 75 + i * (margin + width);
        
        but.frame = CGRectMake(x, 0, width, width);
        
        [self.answerView addSubview:but];
        
    }
}

// 创建被选区
- (void) createOptionButton
{
    // 也使用for循环，进行九宫格布局，3行7列，一起21个选项
    for (int i = 0; i < 21; i ++)
    {
        //  用模取列，可以求x值
        int column = i % 7;
        
        // 用除取行，可以求y值
        int row = i / 7;
        
        //  设置间距
        CGFloat margin = 10;
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [but setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        
        [but setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
        
        CGFloat width = (self.optionView.frame.size.width - 8 * margin) / 7;
        
        CGFloat yMargin = (self.optionView.frame.size.height - 3 * width - 2 * margin) * 0.5;
        
        
        CGFloat x = margin + column * (margin + width);
        
        CGFloat y = yMargin + row * (margin + width);
        
        but.frame = CGRectMake(x, y, width, width);
        
        [self.optionView addSubview:but];
        
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
