//
//  Cop.m
//  MarioMove
//
//  Created by yair stabinsky on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Cop.h"


@implementation Cop
@synthesize isUsed,wasJustBorn,currentView;

-(void)isUsedNo
{
	isUsed=NO;
	wasJustBorn=NO;
}

-(void)initWithStartingPoint:(CGPoint) startingPoint andView:(UIImageView*) view
{
	position=CGPointMake(startingPoint.x, startingPoint.y-10) ;
	velocity=CGPointMake(0,10);
	isUsed=YES;
	wasJustBorn=YES;
	//[currentView autorelease];

	currentView=view;
		
}
-(bool) drop
{
	position.y+=0.5;
	if (position.y<450) {
		return NO;
		
	}
	else {
		self.isUsed=NO;
		currentView.hidden=YES;
		currentView=nil;
		return YES;
	}
	
}

- (void)dealloc {
	
	
	NSLog(@"IM DEAD");
	//[currentView release];
	[super dealloc];
}
@end
