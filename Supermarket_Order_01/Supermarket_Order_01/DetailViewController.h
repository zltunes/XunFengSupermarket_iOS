//
//  DetailViewController.h
//  Final1
//
//  Created by 张悦心 on 15/7/7.
//  Copyright (c) 2015年 ZHR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong,nonatomic)NSMutableArray *marketDeArray;
@property (strong,nonatomic)NSString *barName;
//后台url
@property (nonatomic)NSString *url;
//搜索url
@property (nonatomic)NSString *urlSearch;
//超市id
@property (nonatomic)int marId;
@end
