//
//  AppDelegate.h
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "IIViewDeckController.h"
#import "MBProgressHUD.h"

#define BLOG_TAG @"博客首页"
#define APP_TITLE BLOG_TAG
#define TAG_ARRAY @"World", @"USA", @"Business", @"Education", @"Health", @"Entertainment", @"Science and Technology", @"American Mosaic", @"Explorations", @"In the News", @"People in America", @"Science in the News", @"This is America", @"Words and Their Stories", @"American Stories"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) MainViewController *mainViewController;
@property (retain, nonatomic) UINavigationController *centerViewController;
@property (retain, nonatomic) IIViewDeckController* deckController;

@property (nonatomic, retain) MBProgressHUD *HUD;

+ (UILabel*)createNavTitleView:(NSString *)title;
+ (AppDelegate *)sharedAppDelegate;

- (void)showNetworkFailed:(UIView *)view;
- (void)showInformation:(UIView *)view info:(NSString *)info;

- (void)showProgress:(UIView *)view info:(NSString *)info;
- (void)setProgress:(UIView *)view progress:(float)progress info:(NSString *)info;

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;
@end
