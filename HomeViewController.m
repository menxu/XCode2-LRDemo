//
//  HomeViewController.m
//  LRDemo
//
//  Created by menxu on 13-4-19.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "HomeViewController.h"
#import "GlobalDef.h"
#import "LRDemoAPI.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	[self setNavigationBar];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
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

#pragma mark blog
- (BOOL)getBlogList:(NSInteger)startPosition length:(NSInteger)length useCacheFirst:(BOOL)useCacheFirst{
    self.parser = [LRDemoAPI getBlogList:nil
                                tagArray:[NSArray arrayWithObject:BLOG_TAG]
                           startPosition:startPosition
                                  length:length
                                delegate:self
                           useCacheFirst:useCacheFirst];
    
    return self.parser != nil;
}

#pragma mark -
#pragma mark ParserDelegate
-(void)parser:(Parser *)aParser didFailWithFinish:(NSMutableArray *)blogList {
    [super parser:aParser didFailWithFinish:blogList];
}
-(void)parser:(Parser *)aParser didFailWithError: (NSString *)error {
    [super parser:aParser didFailWithError:error];
}

#pragma mark basetableViewcontroller method
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    self.lastUpDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastestViewControllerUpdateTime"];
    
    if (_lastUpDate == nil) {
        self.lastUpDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:self.lastUpDate forKey:@"LastestViewControllerUpdateTime"];
    }
    
    return _lastUpDate;
}
- (void)refresh{
    [super refresh];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastestViewControllerUpdateTime"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
