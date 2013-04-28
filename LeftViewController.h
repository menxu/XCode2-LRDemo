//
//  LeftViewController.h
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController{
    IBOutlet UITableView *tableView;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *userAvatarImageView;
    
    IBOutlet UILabel *homeLabel;
    IBOutlet UILabel *categoryLabel;
    IBOutlet UILabel *blogLabel;
    IBOutlet UILabel *settingLabel;
    
}
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UIImageView *userAvatarImageView;

- (IBAction)showHome:(UIButton *)sender;
- (IBAction)showCategory:(UIButton *)sender;
- (IBAction)showBlog:(UIButton *)sender;
- (IBAction)showSetting:(UIButton *)sender;


- (IBAction)userAvatarButtonClick:(UIButton *)sender;

- (void)refresh;
@end
