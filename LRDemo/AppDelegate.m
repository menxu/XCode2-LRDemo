//
//  AppDelegate.m
//  LRDemo
//
//  Created by menxu on 13-3-22.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "GlobalDef.h"


@implementation AppDelegate

@synthesize HUD;

@synthesize window;
@synthesize homeViewController;
@synthesize centerViewController;
@synthesize deckController;


+ (UILabel*)createNavTitleView:(NSString *)title {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = NAVIGATION_TEXT_COLOR;
    [label sizeToFit];
    
    return [label autorelease];
}


- (void)setupMainView_iPhone
{
    
    // Left & Right
//    LeftViewController *leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
//    RightViewController * rightController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    LeftViewController *leftController = [[LeftViewController alloc] init];
    RightViewController * rightController = [[RightViewController alloc] init];
    
    self.homeViewController = [[[HomeViewController alloc] init] autorelease];
    
    self.centerViewController = [[[UINavigationController alloc] initWithRootViewController:self.homeViewController] autorelease];
    
    self.deckController =  [[[IIViewDeckController alloc] initWithCenterViewController:self.centerViewController
                                                                    leftViewController:leftController
                                                                   rightViewController:rightController] autorelease];
    [leftController release];
    [rightController release];
    
    self.deckController.leftLedge = 160;
    self.deckController.rightLedge = 90;
    
    self.window.rootViewController = self.deckController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease] ;
    [self setupMainView_iPhone];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark -
#pragma mark Application lifecycle

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

- (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix
{
    NSString *  result;
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", prefix, uuidStr]];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}
- (void)showNetworkFailed:(UIView *)view {
    [self showInformation:view info:NSLocalizedString(@"网络连接失败，请检查网络...", @"")];
}
- (void)showInformation:(UIView *)view info:(NSString *)info {
    if (HUD) {
        [HUD removeFromSuperview];
        RELEASE_SAFELY(HUD);
    }
    
    if (view == nil) {
        view = [[AppDelegate sharedAppDelegate] window];
    }
    
    if (HUD == nil) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]] autorelease];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        if ([info length] > 12) {
            HUD.detailsLabelText = info;
            HUD.detailsLabelFont = [UIFont systemFontOfSize:16];
        }
        else {
            HUD.labelText = info;
            HUD.labelFont = [UIFont systemFontOfSize:18];
        }
    }
    
    if ([view isKindOfClass:[UIWindow class]]) {
        [view addSubview:HUD];
    }
    else {
        [view.window addSubview:HUD];
    }
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.0];
}

- (void)showProgress:(UIView *)view info:(NSString *)info {
    
    if (HUD) {
        [HUD removeFromSuperview];
        RELEASE_SAFELY(HUD);
    }
    
    HUD = [[MBProgressHUD showHUDAddedTo:view ? view : [[AppDelegate sharedAppDelegate] window] animated:YES] retain];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    HUD.labelText = info;
}

- (void)setProgress:(UIView *)view progress:(float)progress info:(NSString *)info {
    if (HUD == nil)
        return;
    
    HUD.progress = progress;
    HUD.labelText = info;
    
    if (progress >= 1.0) {
        [HUD hide:YES afterDelay:1.0];
    }
}


- (void)dealloc {
    [centerViewController release];
    self.centerViewController = nil;
    self.HUD = nil;
    [window release];
    [super dealloc];
}
@end


@implementation UINavigationBar (Customization)

- (void)drawRect:(CGRect)rect {
    // Add a custom background image to the navigation bar
    UIImage *image = [UIImage imageNamed:@"NavBar.png"];
    [image drawInRect:CGRectMake(0,
                                 0,
                                 self.bounds.size.width,
                                 self.bounds.size.height)];
}

@end