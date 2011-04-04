//
//  Mover.m
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Mover.h"


@implementation Mover



@synthesize position;
@synthesize velocity;
@synthesize radius;
@synthesize color;

- (void)update {
    position.x += velocity.x;
    position.y += velocity.y;
	
    if(position.x + radius > 460.0) {
        position.x = 460.0 - radius;
        velocity.x = 0;
    }
    else if(position.x  < 0.0) {
        position.x = 5;
		velocity.x = 0;
    }
	
    if(position.y + radius > 320.0) {
        position.y = 280 - radius;
        velocity.y = 0;
    }
    else if(position.y - radius < 0.0) {
        position.y = radius;
       // velocity.y *= -1.0;
    }
   // NSLog([[NSString alloc] initWithFormat:@"x: %f, y:%f", position.x, position.y]);
}

@end

