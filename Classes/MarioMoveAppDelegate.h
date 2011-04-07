//
//  MarioMoveAppDelegate.h
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MarioMoveViewController;
@class StartViewController;
@class RoykeController;

@interface MarioMoveAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
    MarioMoveViewController *marioController;
	StartViewController *startController;
	RoykeController *roykeController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MarioMoveViewController *marioController;
@property (nonatomic, retain) IBOutlet StartViewController *startController;
@property (nonatomic, retain) IBOutlet RoykeController *roykeController;
//fdfsdfdsfdsfdsfsfs
//ffdsfdsffds

@end

//yuda yuda ya yuda