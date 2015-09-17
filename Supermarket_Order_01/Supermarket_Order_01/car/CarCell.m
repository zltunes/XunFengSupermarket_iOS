//
//  CarCell.m
//  Supermarket_Order_01
//
//  Created by 浩然 on 15/9/10.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//
#import "CarCell.h"
#import "Header.h"

@implementation CarCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   // self.frame = CGRectMake(0, 0, kWindowWidth, 50);
    if(self){
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWindowWidth*0.4, 40)];
        nameLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth*0.5, 0, 30, 40)];
        [self.contentView addSubview:priceLabel];
        _priceLabel = priceLabel;
        
        UIButton *leftBtn = [[UIButton alloc]init];
        leftBtn.frame = CGRectMake(kWindowWidth*0.75, 10, 20, 20);
        leftBtn.layer.masksToBounds = YES;
        leftBtn.layer.cornerRadius = 10;
        [leftBtn setTitle:@"-" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        //点击左边
        [leftBtn addTarget:self action:@selector(leftBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        leftBtn.layer.borderWidth = 1;
        leftBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
        [self.contentView addSubview:leftBtn];
        _leftBtn = leftBtn;
        
        
        UIButton *rightBtn = [[UIButton alloc]init];
        rightBtn.frame = CGRectMake(kWindowWidth*0.9, 10, 20, 20);
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 10;
        [rightBtn setTitle:@"+" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        //点击右边
        [rightBtn addTarget:self action:@selector(rightBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        rightBtn.layer.borderWidth = 1;
        rightBtn.layer.borderColor = [[UIColor orangeColor]CGColor];
        [self.contentView addSubview:rightBtn];
        _rightBtn = rightBtn;
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth*0.8, 10, kWindowWidth*0.1, 20)];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:numLabel];
        _numLabel = numLabel;
        
        
    }
    return self;
}

- (void)setGoodDic:(NSMutableDictionary *)goodDic{
    _goodDic = goodDic;
    _nameLabel.text = _goodDic[@"name"];
    _priceLabel.text = [NSString stringWithFormat:@"%@",_goodDic[@"price"]];
    _numLabel.text = [NSString stringWithFormat:@"%@",_goodDic[@"quantity"]];
    _tempCell = _goodDic[@"cell"];

}
- (void)leftBtnSelect:(id)sender{
    int temp = [_numLabel.text intValue];
    if(temp == 1){
        [_tempCell leftBtnSelect:sender];
        [self.delegate CarViewDataReload];
        return;
    }
    temp--;
    _numLabel.text = [NSString stringWithFormat:@"%d",temp];

    [_tempCell leftBtnSelect:sender];


}
- (void)rightBtnSelect:(id)sender{
    _leftBtn.hidden = NO;
    int temp = [_numLabel.text intValue];
    temp++;
    _numLabel.text = [NSString stringWithFormat:@"%d",temp];
    
    [_tempCell rightBtnSelect:sender];
}

@end
