//
//  Mover.h
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Mover : NSObject {
	CGPoint position;
	CGPoint velocity;
	CGFloat radius;
	CGColorRef color;

}


@property CGPoint position;
@property CGPoint velocity;
@property CGFloat radius;
@property CGColorRef color;
- (void)update;
@end



