//
//  NGAvatarSprite.m
//  GameTickerSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGAvatarSprite.h"
#import "NGTickerModal.h"
#import "NGAppDelegate.h"

@implementation NGAvatarSprite
@synthesize uniqueID = _uniqueID;
@synthesize boundary = _boundary;

- (id)initWithColor:(UIColor *)color size:(CGSize)size {
    self = [super initWithColor:color size:size];
    if (self) {
        [self addAvatarTicker];
        _direction = CGPointMake(1, 1);
        _uniqueID = 0;
        _boundary = CGRectZero;
        _velocity = 10.0f;
    }
    return self;
}

- (void)dealloc {
    [self removeTickerForAvatar];
    _avatarTicker = nil;
}

#pragma mark - Game Ticker Related
/*! Adding Ticker For View*/
- (void) addAvatarTicker {
    [self removeTickerForAvatar];
    if (!_avatarTicker) {
        _avatarTicker = [[NGTickerModal alloc] initWithTarget:self forSelector:@selector(updateAvatar) withInterval:0.50];//Every 0.5 Sec.
        [(NGAppDelegate *)[[UIApplication sharedApplication] delegate] addTickToGameTicker:_avatarTicker];
    }
}

/*! Removing Ticker For View*/
- (void) removeTickerForAvatar {
    if (_avatarTicker) {
        [(NGAppDelegate *)[[UIApplication sharedApplication] delegate] removeTickFromGameTicker:_avatarTicker];
        _avatarTicker = nil;
    }
}

- (void) updateAvatar
{
    NSLog(@"%s For Unique ID:%d",__FUNCTION__,_uniqueID);
    float maxX = _boundary.size.width - self.frame.size.width;
    float maxY = _boundary.size.height - self.frame.size.height*2;
    int randX = arc4random() % (int)maxX;
    int randY = arc4random() % (int)maxY;
    
    CGPoint newPoint = CGPointMake(randX, randY);
    if (newPoint.x < maxX) {
        if (newPoint.x < 0) {
            newPoint.x = 0.0f;
        }
    } else {
        newPoint.x = maxX;
    }
    
    if (newPoint.y < maxY) {
        if (newPoint.y < 0) {
            newPoint.y = 0.0;
        }
    } else {
        newPoint.y = maxY;
    }
    CGPoint _curPos = self.position;
    
    float distance = [self distanceBetween:_curPos and:newPoint];
    float velocity = [self distanceBetween:CGPointMake(_boundary.size.width, _boundary.size.height) and:CGPointZero]/10.0f;
    float time = distance/velocity;
    
    id action = [SKAction moveTo:newPoint duration:time];
    [self runAction:action];
}

- (float) distanceBetween : (CGPoint) p1 and: (CGPoint)p2 {
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

/*! Update Ticker Method*/
//- (void) updateAvatar
//{
//    //Checks if outside bounds
//    if (self.position.x-(self.frame.size.width/2) <= _boundary.origin.x) {
//        [self hitLeft];
//    }else if (self.position.x+(self.frame.size.width/2) >= _boundary.size.width){
//        [self hitRight];
//    }else if (self.position.y-(self.frame.size.height/2) <= _boundary.origin.y) {
//        [self hitTop];
//    }else if (self.position.y+(self.frame.size.height/2) >= _boundary.size.height){
//        [self hitBottom];
//    }
//
//    CGPoint p = self.position;
//    float time = 0.5;
//
//    p.x += _direction.x * _velocity;
//    p.y += _direction.y * _velocity;
//
//    id action = [SKAction moveTo:p duration:time];
//    [self runAction:action];
//
//}

//checks if the balls position is correct
-(BOOL)positionIsInsideRect {
    if (self.position.x < _boundary.origin.x || self.position.x > _boundary.size.width || self.position.y < _boundary.origin.y || self.position.y > _boundary.size.height) {
        NSLog(@"Position is outside bounds");
        return NO;
    }else{
        return YES;
    }
}

-(void)hitLeft {
    NSLog(@"hitLeft");
    CGPoint d = _direction;
    d.x = fabsf(_direction.x);
    _direction = d;
}

-(void)hitRight {
    NSLog(@"hitRight");
    CGPoint d = _direction;
    d.x = -fabsf(_direction.x);
    _direction = d;
}

-(void)hitTop {
    NSLog(@"hitTop");
    CGPoint d = _direction;
    d.y = fabsf(_direction.y);
    _direction = d;
}

-(void)hitBottom {
    NSLog(@"hitBottom");
    CGPoint d = _direction;
    d.y = -fabsf(_direction.y);
    _direction = d;
}

@end
