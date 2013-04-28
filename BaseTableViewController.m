//
//  BaseTableViewController.m
//  LRDemo
//
//  Created by menxu on 13-4-18.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GlobalDef.h"
#import "LRTableViewCell.h"
#import "Blog.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

@synthesize blogItems,      parser;
@synthesize baseTableView,  activityIndicator;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize lastUpDate = _lastUpDate;
@synthesize selectID;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initTableView];
    [self initRefreshHeaderView];
    if ([self initActivityIndicator]) {
        return;
    }
    [self initDate];
}

- (void)initTableView{
    CGRect rc = self.view.frame;
    rc.origin.y = 0;
    rc.size.height -= 44;
    self.baseTableView = [[[UITableView alloc] initWithFrame:rc style:UITableViewStylePlain] autorelease];
    self.baseTableView.delegate     = self;
    self.baseTableView.dataSource   = self;
    [self.view addSubview:self.baseTableView];
    
    self.baseTableView.scrollsToTop = YES;
    
    self.baseTableView.rowHeight = 70;
    self.baseTableView.backgroundColor = CELL_BACKGROUND;
    self.baseTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.baseTableView.showsVerticalScrollIndicator = YES;
    self.baseTableView.userInteractionEnabled = YES;
    self.baseTableView.alpha = 1;
}
- (void)initRefreshHeaderView{
    _reloading = NO;
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.baseTableView.bounds.size.height, self.view.frame.size.width, self.baseTableView.bounds.size.height)];
		view.delegate = self;
		[self.baseTableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
	}
	[_refreshHeaderView refreshLastUpdatedDate];
}
- (BOOL)initActivityIndicator{
    activityIndicator.hidesWhenStopped = YES;
    if (self.parser !=nil) {
        if (activityIndicator && [activityIndicator isAnimating]) {
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
        }
        return true;
    }
    return false;
}
- (void)initDate{
    _needRefreshed = NO;
    blogCountBeforeLoading = 0;
    if (blogItems == nil) {
        blogItems = [[NSMutableArray alloc] init];
    }
    if (blogItemsCached == nil) {
        blogItemsCached = [[NSMutableArray alloc] init];
    }
    BOOL result = [self getBlogList:0 length:SECTION_LENGTH useCacheFirst:YES];
    if (result && activityIndicator && ![activityIndicator isAnimating]) {
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_needRefreshed) {
        [self refresh];
    }else{
        NSTimeInterval sec = [self.lastUpDate timeIntervalSinceNow];
        if (sec <= -60 * 60) {
            [self enforceRefresh];
        }
    }
}
- (void)enforceRefresh
{
    [_refreshHeaderView enforceRefresh:self.baseTableView];
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
//    return NO;
//}
- (void)showBlogList {
    
    [self.baseTableView reloadData];
    
    if (activityIndicator)
    {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.hidden = YES;
    }
}
#pragma mark -
#pragma mark ParserDelegate
-(void)parser:(Parser *)parser didFailWithFinish:(NSMutableArray *)blogList{

    [blogItemsCached addObjectsFromArray:blogList];
    if ([blogItemsCached count] == 0 ) {
        
        self.blogItems = [[blogItemsCached copy] autorelease];
        [blogItems release];
        [blogItemsCached removeAllObjects];

        if (_needRefreshed) {
            _needRefreshed = NO;
        }
        
        [self.baseTableView reloadData];
        [self doneLoadingTableViewData];
        return;
    }
    if (blogCountBeforeLoading == [blogItemsCached count] && blogCountBeforeLoading == [blogItems count]) {
        [[AppDelegate sharedAppDelegate] showInformation:self.view info:NSLocalizedString(@"没有更多内容了", @"")];
    }
    self.blogItems = [[blogItemsCached copy] autorelease];
//    [self.baseTableView reloadData];
    [self showBlogList];
    if (_needRefreshed) {
        _needRefreshed = NO;
    }
    [self doneLoadingTableViewData];
    
}
-(void)parser:(Parser *)parser didFailWithError: (NSString *)error{
    [[AppDelegate sharedAppDelegate] showNetworkFailed:self.view];
    
    _needRefreshed = YES;
    
    [self doneLoadingTableViewData];
    [self.baseTableView reloadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidScroll:(UITableView *)scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    [self refresh];
}

- (void)delayDidFinishedLoading{
    //  model should call this when its done loading
	_reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.baseTableView];
}

- (void)doneLoadingTableViewData {	
    [self performSelector:@selector(delayDidFinishedLoading)
               withObject:nil
               afterDelay:.5];    
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    if (_lastUpDate == nil) {
        self.lastUpDate = [NSDate date];
    }
	return _lastUpDate; // should return date data source was last changed
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (blogItems.count == 0)
        return 0;
    return blogItems.count + 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [blogItems count]) {
        
        UITableViewCell *cell = [[[UITableViewCell alloc]
                                  initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:nil] autorelease];
        
        cell.textLabel.text = NSLocalizedString(@"显示下20条", @"");
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.backgroundColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.frame = CGRectMake(90.0f, 23.0f, 25.0f, 25.0f);
        activityView.hidesWhenStopped = YES;
        activityView.tag = 200;
        [cell addSubview:activityView];
        [activityView release];
        
        // set selection color
        UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
        backgroundView.backgroundColor = SELECTED_BACKGROUND;
        cell.selectedBackgroundView = backgroundView;
        [backgroundView release];
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"LRTableViewCell";
    
    LRTableViewCell *blogTableViewCell = (LRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (blogTableViewCell == nil)
    {
        blogTableViewCell = [[[LRTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        
        // set selection color
        UIView *backgroundView = [[UIView alloc] initWithFrame:blogTableViewCell.frame];
        backgroundView.backgroundColor = SELECTED_BACKGROUND;
        blogTableViewCell.selectedBackgroundView = backgroundView;
        [backgroundView release];
    }
    
    // Configure the cell.
    Blog *blog = [blogItems count] == 0 ? nil : [blogItems objectAtIndex:indexPath.row];
    if (blog) {
        [blogTableViewCell setDataSource:blog];
    }
    return blogTableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row >= [blogItems count])
        return 60;
    
    Blog  *blog = [blogItems count] == 0 ? nil : [blogItems objectAtIndex:indexPath.row];
    if (blog) {
        return [LRTableViewCell rowHeightForObject:blog];
    } else {
        return 0.0;
    }
}

#pragma mark -
#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.baseTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [blogItems count]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [(UIActivityIndicatorView *)[cell viewWithTag:200] startAnimating];
            cell.textLabel.text = NSLocalizedString(@"加载中...", @"");
        }
        [self getBlogList:[blogItems count] length:SECTION_LENGTH useCacheFirst:NO];
        blogCountBeforeLoading = [blogItems count];
        return;
    }
//    LRTableViewCell *cell = (LRTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
//        HomeViewController *webViewController = [[HomeViewController alloc] init];
//        webViewController.articleList = articleItems;
//        webViewController.articlePosition = indexPath.row;
//        webViewController.coverImage = cell.coverImageView.image;
//        self.selectID = indexPath;
//        webViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//        [self presentModalViewController:webViewController animated:YES];
//    
//        [webViewController release];
    }
}

// Reset and reparse
- (void)refresh {
    
    if (blogItemsCached)
    {
        [blogItemsCached removeAllObjects];
        blogCountBeforeLoading = 0;
    }
    
    if ([self getBlogList:0 length:SECTION_LENGTH useCacheFirst:NO]) {
        
        if (activityIndicator && ![activityIndicator isAnimating])
        {
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimating];
        }
        
        self.lastUpDate = [NSDate date];
    }
}
- (BOOL)getBlogList:(NSInteger)startPosition length:(NSInteger)length useCacheFirst:(BOOL)useCacheFirst{
    return YES;
}
- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.parser) {
        [self.parser cancel];
    }
    
    [baseTableView release];
    [_refreshHeaderView release];
    
    self.blogItems = nil;
    [blogItemsCached release];
    self.lastUpDate = nil;
    
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBaseTableView:nil];
    [self setRefreshHeaderView:nil];
    [super viewDidUnload];
}
@end
