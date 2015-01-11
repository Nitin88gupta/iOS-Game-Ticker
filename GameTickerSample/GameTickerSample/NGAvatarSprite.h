//
//  NGAvatarSprite.h
//  GameTickerSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@class NGTickerModal;

@interface NGAvatarSprite : SKSpriteNode {
    NGTickerModal *_avatarTicker;
    CGPoint _direction;
    float _velocity;
}

@property (nonatomic, assign) int uniqueID;
@property (nonatomic, assign) CGRect boundary;

@end
