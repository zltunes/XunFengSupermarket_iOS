//
//  HelpViewController.m
//  mysupermarket
//
//  Created by 程茹洁 on 15/8/14.
//  Copyright (c) 2015年 程茹洁. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"
@interface HelpViewController (){
    UINavigationBar *navbar;
    UINavigationItem*navitem;
    NSMutableArray *textarr;
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    navbar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navbar.barTintColor=[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0];
    textarr=[[NSMutableArray alloc]initWithCapacity:1];
    [textarr addObject:@"此刻，为3500万伤亡同胞转发！日本投降！】今天，8月15日，值得每个中国人铭记！70年前，日本宣布无条件投降！抗日战争，日寇竭尽烧杀淫掠之能事，3500万同胞伤亡，但同胞一刻也没放弃抵抗！此刻，无论你在何处，一起向牺牲的中国军民致敬，致哀，转！勿忘国耻！via央视新闻"];
     [textarr addObject:@"此刻，为3500万伤亡同胞转发！日本投降！】今天，8月15日，值得每个中国人铭记！70年前，日本宣布无条件投降！抗日战争，日寇竭尽烧杀淫掠之能事，3500万同胞伤亡，但同胞一刻也没放弃抵抗！此刻，无论你在何处，一起向牺牲的中国军民致敬，致哀，转！勿忘国耻！via央视新闻"];
     [textarr addObject:@"此刻，为3500万伤亡同胞转发！日本投降！】今天，8月15日，值得每个中国人铭记！70年前，日本宣布无条件投降！抗日战争，日寇竭尽烧杀淫掠之能事，3500万同胞伤亡，但同胞一刻也没放弃抵抗！此刻，无论你在何处，一起向牺牲的中国军民致敬，致哀，转！勿忘国耻！via央视新闻"];
    UIImageView *view1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [view1 setBackgroundColor:[UIColor colorWithRed:225.0/255.0 green:117.0/255.0 blue:68.0/255.0 alpha:1.0]];
    [navbar addSubview:view1];
    navitem=[[UINavigationItem alloc]initWithTitle:@"帮助"];
    [navbar pushNavigationItem:navitem animated:NO];
    navitem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    [self.view addSubview:navbar];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                             [UIFont systemFontOfSize:20.0], NSFontAttributeName
                             ,nil];
    navbar.titleTextAttributes=attrdic;
    UIBarButtonItem *backitem=[[UIBarButtonItem alloc]init];
    self.backbtn=[[UIButton alloc]initWithFrame:CGRectMake(9, 30,20.5, 33)];
    [self.backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backitem setCustomView:self.backbtn];
    [navitem setLeftBarButtonItem:backitem];
    
    self.view.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];

    
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 38*4)];
    [self.view addSubview:self.tableview];
    self.tableview.dataSource=self;
    self.tableview.delegate=self;
    [self.tableview registerClass:[HelpTableViewCell class] forCellReuseIdentifier:@"DropDownCell"];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Do any additional setup after loading the view.
}

-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.row==1){
        /* CGSize size = CGSizeMake(300, 1000);
        CGSize labelSize = [[textarr objectAtIndex:[indexPath section]] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        
        return labelSize.height+20;*/
        return  self.view.bounds.size.height-(indexPath.section+1)*38-64;

    }
    else return 38;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (dropDown1Open) {
                return 2;
            }
            else
            {
                return 1;
            }
            break;
            
        case 1:
            if (dropDown2Open) {
                return 2;
            }
            else
            {
                return 1;
            }
        default:
            return 1;
            break;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *DropDownCellIdentifier = @"DropDownCell";
    
    switch ([indexPath section]) {
        case 0: {
            
            switch ([indexPath row]) {
                case 0: {
                    
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView dequeueReusableCellWithIdentifier:DropDownCellIdentifier];
                    
                    if(cell.textlabel==nil){
                        NSLog(@"New Cell Made");
                        
                        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HelpTableViewCell" owner:nil options:nil];
                        
                        for(id currentObject in topLevelObjects)
                        {
                            if([currentObject isKindOfClass:[HelpTableViewCell class]])
                            {
                                cell = (HelpTableViewCell *)currentObject;
                                break;
                            }
                        }
                    
                    }
                    [cell.textlabel setText:@"Option 1"];
                    dropDown1 = @"Option 1";
                    
                    return cell;
                    
                    break;
                }
                default: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                    }
                    
                    NSString *label = @"通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。";
                    [cell textLabel].numberOfLines=0;
                    [[cell textLabel] setText:label];
                    CGRect frame = [cell frame];
    
                    // Configure the cell.
                    return cell;
                    
                    break;
                }
            }
            
            break;
        }
        case 1: {
            
            switch ([indexPath row]) {
                case 0: {
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView dequeueReusableCellWithIdentifier:DropDownCellIdentifier];
                    
                    if(cell.textlabel==nil){
                        NSLog(@"New Cell Made");
                        
                        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HelpTableViewCell" owner:nil options:nil];
                        
                        for(id currentObject in topLevelObjects)
                        {
                            if([currentObject isKindOfClass:[HelpTableViewCell class]])
                            {
                                cell = (HelpTableViewCell *)currentObject;
                                break;
                            }
                        }
                    }
                    
                    [[cell textlabel] setText:@"Option 1"];
                    dropDown2 = @"Option 1";
                    
                    // Configure the cell.
                    return cell;
                    
                    break;
                }
                default: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                    }
                    
                    NSString *label = @"通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。通报：2015年8月13日晚南京市秦淮区长白街460号大个子龙虾店发生火灾后， 该店负责人杨某即被公安机关控制接受调查。目前，火灾中受伤送医的人员有5人因伤势过重，经抢救无效死亡。";
                    
                    [[cell textLabel] setText:label];
                    [cell textLabel].numberOfLines=0;
                    // Configure the cell.
                    return cell;
                    
                    break;
                }
            }
            
            break;
        }
        default:
            
            return nil;
            break;
       }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    switch ([indexPath section]) {
        case 0: {
            
            switch ([indexPath row]) {
                case 0:
                {
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
                    
                   NSIndexPath *path0 = [NSIndexPath indexPathForRow:[indexPath row]+1 inSection:[indexPath section]];
                   /* NSIndexPath *path1 = [NSIndexPath indexPathForRow:[indexPath row]+2 inSection:[indexPath section]];
                    NSIndexPath *path2 = [NSIndexPath indexPathForRow:[indexPath row]+3 inSection:[indexPath section]];*/
                    
                    NSArray *indexPathArray = [NSArray arrayWithObjects:path0,  nil];
                    
                    if ([cell isOpen])
                    {
                        [cell setClosed];
                        dropDown1Open = [cell isOpen];
                        
                       // [tableView deleteRowsAtIndexPaths:path0 withRowAnimation:UITableViewRowAnimationTop];
                        [self.tableview deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
                        self.tableview.frame=CGRectMake(0, 64, self.view.bounds.size.width, 38*4);
                    }
                    else
                    {
                        [cell setOpen];
                        dropDown1Open = [cell isOpen];
                        self.tableview.frame=CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
                        [self.tableview insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
                    }
                    
                    break;
                }
                default:
                {
                    dropDown1 = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:[indexPath section]];
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView cellForRowAtIndexPath:path];
                    
                    [[cell textLabel] setText:dropDown1];
                    
                    break;
                }
            }
            
            break;
        }
        case 1: {
            
            switch ([indexPath row]) {
                case 0:
                {
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
                    
                    NSIndexPath *path0 = [NSIndexPath indexPathForRow:[indexPath row]+1 inSection:[indexPath section]];
                    /*NSIndexPath *path1 = [NSIndexPath indexPathForRow:[indexPath row]+2 inSection:[indexPath section]];
                    NSIndexPath *path2 = [NSIndexPath indexPathForRow:[indexPath row]+3 inSection:[indexPath section]];*/
                    
                    NSArray *indexPathArray = [NSArray arrayWithObjects:path0, nil];
                    
                    if ([cell isOpen])
                    {
                        [cell setClosed];
                        dropDown2Open = [cell isOpen];
                        
                        [self.tableview deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
                    }
                    else
                    {
                        [cell setOpen];
                        dropDown2Open = [cell isOpen];
                        self.tableview.frame=CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64);
                        [self.tableview insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
                    }
                    
                    break;
                }
                default:
                {
                    dropDown2 = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:[indexPath section]];
                    HelpTableViewCell *cell = (HelpTableViewCell*) [tableView cellForRowAtIndexPath:path];
                    
                    [[cell textLabel] setText:dropDown2];
                    
                    // close the dropdown cell
                    
                    NSIndexPath *path0 = [NSIndexPath indexPathForRow:[path row]+1 inSection:[indexPath section]];
                   /* NSIndexPath *path1 = [NSIndexPath indexPathForRow:[path row]+2 inSection:[indexPath section]];
                    NSIndexPath *path2 = [NSIndexPath indexPathForRow:[path row]+3 inSection:[indexPath section]];
                    */
                    NSArray *indexPathArray = [NSArray arrayWithObjects:path0, nil];
                    
                    [cell setClosed];
                    dropDown2Open = [cell isOpen];
                    
                    [self.tableview deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
                    
                    break;
                }
            }
            
            break;
        }
        
        default:
            break;
    }
    
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
