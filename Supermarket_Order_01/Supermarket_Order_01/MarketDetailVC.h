//
//  MarketDetailVC.h
//  Final1
//
//  Created by 浩然 on 15/7/21.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketDetailVC : UIViewController{
    NSString *sendTime;
    NSString *minPrice;
    NSString *marketAddr;
    NSString *timePoint;

}

@property (nonatomic)NSString *url;
@property (nonatomic)NSInteger marId;


@end
