//
//  ViewController.h
//  Start_Me_Up_New
//
//  Created by xmhouse on 9/11/13.
//  Copyright (c) 2013 xmhouse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderAppDelegate.h"

@protocol PraiseDelegate <NSObject>
@optional
- (void)choujiang;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end


@interface PraiseView : UIView<UIAlertViewDelegate>
{
    UIControl   *_overlayView;
    OrderAppDelegate* appdelegate;
    NSString* couponCreateURL;
    NSMutableDictionary* couid_dict;
}
@property int cou_price;
@property float random;
@property float orign;
@property int order_id;
@property(strong,nonatomic) UIImageView *imageView1;
@property(strong,nonatomic) UIImageView *imageView2;
@property(nonatomic,assign)id <PraiseDelegate> delegate;
@property(nonatomic,strong)UITapGestureRecognizer *singleTap;
- (void)show;

@end
