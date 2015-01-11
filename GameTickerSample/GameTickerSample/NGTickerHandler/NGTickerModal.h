//
//  NGEnum.h
//  NGGameKit
//
//  Created by Nitin Gupta on 23/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGTickerModal : NSObject {
    
    /*! Init with target , ***NO Retain/Release***/
    id          _target;
    
    /*! Elapsed time */
    float       _elapsed;
    
    /*! Interval to run the tick */
    float       _interval;
    
    /*! Selector to be called when Tick finished ***NO Retain/Release***/
    SEL         _selector;
}

- (id) initWithTarget:(id) t forSelector:(SEL) s withInterval:(float) i;

- (void) updateTick:(NSTimeInterval) dt;

- (void) updateTimeIntervalTo:(float) i;

@end
