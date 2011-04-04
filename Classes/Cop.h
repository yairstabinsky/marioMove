//
//  Cop.h
//  MarioMove
//
//  Created by yair stabinsky on 2/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mover.h"
 //@class MarioMoveViewController


@interface Cop : Mover {
	
	bool isUsed;
	bool wasJustBorn;
	UIImageView* currentView;
	
}
@property(readwrite) bool isUsed,wasJustBorn;
-(void)initWithStartingPoint:(CGPoint) startingPoint andView:(UIImageView*) view;
-(bool) drop;
-(void)isUsedNo;
@property (nonatomic,retain) UIImageView* currentView;
@end

//??????????????????