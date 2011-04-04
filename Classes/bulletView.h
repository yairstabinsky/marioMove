//
//  bulletView.h
//  MarioMove
//
//  Created by yair stabinsky on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface bulletView : UIView {
bool fired;
}
@property bool fired;
- (bool)returnFired;
-(void) stopFiring;
@end
