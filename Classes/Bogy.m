//
//  Bogy.m
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bogy.h"
#import<AudioToolbox/AudioServices.h>


@implementation Bogy
@synthesize animationLock;
 - (void)update {
    position.x += velocity.x;
    position.y += velocity.y;
	// NSLog(@" in bogy velocity.y=%lf     ",velocity.y);

    if(position.x + radius > 352.0) {
        position.x = 352.0 - radius;
        		//float x=arc4random()%2+1;
		velocity.x *= -1;
		NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/ballbounce.wav"];
		SystemSoundID soundID;
		NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
		AudioServicesPlaySystemSound(soundID);
		
		if (velocity.x<-10.0) 
		{
			velocity.x=velocity.x<0?-5:5;
		}
    }
    else if(position.x - radius < 0.0) {
        position.x = radius;
		//float x=arc4random()%2+1;
		velocity.x *= -1;
		NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/ballbounce.wav"];
		SystemSoundID soundID;
		NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
		AudioServicesPlaySystemSound(soundID);
		if (velocity.x>10.0) 
		{
			velocity.x=velocity.x<0?-5:5;
		}
		
    }
	 
	
    if(position.y  >= 300.0) {
        position.y = 500;
		 //float x=arc4random()%2+1;
				//NSLog(@" in bogy velocity.y=%lf     ",velocity.y);
        velocity.y *= - (1);
		NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/abort.wav"];
		SystemSoundID soundID;
		NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
		AudioServicesPlaySystemSound(soundID);
	
		//NSLog(@" in bogy velocity.y=%lf     ",velocity.y);
		if (velocity.y<-40.0) 
		{
			velocity.y=velocity.y<0?-10:7;
		}
		//NSLog(@" in bogy x=%lf     ",x);
    }
    else if(position.y  < 0.0) {
        position.y = 10;
		velocity.y *=  -1;
		NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/ballbounce.wav"];
		SystemSoundID soundID;
		NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
		AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
		AudioServicesPlaySystemSound(soundID);
		
    }
    //NSLog([[NSString alloc] initWithFormat:@"x: %f, y:%f", position.x, position.y]);
	// NSLog(@" out bogy velocity.y=%lf     ",velocity.y);
}


@end
