//
//  MainViewController.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "MainViewController.h"
#import "GlobalDef.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize mainTableView;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"---------------%d------------------",indexPath.row);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    UILabel *labl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 40)];
    labl.backgroundColor = [UIColor clearColor];
    labl.tag = indexPath.row;
    labl.textColor = [UIColor blackColor];
    labl.text = [arr objectAtIndex: indexPath.row];
    [cell addSubview:labl];
    [labl release];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 9;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBar];
    [self setTableView];
}

- (void)setTableView{
//    mainTableView.scrollEnabled = YES;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    arr = [[NSArray alloc] initWithObjects:@"金刚经 第一章",@"金刚经 第二章",@"金刚经 第三章",@"金刚经 第四章",@"金刚经 第五章",@"金刚经 第六章",@"金刚经 第七章",@"金刚经 第八章",@"金刚经 第九章",@"金刚经 第十章",@"金刚经 第十一章",@"金刚经 第十二章", nil];
}

- (void)setNavigationBar{
    self.navigationController.navigationBar.tintColor = NAV_BAR_ITEM_COLOR;
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage: forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar_ios5.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UILabel *label = [AppDelegate createNavTitleView:APP_TITLE];
    self.navigationItem.titleView = label;
    [label release];

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

- (void)dealloc {
    [mainTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMainTableView:nil];
    [super viewDidUnload];
}
@end
