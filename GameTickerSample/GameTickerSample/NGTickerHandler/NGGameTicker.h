//
//  NGEnum.h
//  NGGameKit
//
//  Created by Nitin Gupta on 23/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! The Minimum value for the game ticker is 1/10.0f */
#define Game_Ticker_Fps 0.1f

@interface NGGameTicker : NSObject  {
    
    /*! Main scheduler */
    NSTimer                     *_mainTickTimer;
    
    /*! Tick Modal Array */
    NSMutableArray              *_tickActionArray;
    
    /*! nshedule Array from Main Timer */
    NSMutableArray              *_tickRemovalArray;
    
    /*! Current Time Stamp */
    long                        _currentTimeStamp;
    
    /*! Tme Stamp Counter */
    float                       _timerCounter;
}

/*! Shared Game Ticker*/
+ (instancetype) sharedGameTicker;

/*! Initialize Game Ticker */
- (id) initTicker;

/*! Pasue/Stop Game Timer */
- (long) pauseGameTicker;

/*! Resume/Reinit Game Timer */
- (void) resumeGameTicker:(long) _timeStamp;

/*! Get Current time stamp[ value */
- (long) getCurrentTimeStampValue;

/*! Add New Tick to Update */
- (BOOL) addTick:(id) _tickModal;

/*! Remove Tick From Update */
- (void) removeTick:(id) _tickModal;


@end
