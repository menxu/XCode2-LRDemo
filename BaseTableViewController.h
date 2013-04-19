//
//  BaseTableViewController.h
//  LRDemo
//
//  Created by menxu on 13-4-18.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parser.h"
#import "EGORefreshTableHeaderView.h"

#define SECTION_LENGTH 20 //TableView每次Load的Item数目

@interface BaseTableViewController : UIViewController<ParserDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>{
    Parser *parser;
    NSMutableArray *blogItemsCached;
    NSMutableArray *blogItems;
    
    BOOL _needRefreshed;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    UIActivityIndicatorView *activityIndicator;
    int blogCountBeforeLoading; //分段请求前的文章数，用于记录是否请求完所有服务器的文章
    NSDate *_lastUpDate;
    
    NSIndexPath *selectID;
    id delegate;
    
    //是否允许显示作者面板，由父控制器具体控制，默认不允许
    BOOL allowShowAuthorPanel;
}
// Reset and reparse
- (void)refresh;
// Properties
@property (nonatomic, retain) NSMutableArray *blogItems;
@property (nonatomic, retain) Parser *parser;
@property (nonatomic, assign) id delegate;


@property (retain, nonatomic) IBOutlet UITableView *baseTableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, retain) NSDate *lastUpDate;
@property (nonatomic, retain) NSIndexPath *selectID;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

@protocol BaseTableViewControllerDelegate

- (void)baseTableViewDidScroll:(BaseTableViewController *)baseTableViewController;
- (void)baseTableViewController:(BaseTableViewController *)baseTableViewController
         viewForHeaderInSection:(NSInteger)section;
@end
