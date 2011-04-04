//
//  budLightBullet.m
//  MarioMove
//
//  Created by yair stabinsky on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "budLightBullet.h"


@implementation budLightBullet
-(void)initWithStartingPoint:(CGPoint) startingPoint
{
	position=CGPointMake(startingPoint.x+30, startingPoint.y-20) ;
	velocity=CGPointMake(0,10);
}
-(bool) shoot
{
	position.y-=velocity.y;
	if (position.y<30) {
		return NO;
	}
	else {
		return YES;
	}

}
@end
