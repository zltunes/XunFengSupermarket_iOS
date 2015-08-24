//
//  orderStatusCell.h
//  Supermarket_Order_01
//
//  Created by 赵磊 on 15/7/28.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "UIPopoverListView.h"
#import "OrderEvaluate.h"
@interface orderStatusCell : UITableViewCell<UIPopoverListViewDataSource, UIPopoverListViewDelegate,UIAlertViewDelegate>
@property(strong,nonatomic) UIImageView* checkORerrorImg;
@property(strong,nonatomic) UILabel* orderStatusLabel;
@property(strong,nonatomic) UILabel* preTimeLabel;
@property(strong,nonatomic) UILabel* dingDanTiJiaoLabel;
@property(strong,nonatomic) UILabel* chaoShiJieDanLabel;
@property(strong,nonatomic) UILabel* yiShouHuoLabel;
@property(strong,nonatomic) UILabel* dingDanQuXiaoLabel;
@property(strong,nonatomic) UIButton* queRenShouHuoBtn;
@property(strong,nonatomic) UIButton* dianHuaCuiDanBtn;
@property(strong,nonatomic) UIButton* quXiaoDingDanBtn;
@property(strong,nonatomic) UIButton* pingJiaBtn;
@property(strong,nonatomic) UIButton* dingDanTousuBtn;
@property(strong,nonatomic) UIProgressView* progress;
@end
