//
//  MainViewController.h
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arr;
}
@property (retain, nonatomic) IBOutlet UITableView *mainTableView;

@end
