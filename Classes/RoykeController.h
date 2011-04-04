//
//  MarioMoveViewController.h
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mover.h"
#import "budLightBullet.h"
#import "Bogy.h"
#import "bulletView.h"
#import "Cop.h"
@class StartViewController;


@interface RoykeController : UIViewController {
	Mover *mover;
	Bogy  *bogy;
	budLightBullet *bottle1,*bottle2,*bottle3;
	Cop  *cop1,*cop2,*cop3,*cop4;
	UIImageView *bogyView,*playBarView;
	UIImageView *bottle1View,*bottle2View,*bottle3View;
	bulletView *continueView,*bulletView1;
	UIImageView *targetView,*cop1View,*cop2View,*cop3View,*cop4View;
	NSMutableDictionary * targetDic;
	UILabel *clockLabel,*scoreLabel;
	int milliseconds,seconds,minutes,score;
	NSMutableArray *cops,*copViewArray;
	bool firstRun;
	StartViewController *startController;
	NSOperationQueue *queue;

	
	
	
}
@property (nonatomic,retain) IBOutlet UIImageView *bogyView; 
@property (nonatomic,retain) IBOutlet bulletView *continueView,*bulletView1;
@property (nonatomic,retain) IBOutlet UIImageView *playBarView; 
@property (nonatomic,retain) IBOutlet UIImageView *bottle1View,*bottle2View,*bottle3View;
@property (nonatomic,retain) IBOutlet UIView *targetView;
@property (nonatomic,retain) IBOutlet UIView *cop1View,*cop2View,*cop3View,*cop4View;
@property (nonatomic,retain) IBOutlet UILabel *clockLabel,*scoreLabel;
@property (nonatomic,retain) Cop  *cop1,*cop2,*cop3,*cop4;
@property (nonatomic,retain) IBOutlet StartViewController *startController;
@property (nonatomic,retain) NSOperationQueue *queue;
@property int score,seconds,minutes;

-(IBAction) moverMove:(id)sender;
-(IBAction) fff;

-(void) stop;
-(void)gravity;
-(void)restoreSahi;
-(void)playBarViewTagRestore;
-(void) bulletProgress:(budLightBullet*) bullet;
-(void) allocBullet:(budLightBullet*) bullet;
-(void) unlockAnimationLock;
-(void)killCop:(Cop*) cop;
-(void)hideCopView:(Cop*) tempCop;
-(void)mizrahiDrop:(UIImageView*) closestView;
-(void)mizrahiDown;
@end

