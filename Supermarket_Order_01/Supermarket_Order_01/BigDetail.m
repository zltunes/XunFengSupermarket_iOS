//
//  BigDetail.m
//  Final1
//
//  Created by 浩然 on 15/8/24.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import "BigDetail.h"
#import "Header.h"

@implementation BigDetail

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect{
    [super layoutSubviews];

    
    
    UILabel *upLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 50)];
    upLab.backgroundColor = [UIColor whiteColor];
    upLab.textAlignment = UITextAlignmentCenter;
    upLab.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:upLab];
    _upLabel = upLab;
    
    UILabel *downLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, CGRectGetWidth(self.frame), 50)];
    downLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:downLabel];
    _downLabel = downLabel;
    
    UIImageView *priceImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.frame.size.height-30, 20, 20)];
    priceImage.image = [UIImage imageNamed:@"9.png"];
    [self addSubview:priceImage];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50,self.frame.size.height-40, 40, 40)];
    priceLabel.textColor =  [UIColor colorWithRed:255.0/255 green:117.0/255 blue:68.0/255 alpha:1];
    priceLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    UIImage *btImage = [UIImage imageNamed:@"7.png"];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(self.frame.size.width-35, 15, 27, 27);
    [cancelBtn setBackgroundImage:btImage forState:UIControlStateNormal];
    [cancelBtn addTarget:_delegate action:@selector(selectCancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    
    UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width)-73, (self.frame.size.height)-35, 40, 30)];
    num.backgroundColor = [UIColor whiteColor];
    num.font = [UIFont boldSystemFontOfSize:14];
    num.textAlignment = UITextAlignmentCenter;
    [self addSubview:num];
    _num = num;
    
    UIButton *leftBtn = [[UIButton alloc]init];
    leftBtn.frame = (CGRectMake((self.frame.size.width)-90, (self.frame.size.height)-35, 25, 25));
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = 13;
    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //点击左边
    [leftBtn addTarget:_delegate action:@selector(detailLeftBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    leftBtn.layer.borderWidth = 1.5;
    leftBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
    [self addSubview:leftBtn];
    leftBtn.hidden = YES;
    _leftBtn = leftBtn;
    
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.frame = (CGRectMake((self.frame.size.width)-40, (self.frame.size.height)-35, 25, 25));
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 13;
    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn addTarget:_delegate action:@selector(detailRightBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    rightBtn.layer.borderWidth = 1.5;
    rightBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    UIImageView *picImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-100)];
    [self addSubview:picImage];
    _picImage = picImage;
    
}

@end

