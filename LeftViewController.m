//
//  LeftViewController.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LeftViewController.h"
#import "ImageCacher.h"

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
    CGRect rc = self.view.frame;
    rc.origin.y = 0;
    self.view.frame = rc;
    
    NSDictionary *userInfo = [[[NSDictionary alloc] init] autorelease];
    
    NSString *nickName = [userInfo objectForKey:@"nickName"];
    
    nickName = [nickName length] ? nickName : NSLocalizedString(@"点击设置昵称", @"匿名");
    self.nameLabel.text = nickName;
    
    NSString *image_Url = [userInfo objectForKey:@"photoUrl"];
    if (!hasCachedImage(image_Url)) {
        NSLog(@"userAvatartImageView:     ----    yes");
        [self.userAvatarImageView setImage:[UIImage imageWithContentsOfFile:pathForURL(image_Url)]];
    }else{
        [self.userAvatarImageView setImage:[UIImage imageNamed:@"Avatar1.png"]];
        NSLog(@"userAvatartImageView:     ----    no");
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:image_Url,@"url",self.userAvatarImageView,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
    
    homeLabel.text = NSLocalizedString(@"首页", @"");
    categoryLabel.text = NSLocalizedString(@"分类", @"");
    blogLabel.text = NSLocalizedString(@"我的博客", @"");
    settingLabel.text = NSLocalizedString(@"设置", @"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameLabel:nil];
    userAvatarImageView = nil;
    
    [tableView release];
    [nameLabel release];
    [userAvatarImageView release];
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
