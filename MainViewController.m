//
//  MainViewController.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "MainViewController.h"
#import "GlobalDef.h"
#import "LRDemoAPI.h"
#import "LRTableViewCell.h"
#import "Client.h"

@interface MainViewController ()
@end

@implementation MainViewController

@synthesize arr = _arr;
@synthesize mainTableView;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---------------%d------------------",indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"LRTableViewCell";
    LRTableViewCell *tableViewCell = (LRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[[LRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        UIView *backgroundView = [[UIView alloc] initWithFrame:tableViewCell.frame];
        backgroundView.backgroundColor = SELECTED_BACKGROUND;
        tableViewCell.selectedBackgroundView = backgroundView;
        [backgroundView release];
    }
    
    Blog *blog = [self.arr count] == 0 ? nil : [self.arr objectAtIndex:indexPath.row];
    if (blog) {
        [tableViewCell setDataSource:blog];
    }
    return tableViewCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    NSLog(@"%d : count ", [self.arr count]);
    return [self.arr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)viewDidLoad
{
    [self initDate];
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self setTableView];
}

-(void)initDate{
    [self refresh];
}

- (void)setTableView{
    mainTableView.scrollEnabled = YES;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

- (void)setNavigationBar{
    self.navigationController.navigationBar.tintColor = NAV_BAR_ITEM_COLOR;
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage: forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_ios5.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UILabel *label = [AppDelegate createNavTitleView:APP_TITLE];
    self.navigationItem.titleView = label;

    UIButton *buttonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    [buttonLeft setImage:[UIImage imageNamed:@"ButtonMenu"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];

    self.navigationItem.leftBarButtonItem = itemLeft;
    [itemLeft release];

    UIButton *buttonRight = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 30)];
    [buttonRight setImage:[UIImage imageNamed:@"offlineDownload"] forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(showDownloader) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];

    self.navigationItem.rightBarButtonItem = itemRight;
    [itemRight release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)showLeft{
    [self.viewDeckController toggleLeftView];
}

#pragma mark blog
- (void)refresh{
    [self getBlogList:0 length:SECTION_LENGTH useCacheFirst:NO];
}
- (void)getBlogList:(NSInteger)startPosition length:(NSInteger)length useCacheFirst:(BOOL)useCacheFirst
{
    [LRDemoAPI getBlogList:nil
                  tagArray:[NSArray arrayWithObject:BLOG_TAG]
             startPosition:startPosition
                    length:length
                  delegate:self
             useCacheFirst:useCacheFirst];
}

- (void)showDownloader{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"离线下载", @"")
                                                   message:NSLocalizedString(@"需要下载文章中附带的音频么", @"")
                                                  delegate:self
                                         cancelButtonTitle:NSLocalizedString(@"取消", @"")
                                         otherButtonTitles:NSLocalizedString(@"下载", @""),NSLocalizedString(@"不下载", @""),nil];
    view.tag = 1;
    [view show];
    [view release];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)delayDidFinishedLoading
{
    //  model should call this when its done loading
}
- (void)doneLoadingTableViewData {
    [self performSelector:@selector(delayDidFinishedLoading)
               withObject:nil
               afterDelay:.5];  
}
#pragma mark -
#pragma mark ParserDelegate
-(void)parser:(Parser *)parser didFailWithFinish:(NSArray *)blogList{
    self.arr = blogList;
    [self.mainTableView reloadData];
    [self doneLoadingTableViewData];
}

-(void)parser:(Parser *)parser didFailWithError: (NSString *)error{
    
}

- (void)dealloc {
    [arr release];
    arr = nil;
    [mainTableView release];
    mainTableView = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
