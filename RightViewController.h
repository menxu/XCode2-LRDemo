//
//  RightViewController.h
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightTableViewCell.h"

@interface RightViewController : UIViewController

@property (retain, nonatomic) NSArray               *tagList;
@property (retain, nonatomic) IBOutlet UITableView  *rightTableView;
@property (retain, nonatomic) RightTableViewCell    *tableViewCell;
@property (retain, nonatomic) UINib                 *tableViewCellNib;
@end
