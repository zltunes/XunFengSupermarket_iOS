//
//  DiYuListViewController.m
//  IYLM
//
//  Created by Jian-Ye on 12-10-30.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "HelpViewController.h"
#import "Cell1.h"
#import "Cell2.h"
@interface HelpViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataList;
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    
}
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;

@property (nonatomic,retain)IBOutlet UITableView *expansionTableView;
@end

@implementation HelpViewController
@synthesize isOpen,selectIndex;

- (void)dealloc
{
    _dataList = nil;
    self.expansionTableView = nil;
    self.isOpen = NO;
    self.selectIndex = nil;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"帮助"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
//    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
//    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
//    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [backitem setCustomView:self.backbtn];
//    [navitem setLeftBarButtonItem:backitem];
    
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    

    NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData" ofType:@"plist"];
    _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@",path);
    
    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
    
    [self hideExcessLine:self.expansionTableView];
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            return [[[_dataList objectAtIndex:section] objectForKey:@"list"] count]+1;;
        }
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        return 100;
    }else{
        return 40;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
        cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
        [cell.titleLabel sizeToFit];
        cell.titleLabel.textColor = [UIColor redColor];
        NSArray *answer = [[_dataList objectAtIndex:self.selectIndex.section]objectForKey:@"answer"];
        cell.textview.text = [answer objectAtIndex:indexPath.row-1];
        cell.textview.editable = NO;
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"name"];
        cell.titleLabel.text = name;
        if (!indexPath.section) {
            UIImage* img = [UIImage imageNamed:@"help1.png"];
            img = [self reSizeImage:img  toSize:CGSizeMake(30, 30)];
            cell.imageView.image = img;
        }else if (indexPath.section==1){
            UIImage* img = [UIImage imageNamed:@"help2.png"];
            img = [self reSizeImage:img  toSize:CGSizeMake(30, 30)];
            cell.imageView.image = img;
        }else if (indexPath.section==2){
            UIImage* img = [UIImage imageNamed:@"help3.png"];
            img = [self reSizeImage:img  toSize:CGSizeMake(30, 30)];
            cell.imageView.image = img;
        }else if (indexPath.section==3){
            UIImage* img = [UIImage imageNamed:@"help4.png"];
            img = [self reSizeImage:img  toSize:CGSizeMake(30, 30)];
            cell.imageView.image = img;
        }
        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
        return cell;
    }
}
-(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
-(void)hideExcessLine:(UITableView *)tableView{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
            
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
                
            }else
            {
                
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else
    {
        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
        NSArray *list = [dic objectForKey:@"list"];
        NSString *item = [list objectAtIndex:indexPath.row-1];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.expansionTableView beginUpdates];
    
    int section = self.selectIndex.section;
    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i < contentCount + 1; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    if (firstDoInsert)
    {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.expansionTableView endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [self.expansionTableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
