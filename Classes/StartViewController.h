//
//  startViewController.h
//  MarioMove
//
//  Created by yair stabinsky on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Cocoa/Cocoa.h>


@class MarioMoveViewController;


@interface StartViewController : UIViewController {
	
	MarioMoveViewController *marioViewController;
	UILabel* allTimeBest,*lastScore,*yourScore,*timesLabel;
	

}
@property(nonatomic,retain)IBOutlet UILabel* allTimeBest,*lastScore,*yourScore, *timesLabel;

-(IBAction)fuckoff;
-(IBAction) startRoy:(id)sender;
-(IBAction) startJerga:(id)sender;

@end
