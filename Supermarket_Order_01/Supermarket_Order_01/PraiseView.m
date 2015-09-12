//
//  ViewController.m
//  Start_Me_Up_New
//
//  Created by xmhouse on 9/11/13.
//  Copyright (c) 2013 xmhouse. All rights reserved.
//

#import "PraiseView.h"


@implementation PraiseView
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defalutInit];
    }
    return self;
}
- (void)defalutInit
{
    appdelegate = [UIApplication sharedApplication].delegate;
    couponCreateURL = @"http://115.29.197.143:8999/v1.0/coupon";
    couid_dict = [[NSMutableDictionary alloc]init];
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 10.0f;
    self.clipsToBounds = TRUE;
    
    //添加转盘
    _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"转盘.png"]];
    _imageView1.frame = CGRectMake(0.0, 0.0, 240.0, 240.0);
    [self addSubview:_imageView1];
    
    //添加转针
    _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start.png"]];
    _imageView2.frame = CGRectMake(77.5, 40.0, 90.0, 157.5);
    //为UIIamgeView添加手势（事件）
    _imageView2.userInteractionEnabled = YES;
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choujiang)];
    [_imageView2 addGestureRecognizer:_singleTap];
    [self addSubview:_imageView2];
    
    _overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
}
- (void)choujiang
{
    //从后台获取抽到的cou_id
    NSDictionary* param = @{@"o_id":[NSNumber numberWithInt:self.order_id]};
    [appdelegate.manager POST:couponCreateURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        couid_dict = responseObject;
//        self.cou_price = [couid_dict[@"price"]intValue];//1-5//后台待改，返回参数"price";!!!!!!!!
        self.cou_price = 3;
        srand((unsigned)time(0));
        switch (self.cou_price) {
            case 4:
                self.random = (rand()%3+1)/10.0;
                break;
            case 5:
                self.random = (rand()%3+5)/10.0;
                break;
            case 1:
                self.random = (rand()%3+9)/10.0;
                break;
            case 2:
                self.random = (rand()%3+13)/10.0;
                break;
            case 3:
                self.random = (rand()%3+17)/10.0;
                break;
            default:
                break;
        }
        //设置动画
        CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0+self.orign)]];
        [spin setFromValue:[NSNumber numberWithFloat:0.0f]];
        [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0+self.random)]];
        [spin setDuration:2.5];
        [spin setDelegate:self];//设置代理，可以相应animationDidStop:finished:函数，用以弹出提醒框
        //速度控制器
        [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        //添加动画
        [[self.imageView2 layer] addAnimation:spin forKey:nil];
        //锁定结束位置
        self.imageView2.transform = CGAffineTransformMakeRotation(M_PI * (10.0+self.random));
        self.orign = 10.0+self.random;
        self.orign = fmodf(self.orign, 2.0);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"后台生成购物券失败!%@",error);
    } ];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //判断抽奖结果
    if (self.orign >= 0.0 && self.orign < 0.4) {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 四元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }
    else if (self.orign >= 0.4 && self.orign < 0.8)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 五元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (self.orign >= 0.8 && self.orign < 1.2)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 一元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (self.orign >= 1.2 && self.orign < 1.6)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 二元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }else if (self.orign >= 1.6 && self.orign < 2.0)
    {
        UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:@"您中了 三元！ " delegate:self cancelButtonTitle:@"加入我的购物券！" otherButtonTitles: nil];
        [result show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.orign = 0;
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}
- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

@end
