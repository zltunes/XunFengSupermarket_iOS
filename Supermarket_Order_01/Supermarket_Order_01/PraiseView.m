//
//  ViewController.m
//  Start_Me_Up_New
//
//  Created by xmhouse on 9/11/13.
//  Copyright (c) 2013 xmhouse. All rights reserved.
//

#import "PraiseView.h"
#import <QuartzCore/QuartzCore.h>
#import "math.h"

@interface PraiseView ()

@end

@implementation PraiseView

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加转盘
    UIImageView *image_disk = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"转盘.jpg"]];
    image_disk.frame = CGRectMake(0.0, 0.0, 240.0, 240.0);
    image1 = image_disk;
    [self.view addSubview:image1];
    
    //添加转针
    UIImageView *image_start = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
    image_start.frame = CGRectMake(77.5, 40.0, 90.0, 157.5);
    image2 = image_start;
    
    //为UIIamgeView添加手势（事件）
    image2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choujiang)];
    [image2 addGestureRecognizer:singleTap];
    
    [self.view addSubview:image2];
    
}
- (void)choujiang
{
    //******************旋转动画******************
    //产生随机角度
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    random = (rand() % 20) / 10.0;
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0+orign)]];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0+random+orign)]];
    [spin setDuration:2.5];
    [spin setDelegate:self];//设置代理，可以相应animationDidStop:finished:函数，用以弹出提醒框
    //速度控制器
    [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //添加动画
    [[image2 layer] addAnimation:spin forKey:nil];
    //锁定结束位置
    image2.transform = CGAffineTransformMakeRotation(M_PI * (10.0+random+orign));
    //锁定fromValue的位置
    orign = 10.0+random+orign;
    orign = fmodf(orign, 2.0);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //判断抽奖结果
    if (orign >= 0.0 && orign < 0.4) {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 四元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }
    else if (orign >= 0.4 && orign < 0.8)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 五元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= 0.8 && orign < 1.2)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 一元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= 1.2 && orign < 1.6)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 二元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (orign >= 1.6 && orign < 2.0)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 三元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }
}

@end
