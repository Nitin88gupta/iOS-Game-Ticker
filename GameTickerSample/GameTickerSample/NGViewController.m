//
//  NGViewController.m
//  GameTickerSample
//
//  Created by Nitin Gupta on 16/04/14.
//  Copyright (c) 2014 Nitin Gupta. All rights reserved.
//

#import "NGViewController.h"
#import "NGAvatarSprite.h"

@interface NGViewController ()

@end

@implementation NGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect _frame  =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    SKView * skView = [[SKView alloc] initWithFrame:_frame];
    
    if (!skView.scene) {
        skView.showsFPS = NO;
        skView.showsNodeCount = NO;
        
        // Create and configure the scene.
        scene = [SKScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    [[self view] addSubview:skView];

    [self addAvatars];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addAvatars {
    for (int i = 1; i < 15; i++) {
        NGAvatarSprite *_avatar = [[NGAvatarSprite alloc] initWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];
        [scene addChild:_avatar];
        _avatar.position = CGPointMake(20*i, 20*i);
        _avatar.anchorPoint = CGPointZero;
        _avatar.boundary = self.view.frame;
        _avatar.uniqueID = i;
    }
}

@end
