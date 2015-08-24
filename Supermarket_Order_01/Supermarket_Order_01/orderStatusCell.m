//
//  orderStatusCell.m
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/28.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "orderStatusCell.h"

@implementation orderStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//以下函数为实现UIPopoverListView协议
- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                   reuseIdentifier:identifier];

        cell.textLabel.text = @"商家电话";
        cell.detailTextLabel.text = @"13720928727";
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    //拨号
    UIWebView* callWebView = [[UIWebView alloc]init];
    NSURL *telURL = nil;
    //使用UIWebView加载tel:开头的URL打电话，而且电话结束后回到本应用，以留住用户！！
    telURL = [NSURL URLWithString:@"tel:13720928727"];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.contentView addSubview:callWebView];
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //根据status设置img
        self.checkORerrorImg = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowWidth/5, 10, 25, 25)];
        [self.contentView addSubview:self.checkORerrorImg];
        
        //根据status设置text
        self.orderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/5+40, 10, 0.75*kWindowWidth, 25)];
//        self.orderStatusLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.orderStatusLabel];
        
        //根据status设置text
        self.preTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/3, 50, kWindowWidth/2, 25)];
        [self.contentView addSubview:self.preTimeLabel];
        
        //根据status设置progress
        self.progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progress.frame = CGRectMake(20, 111, kWindowWidth-40,5);
        [self.progress setTintColor:[UIColor redColor]];
        [self.contentView addSubview:self.progress];
        
        //固定
        self.dingDanTiJiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/6, 125, 40, 10)];
//        self.dingDanTiJiaoLabel.textAlignment = NSTextAlignmentCenter;
        self.dingDanTiJiaoLabel.text = @"订单提交";
        [self.dingDanTiJiaoLabel sizeToFit];
//        self.dingDanTiJiaoLabel.numberOfLines = 1;
//        self.dingDanTiJiaoLabel.adjustsFontSizeToFitWidth = YES;
        self.dingDanTiJiaoLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:self.dingDanTiJiaoLabel];
        
        //根据status设置textColor/hiden
        self.chaoShiJieDanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2-20, 125, 40, 10)];
//        self.chaoShiJieDanLabel.textAlignment = NSTextAlignmentLeft;
        self.chaoShiJieDanLabel.text = @"超市接单";
        [self.chaoShiJieDanLabel sizeToFit];
        [self.contentView addSubview:self.chaoShiJieDanLabel];
        
        //根据status设置textColor/hiden
        self.yiShouHuoLabel = [[UILabel alloc]initWithFrame:CGRectMake(3*kWindowWidth/4, 125, 40, 10)];
        self.yiShouHuoLabel.textAlignment = NSTextAlignmentRight;
        self.yiShouHuoLabel.text = @"已收货";
        [self.yiShouHuoLabel sizeToFit];
        [self.contentView addSubview:self.yiShouHuoLabel];
        
        //根据status设置hiden
        self.dingDanQuXiaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWindowWidth/2, 125, 40, 10)];
//        self.dingDanQuXiaoLabel.textAlignment = NSTextAlignmentCenter;
        self.dingDanQuXiaoLabel.text = @"订单取消";
        self.dingDanQuXiaoLabel.textColor = [UIColor orangeColor];
        self.dingDanQuXiaoLabel.hidden = YES;
        [self.dingDanQuXiaoLabel sizeToFit];
        [self.contentView addSubview:self.dingDanQuXiaoLabel];
        
        //根据status选择hiden
        self.queRenShouHuoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.queRenShouHuoBtn.frame = CGRectMake(135, 150, 70, 25);
        [self.queRenShouHuoBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        //button这种设置title的方式是无效的！！！！！！！！！！记住！
//        self.queRenShouHuoBtn.titleLabel.text = @"确认收货";
        self.queRenShouHuoBtn.hidden = YES;
        [self.contentView addSubview:self.queRenShouHuoBtn];
        
        //根据status选择hiden
        self.dianHuaCuiDanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.dianHuaCuiDanBtn.frame = CGRectMake(kWindowWidth/2+35, 150, 70, 25);
        [self.dianHuaCuiDanBtn setTitle:@"电话催单" forState:UIControlStateNormal];
        self.dianHuaCuiDanBtn.hidden = YES;
        //定制事件
        [self.dianHuaCuiDanBtn addTarget:self action:@selector(cuidan:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.dianHuaCuiDanBtn];
        
        //根据status选择hiden
        self.quXiaoDingDanBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.quXiaoDingDanBtn.frame = CGRectMake(300, 150, 70, 25);
        [self.quXiaoDingDanBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        self.quXiaoDingDanBtn.hidden = YES;
        [self.contentView addSubview:self.quXiaoDingDanBtn];
        //取消订单事件
        [self.quXiaoDingDanBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];

        //根据status选择hiden
        self.pingJiaBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.pingJiaBtn.frame = CGRectMake(300, 150, 70, 25);
        [self.pingJiaBtn setTitle:@"评价" forState:UIControlStateNormal];
        self.pingJiaBtn.hidden = YES;
        [self.contentView addSubview:self.pingJiaBtn];
        
        //根据status选择hiden
        self.dingDanTousuBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.dingDanTousuBtn.frame = CGRectMake(300, 150, 70, 25);
        [self.dingDanTousuBtn setTitle:@"订单投诉" forState:UIControlStateNormal];
        self.dingDanTousuBtn.hidden = YES;
        [self.contentView addSubview:self.dingDanTousuBtn];
    }
    return  self;
}
//电话催单事件
-(void)cuidan:(id)sender
{
    CGFloat xWidth = kWindowWidth - 40.0f;
    CGFloat yHeight = 86.0f;
    CGFloat yOffset = (kWindowHeight - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"拨打电话"];
    [poplistview show];
}
//取消订单事件
-(void)cancelOrder:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认取消订单？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}
//如果在alert点击确认取消
/*
 问题：为什么闪退？
 */
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(buttonIndex){
//        [self cuidan:nil];
//    }
//}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex){
        [self cuidan:nil];
    }
}
@end
