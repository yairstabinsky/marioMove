//
//  DropStarOperation.h
//  MarioMove
//
//  Created by yair stabinsky on 3/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DropStarOperation : NSOperation 
{
	NSArray *starsToDrop;


}
@property (nonatomic,retain) NSArray *starsToDrop;
@end
