//
//  HelpTableViewCell.h
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/14.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *textlabel;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_up;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_down;
@property (nonatomic, retain) IBOutlet UIImageView *leftimg;
@property (nonatomic)  BOOL isOpen;


- (void) setOpen;
- (void) setClosed;
-(void)setIntroductionText:(NSString*)text;
@end
