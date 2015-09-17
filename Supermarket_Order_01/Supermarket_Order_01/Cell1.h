
#import <UIKit/UIKit.h>

@interface Cell1 : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)IBOutlet UIImageView *arrowImageView;

- (void)changeArrowWithUp:(BOOL)up;
@end
