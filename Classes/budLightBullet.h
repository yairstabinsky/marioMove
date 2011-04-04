//
//  budLightBullet.h
//  MarioMove
//
//  Created by yair stabinsky on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mover.h"


@interface budLightBullet : Mover {

}
-(void)initWithStartingPoint:(CGPoint) startingPoint;
-(bool) shoot;
@end
