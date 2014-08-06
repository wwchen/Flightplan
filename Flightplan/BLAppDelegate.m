//
//  BLAppDelegate.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAppDelegate.h"
#import "BLDrawerViewController.h"
#import "BLCenterViewController.h"
#import <MMDrawerController/MMDrawerController.h>

@interface BLAppDelegate ()
- (NSArray *)initializeNavigation;
@end

@implementation BLAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BLDrawerViewController *leftDrawer = [[BLDrawerViewController alloc] init];
    BLCenterViewController *center = [[BLCenterViewController alloc] init];
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftDrawer];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:center];
    MMDrawerController *drawerController =[[MMDrawerController alloc] initWithCenterViewController:centerNav
                                                                          leftDrawerViewController:leftNav];
    
    [leftDrawer setDataSource:[self initializeNavigation]];
    [drawerController setShowsShadow:YES];
    [drawerController setMaximumLeftDrawerWidth:160.0f];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:drawerController];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

# pragma mark - initialization
- (NSArray *)initializeNavigation
{
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    
    NSMutableArray *section = [[NSMutableArray alloc] init];
    [section addObject:@"Home"];
    [section addObject:@"Foo"];
    [section addObject:@"Bar"];
    [sections addObject:section];
    
    section = [[NSMutableArray alloc] init];
    [section addObject:@"Settings"];
    [section addObject:@"Hello"];
    [sections addObject:section];
    
    return [NSArray arrayWithArray:sections];
}

@end
