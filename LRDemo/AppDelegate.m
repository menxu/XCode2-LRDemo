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

@synthesize window;
@synthesize mainViewController;
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
    
    return label;
}


- (void)setupMainView_iPhone
{
    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    // Left & Right
    LeftViewController *leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    RightViewController * rightController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    self.centerViewController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    
    self.deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerViewController
                                                                    leftViewController:leftController
                                                                   rightViewController:rightController];
    
    self.deckController.leftLedge = 160;
    self.deckController.rightLedge = 90;
    
    self.window.rootViewController = self.deckController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setupMainView_iPhone];
    [self.window makeKeyAndVisible];
    return YES;
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