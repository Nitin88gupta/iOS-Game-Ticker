//
//  NGEnum.h
//  NGGameKit
//
//  Created by Nitin Gupta on 23/02/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGTickerModal.h"

@implementation NGTickerModal

- (id) init {
    
    NSAssert(NO, @"NGTickerModal: Init not supported.");
#if !__has_feature(objc_arc)
    //Do manual memory management...
	[self release];
#else
    //Usually do nothing...
#endif

	return nil;
}

- (void) dealloc {
	
    _target = nil;
    _selector = nil;
#if !__has_feature(objc_arc)
    //Do manual memory management...
	[super dealloc];
#else
    //Usually do nothing...
#endif

}

- (id) initWithTarget:(id) t forSelector:(SEL) s withInterval:(float) i {
    
    if ( (self = [super init]) ) {
        
        _target = t;
        _selector = s;
        _interval = i;
        _elapsed = -1;
    }
    return self;
}

- (void) updateTimeIntervalTo:(float) i {
    
    _interval = i;
    _elapsed = -1;
}

- (void) updateTick:(NSTimeInterval) dt
{
	if( _elapsed == -1) {
        
		_elapsed = 0;
	} else {
        
        _elapsed += dt;
        if (_elapsed >= _interval) {
            if ([_target respondsToSelector:_selector]) {
                [_target performSelector:_selector withObject:NULL];
            }
            _elapsed = 0;
        }
	}
}

@end
