//
//  RightViewController.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "RightViewController.h"
#import "GlobalDef.h"
#import "RightTableViewCell.h"

@interface RightViewController ()

@end

@implementation RightViewController

@synthesize tagList, rightTableView, tableViewCell, tableViewCellNib;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (void)initTableView{
//    CGRect rc = self.view.frame;
//    self.tableView = [[[UITableView alloc] initWithFrame:rc style:UITableViewStylePlain] autorelease];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
    self.rightTableView.scrollsToTop = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tagList            = [NSArray arrayWithObjects:@"VOA Special", TAG_ARRAY, nil];
    self.tableViewCellNib   = [UINib nibWithNibName:@"TagTableViewCell" bundle:nil];
    self.rightTableView.scrollsToTop = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.tagList = nil;
    RELEASE_SAFELY(tableViewCell);
    RELEASE_SAFELY(tableViewCellNib);
    self.rightTableView = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    self.rightTableView = nil;
    [super viewDidUnload];
}


#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return [tagList count];
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section)
        return NSLocalizedString (@"博客栏目",@"");
    else {
        return @"";
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.0 + 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = [self tableView:self.rightTableView titleForHeaderInSection:section];
    
    UIImageView *headBgView = [[[UIImageView alloc] init] autorelease];
    headBgView.frame = CGRectMake(0, 5, 120, 32);
    headBgView.image = [[UIImage imageNamed:@"tableViewSection_bg.png"]
                        stretchableImageWithLeftCapWidth:2
                        topCapHeight:2];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:headBgView.frame];
    [sectionView addSubview:headBgView];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:headBgView.frame] autorelease];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    [sectionView addSubview:label];
    
    return [sectionView autorelease];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIndentifier = @"RightTableViewCell";
	
    RightTableViewCell *cell = (RightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
	if(cell==nil)
	{
		NSArray *nibsArray=[[NSBundle mainBundle] loadNibNamed:@"RightTableViewCell" owner:self options:nil];
		cell=(RightTableViewCell*)[nibsArray objectAtIndex:0];
	}
	
	
//    RightTableViewCell *cell = (RightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
//    
//    static NSString *CellIndentifier = @"RightTableViewCell";
//    RightTableViewCell *cell = (RightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
//    
//    if (cell == nil) {
//        cell = [[[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier] autorelease];
//    }
    
    
    [cell setBackgroundImage:nil];
    NSString *tag = @"";
    if (indexPath.section == 0) {
        tag = [tagList count] == 0 ? @"" : [tagList objectAtIndex:indexPath.row];
    }
    NSString *imageFileName = @"tag.png";
    [cell setIcon:[UIImage imageNamed:imageFileName]];
    [cell setName:tag];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    backgroundView.backgroundColor = TAG_SELECTED_BACKGROUND;
    cell.selectedBackgroundView = backgroundView;
    [backgroundView release];
    
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MainViewController* mainController = [[EnglishFunAppDelegate sharedAppDelegate] mainViewController];
//    [mainController setArticleTag:[self.tagList objectAtIndex:indexPath.row]];
//    
//    self.viewDeckController.centerController = [[EnglishFunAppDelegate sharedAppDelegate] centerViewController];
//    [self.viewDeckController toggleRightView];
}
@end
