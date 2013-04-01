//
//  LeftViewController.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

@synthesize tableView;
@synthesize nameLabel;
@synthesize userAvatarImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameLabel:nil];
    userAvatarImageView = nil;
    [super viewDidUnload];
}
- (IBAction)showHome:(UIButton *)sender {
}

- (IBAction)showCategory:(UIButton *)sender {
}

- (IBAction)showBlog:(UIButton *)sender {
}

- (IBAction)showSetting:(UIButton *)sender {
}

- (IBAction)userAvatarButtonClick:(UIButton *)sender {
}
@end
