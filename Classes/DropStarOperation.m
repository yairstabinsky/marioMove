//
//  DropStarOperation.m
//  MarioMove
//
//  Created by yair stabinsky on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DropStarOperation.h"



@implementation DropStarOperation
@synthesize starsToDrop;



-(id)init
{
	[super init];
}

-(void) initWithArray:(NSArray *) starArray
{
	[super init];


	
	
	starsToDrop=starArray;//[NSArray arrayWithArray:starArray];
	

}
- (void)dealloc {
    [starsToDrop release], starsToDrop = nil;
    [super dealloc];
}

- (void)main {
	for (int i=0;i<[starsToDrop count];i++)
	{
		//NSLog(@"interim %d",i);
		UIImageView *tempView=(UIImageView*)[starsToDrop objectAtIndex:i];
		NSLog(@"interim %d",tempView.frame.origin.y);
		if(tempView.frame.origin.y<340)
		{
			
			tempView.frame=CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y+5, tempView.frame.size.width, tempView.frame.size.height);
			
		}
	}
}


@end
