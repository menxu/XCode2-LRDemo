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


@implementation AppDelegate

@synthesize window;
@synthesize mainViewController;
@synthesize centerViewController;
@synthesize deckController;

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



//    self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
//    RightViewController* rightController = [[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
//
//    ViewController *centerController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
//    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerController
//                                                                                    leftViewController:self.leftController
//                                                                                   rightViewController:rightController];
//    deckController.rightSize = 100;
//    deckController.leftSize = 80;
//
//    /* To adjust speed of open/close animations, set either of these two properties. */
//    // deckController.openSlideAnimationDuration = 0.15f;
//    // deckController.closeSlideAnimationDuration = 0.5f;
//
//    self.window.rootViewController = deckController;