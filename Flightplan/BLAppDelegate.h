//
//  BLAppDelegate.h
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#define BLApp ((BLAppDelegate *)app)

@interface BLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNavController;

@end

extern BLAppDelegate *app;