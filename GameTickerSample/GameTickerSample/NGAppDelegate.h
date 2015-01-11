//
//  NGAppDelegate.h
//  GameTickerSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NGTickerModal;

@interface NGAppDelegate : UIResponder <UIApplicationDelegate> {
    NGTickerModal *_ticker;
}

@property (strong, nonatomic) UIWindow *window;

- (void) updateAppDelegateTicker;

- (void) addTickToGameTicker:(NGTickerModal *) _tickModal ;

- (void) removeTickFromGameTicker:(NGTickerModal *) _tickModal;

@end
