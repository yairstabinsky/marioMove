//
//  bulletView.m
//  MarioMove
//
//  Created by yair stabinsky on 2/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "bulletView.h"
#import          <AudioToolbox/AudioServices.h>


@implementation bulletView
@synthesize fired;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/ 

- (void)dealloc {
    [super dealloc];
}

- (bool)returnFired
{
	[self performSelector:@selector (stopFiring) withObject:nil afterDelay:0.0001];
	return fired;
	
}

-(void) stopFiring
{
	fired=NO;
}
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	//[self becomeFirstResponder];
	
	UITouch* touch = [touches anyObject]; 
	
	NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/laser_1.wav"];
	SystemSoundID soundID;
	NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
	AudioServicesPlaySystemSound(soundID);
	fired= YES;	
	
	//NSLog(@" %l@",touch);
	//NSLog(@" %lf",event.timestamp);
	//NSLog(@" %@",[touches allObjects]);
	
	
	//if( numTaps >= 1 )
	//[m_pManager doStateChange:[gsTest class]];
	
}
@end
