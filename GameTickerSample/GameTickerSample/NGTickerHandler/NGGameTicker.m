//
//  NGEnum.h
//  NGGameKit
//
//  Created by Nitin Gupta on 23/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGGameTicker.h"
#import "NGTickerModal.h"

static NGGameTicker *sharedInstance = nil;

@implementation NGGameTicker

+ (instancetype) sharedGameTicker {
    @synchronized(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[NGGameTicker alloc] initTicker];
        });
        return sharedInstance;
    }
}

- (id) init {
    
    NSAssert(NO, @"NGGameTicker: Init not supported.");
#if !__has_feature(objc_arc)
    //Do manual memory management...
	[self release];
#else
    //Usually do nothing...
#endif
	return nil;
}

- (id) initTicker {
    if ( (self = [super init]) ) {
        _tickActionArray = [[NSMutableArray alloc] init];
        _tickRemovalArray = [[NSMutableArray alloc] init];
        _currentTimeStamp = 0;
        [self resumeGameTicker:0];
    }
    return self;
}

- (long) pauseGameTicker {
    
    if ([_mainTickTimer isValid]) {
        [_mainTickTimer invalidate];
        _mainTickTimer = nil;
    }
    
    [_tickRemovalArray removeAllObjects];
    [_tickActionArray removeAllObjects];
    return _currentTimeStamp;
}

- (void) resumeGameTicker:(long) _timeStamp {
    if (!_mainTickTimer) {
        _mainTickTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1]
                                                  interval:Game_Ticker_Fps
                                                    target:self
                                                  selector:@selector(update:)
                                                  userInfo:nil
                                                   repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_mainTickTimer forMode:NSDefaultRunLoopMode];
        _currentTimeStamp = _timeStamp;
        _timerCounter = 0.0;
    }
}

#pragma mark dealloc method
- (void) dealloc {
    _tickActionArray = nil;
#if !__has_feature(objc_arc)
    //Do manual memory management...
    if (_tickActionArray) {
        [_tickActionArray release];
        _tickActionArray = nil;
    }
    [super dealloc];
#else
    //Usually do nothing...
#endif
}


#pragma mark Add and Delete Tick Methods
- (BOOL) addTick:(id) _tickModal {
    if (_tickActionArray && _tickModal) {
        [_tickActionArray addObject:_tickModal];
        return TRUE;
    }
    return FALSE;
}

- (void) removeTick:(id) _tickModal {
    if (_tickRemovalArray && _tickModal) {
        [_tickRemovalArray addObject:_tickModal];
    }
}


#pragma mark Get Time Stamp methods
- (long) getCurrentTimeStampValue {
    return _currentTimeStamp;
}


#pragma mark Main Update Method
- (void) update:(NSTimer *) _timer {

    _timerCounter += [_timer timeInterval];
    if (_timerCounter > 1) {
        _currentTimeStamp += 1;
        _timerCounter = _timerCounter - 1.0;
    }
    
    for (NGTickerModal *_tickModal in _tickRemovalArray) {
        if ([_tickActionArray containsObject:_tickModal]) {
            [_tickActionArray removeObject:_tickModal];
        }
    }
    [_tickRemovalArray removeAllObjects];
    
    for (NGTickerModal *_tickModal in _tickActionArray) {
        [_tickModal updateTick:[_timer timeInterval]];
    }
}

@end
