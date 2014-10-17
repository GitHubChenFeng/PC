//
//  CFAppDelegate.m
//  PC
//
//  Created by MacBook Pro on 14-8-31.
//  Copyright (c) 2014年 Macbook Pro. All rights reserved.
//

#import "CFAppDelegate.h"


@implementation CFAppDelegate
@synthesize delegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self baiduMapViewInit];
    
    _CfrootViewCtl = [[CFViewController alloc]init];

    [self initConfigData];
    
    
    self.window.rootViewController = _CfrootViewCtl;
   
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)baiduMapViewInit{
    
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:kBaiduKey generalDelegate:nil];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
 
    
}

- (void)initConfigData{
    [ManageCenter shareManager].URLSTR = accessServiceUrl;
    
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

@end
