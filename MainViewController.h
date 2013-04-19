//
//  MainViewController.h
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.

#import <UIKit/UIKit.h>
#import "Parser.h"
#define SECTION_LENGTH 20 //TableView每次Load的Item数目

@interface MainViewController : UIViewController<ParserDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray *arr;
}

@property (nonatomic, retain) NSArray *arr;

@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

@end
