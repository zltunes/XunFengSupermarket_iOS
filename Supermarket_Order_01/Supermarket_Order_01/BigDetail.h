//
//  BigDetail.h
//  Final1
//
//  Created by 浩然 on 15/8/24.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BigDetailDelegate <NSObject>

- (void)selectCancel;
- (void)bigDetailInit;
- (void)detailLeftBtnSelect:(id)sender;
- (void)detailRightBtnSelect:(id)sender;

@end

@interface BigDetail : UIView
@property (nonatomic)UILabel *upLabel;
@property (nonatomic)UILabel *downLabel;
@property (nonatomic)UILabel *priceLabel;
@property (nonatomic)UILabel *num;
@property (nonatomic)UIButton *leftBtn;
@property (nonatomic)UIButton *rightBtn;
@property (nonatomic)UIImageView *picImage;
@property (nonatomic,weak)id <BigDetailDelegate>delegate;
@end
