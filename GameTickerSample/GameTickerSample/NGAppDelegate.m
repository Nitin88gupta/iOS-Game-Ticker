//
//  NGAppDelegate.m
//  GameTickerSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGAppDelegate.h"
#import "NGTickerModal.h"
#import "NGGameTicker.h"

@implementation NGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [self addAppDelegateTicker];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    [self removeTickerForAppDelegate];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self removeTickerForAppDelegate];

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
    [self removeTickerForAppDelegate];

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - AppDelegate Ticker Related
/*! Adding Ticker*/
- (void) addAppDelegateTicker {
    [self removeTickerForAppDelegate];
    if (!_ticker) {
        _ticker = [[NGTickerModal alloc] initWithTarget:self forSelector:@selector(updateAppDelegateTicker) withInterval:1.0];//Every 1 Sec.
        [self addTickToGameTicker:_ticker];
    }
}

/*! Removing Ticker */
- (void) removeTickerForAppDelegate {
    if (_ticker) {
        [self removeTickFromGameTicker:_ticker];
        _ticker = nil;
    }
}

/*! Update Ticker Method*/
- (void) updateAppDelegateTicker {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - Game Ticker Related
- (void) addTickToGameTicker:(NGTickerModal *) _tickModal {
    BOOL result = [[NGGameTicker sharedGameTicker] addTick:_tickModal];
    if (!result) {
        NSLog(@"Adding Ticker Failed");
    } else {
        NSLog(@"Adding Ticker Success");
    }
}

- (void) removeTickFromGameTicker:(NGTickerModal *) _tickModal {
    [[NGGameTicker sharedGameTicker] removeTick:_tickModal];
}

@end
