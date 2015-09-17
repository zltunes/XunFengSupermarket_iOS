//
//  ShoppingCarView.m
//  Supermarket_Order_01
//
//  Created by 浩然 on 15/9/10.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "ShoppingCarView.h"
#import "Header.h"

@implementation ShoppingCarView 
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect{
    
    self.backgroundColor = [UIColor redColor];
    
    UILabel *carText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, 50)];
    carText.backgroundColor = [UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];

    carText.text = @"购物车";
    carText.textColor = [UIColor orangeColor];
    carText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:carText];
    
    UIImageView *carImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    carImage.image = [UIImage imageNamed:@"6.png"];
    [self addSubview:carImage];
    
    UITableView *carGoods = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kWindowWidth, _goodArray.count*40)];
    carGoods.delegate = self;
    carGoods.dataSource = self;
    carGoods.backgroundColor = [UIColor whiteColor];
    carGoods.rowHeight = 40;
    [self addSubview:carGoods];
    _carGoods = carGoods;
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _goodArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"cellId";
    CarCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell ==nil){
        cell = [[CarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.goodDic = _goodArray[indexPath.row];
    cell.carTable = _carGoods;
    cell.delegate = self;

    return cell;

}
- (void)CarViewDataReload{
    self.frame = CGRectMake(0, kWindowHeight-self.goodArray.count*40-50-50, kWindowWidth, (self.goodArray.count)*40+50);
    self.carGoods.frame = self.frame;

    [self setNeedsDisplay];
    NSLog(@"%f",self.frame.origin.y);
    NSLog(@"%lu",(unsigned long)_goodArray.count);
}

@end
