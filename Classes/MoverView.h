//
//  MoverView.h
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoverView : UIView {
	CGRect moverRect;
	CGPoint touchOrigin;
	
}
//@property  CGPoint touchOrigin;
- (void)refresh:(CGRect)rect;
-(CGPoint) returnTouchOrigin;
-(void) setTouchOrigin:(CGPoint)newPoint;


@end
