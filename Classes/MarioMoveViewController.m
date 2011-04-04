//
//  MarioMoveViewController.m
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MarioMoveViewController.h"
#import "MoverView.h"
#import "bulletView.h"
//#import"Cop.h"
//#import"AudioServices.h"
#import<AudioToolbox/AudioServices.h>
#import "MarioMoveAppDelegate.h"



@implementation MarioMoveViewController
@synthesize bogyView,playBarView,bottle1View,scoreLabel,targetView,bottle2View,bottle3View,score,clockLabel,continueView, cop1View,cop2View,cop3View,cop4View,bulletView1,cop1,cop2,cop3,cop4;
#import "budLightBullet.h"


- (void)onTimer 
{
	
		milliseconds++;// print timer to screen
	if(milliseconds==30)
	{
		milliseconds=0;
		seconds++;
		if(seconds==60)
		{
			seconds=0;
			minutes++;
		}
	}
	NSString * milliSecondsString= milliseconds<10?[NSString stringWithFormat:@"0%d",milliseconds]:[NSString stringWithFormat:@"%d",milliseconds];
	NSString * secondsString= seconds<10?[NSString stringWithFormat:@"0%d",seconds]:[NSString stringWithFormat:@"%d",seconds];
	clockLabel.text=[NSString stringWithFormat:@"%d:%@:%@",minutes,secondsString,milliSecondsString];
	
    [mover update];
	
	[bogy update];
	if(bogy.position.y>360)
	{
bogy.position=CGPointMake(mover.position.x+10, mover.position.y-27);//restart bogy after he has fallen into abyss
		bogy.velocity=CGPointMake(0, 0);
		[(MoverView*)self.view addSubview:continueView];
		[(MoverView*)self.view bringSubviewToFront:continueView];
		//NSLog(@"%@",(MoverView*)self.view.subviews);
		playBarView.tag=666;
		 }		
	if([continueView isDescendantOfView:(MoverView*)self.view])
	{
		if([  continueView      returnFired]  )
		{
			bogy.velocity=CGPointMake(0,-8 );
			[self performSelector:@selector (playBarViewTagRestore) withObject:nil afterDelay:0.1];
			[  continueView   removeFromSuperview];
			//bulletView1.hidden=YES;
			
		}
	}
//	NSLog(@" timer post   %lf",bogy.velocity.y)  ;
    //CGRect rect = CGRectMake(mover.position.x - mover.radius, mover.position.y - mover.radius, 10, 10);
    //[(MoverView *)self.view refresh:rect];
	playBarView.frame=CGRectMake(mover.position.x, mover.position.y, 72, 25);
	bogyView.frame=CGRectMake(bogy.position.x, bogy.position.y, bogyView.frame.size.width,bogyView.frame.size.height);
	
//	NSLog(@" timer pre!!!   %lf",bogy.velocity.y)  ;
	if (CGRectIntersectsRect(bogyView.frame, playBarView.frame ) && playBarView.tag!=666) 
	{
		
		
		if(playBarView.tag!=666)
		{
			if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>playBarView.frame.origin.x &&(bogyView.frame.origin.x+bogyView.frame.size.width/2)<playBarView.frame.origin.x+90)
			{

				//bogy.position=CGPointMake(100,0);
		
			if(bogy.velocity.y<0)
			bogy.velocity=CGPointMake(-bogy.velocity.x,-(bogy.velocity.y-2));	
			else
			{
					

				if((bogyView.frame.origin.x+bogyView.frame.size.width/2)<(playBarView.frame.origin.x+playBarView.frame.size.width/2)-11)
				{
					if((bogyView.frame.origin.x+bogyView.frame.size.width/2)<playBarView.frame.origin.x+13)
					   bogy.velocity=CGPointMake(-3,-(bogy.velocity.y));
					   else
						   bogy.velocity=CGPointMake(-1.5,-(bogy.velocity.y)) ;
				}
				if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>(playBarView.frame.origin.x+playBarView.frame.size.width/2)+11)
					   {
						   if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>playBarView.frame.origin.x+54)
							  bogy.velocity=CGPointMake(3,-(bogy.velocity.y));
							  else
								  bogy.velocity=CGPointMake(2,-(bogy.velocity.y)) 	;
					   }
				if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>=(playBarView.frame.origin.x+playBarView.frame.size.width/2)-11&&(bogyView.frame.origin.x+bogyView.frame.size.width/2)<=(playBarView.frame.origin.x+playBarView.frame.size.width/2)+11)
				{
					
					bogy.velocity=CGPointMake(0.75,-(bogy.velocity.y));
				}
				NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/ballbounce.wav"];
				SystemSoundID soundID;
				NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
				AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
				AudioServicesPlaySystemSound(soundID);
			}

				

			
			playBarView.tag=666;
			[self performSelector:@selector (playBarViewTagRestore) withObject:nil afterDelay:0.5];
			//NSLog(@" posttimer   %lf",bogy.velocity.y)  ;
			}
		}
	}
	//NSLog(@" timer post!!!   %lf",bogy.velocity.y)  ;

	/*int jointCount=1;
	
	if (bogyView.frame.origin.y>367) 
	{
		
	
		for(int i=5;i<14;i++)//did he find a joint?
	   {
		   
		   if([(MoverView*)self.view viewWithTag:i].hidden==YES)
			   jointCount+=1;
		   
		if (CGRectIntersectsRect(bogyView.frame,[(MoverView*)self.view viewWithTag:i].frame)&&[(MoverView*)self.view viewWithTag:i].hidden!=YES)
		{
			
			if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>[(MoverView*)self.view viewWithTag:i].frame.origin.x+1&&(bogyView.frame.origin.x+bogyView.frame.size.width/2)<[(MoverView*)self.view viewWithTag:i].frame.origin.x+55)
			{
							 [(MoverView*)self.view viewWithTag:i].hidden= YES;
			//bogyView.image=[UIImage imageNamed:@"stonedDrawing.png"];
			[self performSelector:@selector (restoreSahi) withObject:nil afterDelay:4];
								

			}

				
				
		}
	  }			
		if(jointCount>9)//reset joints
			{
			for(int i=5;i<14;i++)
				[(MoverView*)self.view viewWithTag:i].hidden= NO;
			}	
	}	
	 */
	
	CGPoint checkPoint=[(MoverView*)self.view returnTouchOrigin];
	if (checkPoint.y>200) {
		mover.position=checkPoint;//only if we touched below the mover then update the mover
	}
	//float bulletCheckPoint= mover.position.y ;
	mover.position= CGPointMake(mover.position.x, 300);
	
	
	// bullets chech
	
	
	//NSLog(@"bullrtview frame is %d",bulletView1.frame.size.width);
	 
	
	if([bulletView1 returnFired]==YES)//was a shot fired???
 {
	 
	 
	 
	 if (bottle1==nil) 
	[self allocBullet:bottle1];
	

	

	 if(bottle2==nil&&bottle1.position.y <250)
		 [self allocBullet:bottle2];
	 	 

	 if(bottle3==nil&&bottle2)
	 {
		 if (bottle2.position.y<250) 
			 [self allocBullet:bottle3];
	 }
	  
		 
		  
 }
		if(bottle1)	
	[self bulletProgress:bottle1];

			

		if(bottle2)
		 [self bulletProgress:bottle2];

	if (bottle3)
		[self bulletProgress:bottle3];
	
	bool bulletInTheHead;
	
	if(CGRectIntersectsRect(bottle1View.frame, bogyView.frame)&& bottle1View.hidden==NO)
	{
		bulletInTheHead=YES;
	   
	   bogy.position=CGPointMake(bogy.position.x, bogy.position.y-120);
		bogy.velocity=CGPointMake(-bogy.velocity.x, -bogy.velocity.y);
	}
		
	
		if(CGRectIntersectsRect(bottle2View.frame, bogyView.frame)&& bottle2View.hidden==NO)
		   {
			   if (bulletInTheHead==NO) {
				   if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>bottle2View.frame.origin.x+5&&(bogyView.frame.origin.x+bogyView.frame.size.width/2)<bottle2View.frame.origin.x+50)
				   {
				    bogy.position=CGPointMake(bogy.position.x, bogy.position.y-120);
			   bogy.velocity=CGPointMake(-bogy.velocity.x, -bogy.velocity.y);
				   }

			   }
			}

			   
	for(int i=101;i<145;i++) 
		// bogy target colision checking
{//
		UIImageView* tempView=[targetDic objectForKey:  [NSString stringWithFormat:@"%d",i]];
	if(tempView==nil)
		continue;
		
		CGPoint collisionPoint= CGPointMake(    tempView.frame.origin.x+14, tempView.frame.origin.y+12 )	;
		//NSLog(@"origin is %f::::",tempView.frame.origin.x);
	

		BOOL didHit  = CGRectContainsPoint(bogyView.frame,collisionPoint); 	// did bogy hit a shield?
		
	
		
		
if ( didHit&& !bogy.animationLock )
  {
	  score+=10;
	  scoreLabel.text= [NSString stringWithFormat:@"%d", score];
			int rand=arc4random()%2;//deflect in a random direction
			
			if(rand==0)
			bogy.velocity=CGPointMake(-bogy.velocity.x, -bogy.velocity.y);
			else 
				bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);

										  
		NSLog(@"target dic =%d",[targetDic count]);	
			
		if (i%2!=0) 
		{ //if it is just a regular shield
				
			
			

			if(tempView.image!=[UIImage imageNamed:@"police_star_small_broken.png"])
			tempView.image=[UIImage imageNamed:@"police_star_small_broken.png"];
			
			else
			{
				[   tempView  removeFromSuperview]         ;
				 [targetDic removeObjectForKey:[NSString stringWithFormat:@"%d",i] ];
			}
		}
				
				
				
				
				
				
				
				if(i%2==0)//if it is a copview
				{
					if(tempView.image!=[UIImage imageNamed:@"cop_in_broken_sheild.png"])
						tempView.image=[UIImage imageNamed:@"cop_in_broken_sheild.png"];
					
					
					
					
					else
					{
						
						for( int j=0;j<[cops count];j++)
						{
							UIImageView *tempCopView;
							Cop *tempCop=(Cop*)[cops objectAtIndex:j];
							if (tempCop.isUsed!=YES) 
							{
								for(int i=0;i<[copViewArray count];i++)
								{
									tempCopView= [copViewArray objectAtIndex:i];
									
									if (tempCopView.hidden==YES)
									{
										tempCop.wasJustBorn=NO;
										//tempCopView.hidden=NO;
										break;
									}
								}
								[tempCop initWithStartingPoint:tempView.frame.origin andView:tempCopView];
								
								NSLog(@"activeCop Created");
								score+=25;
								scoreLabel.text= [NSString stringWithFormat:@"%d", score];			
								break;
							}
						}
												
							
						
							
												
						
											
                               
						        [   tempView  removeFromSuperview]         ;
						        [targetDic removeObjectForKey:[NSString stringWithFormat:@"%d",i] ];
					}
				}	
					
  	
			
			
			
			bogy.animationLock=YES;
			[self performSelector:@selector (unlockAnimationLock) withObject:nil afterDelay: 0.15];
			
			
			
			NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/ballbounce.wav"];
			SystemSoundID soundID;
			NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
			AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
			AudioServicesPlaySystemSound(soundID);
			
  		
			
			
			
			
			
			break;
  }



}//ends the for loop
			
	




for(int i =0;i<[cops count]&&!bogy.animationLock;i++)
{
	Cop *tempCop=(Cop*)[cops objectAtIndex:i];


   if ( tempCop.isUsed==YES) 
	   {				
				
			
							
				
				if ([tempCop drop]) 
				{//returns no if he can continue [dropping ]
					 
				}	
					
		 //  NSLog(@" AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA COP: %@  with VIEW %@",tempCop,tempCopView);
				
				else {
					
					tempCop.currentView.hidden=NO;
				tempCop.currentView.frame=CGRectMake(tempCop.position.x, tempCop.position.y, tempCop.currentView.frame.size.width, tempCop.currentView.frame.size.height);
								
				
					
					if (  CGRectIntersectsRect(tempCop.currentView.frame, bottle1View.frame)&&bottle1View.hidden==NO) //(cop1View.frame,CGPointMake(bottle1View.frame.origin.x, bottle1View.frame.origin.x)  ))//did cop meet bullet one
					{
						[self performSelector:@selector(hideCopView:) withObject:tempCop afterDelay:0.2  ];
						tempCop.currentView.image=[UIImage imageNamed:@"cop_dead.png"];
						//tempCop.isUsed=NO;
						//tempCop.currentView.hidden=YES;
						//tempCop.currentView=nil;
						//tempCop.currentView.frame=
						//tempCopView.hidden=YES;
						bottle1View.frame=CGRectMake(550, 450, bottle1View.frame.size.width, bottle1View.frame.size.height);
						bottle1View.hidden=YES;
						NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/oh_no.wav"];
						SystemSoundID soundID;
						NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
						AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
						AudioServicesPlaySystemSound(soundID);
						score+=50;
						scoreLabel.text= [NSString stringWithFormat:@"%d", score+50];
						

												
					}
				if (CGRectContainsPoint(tempCop.currentView.frame,CGPointMake(bottle2View.frame.origin.x, bottle2View.frame.origin.x)  ))//did cop meet bullet two
					{
								tempCop.currentView.image=[UIImage imageNamed:@"cop_dead.png"];
								//[self performSelector:@selector (killCop:) withObject:cop2 afterDelay:0.5];
						[self performSelector:@selector(hideCopView:) withObject:tempCop afterDelay:0.2  ];						
						//tempCop.isUsed=NO;
						//tempCop.currentView.hidden=YES;
						//tempCop.currentView=nil;
						       bottle2View.frame=CGRectMake(550, 450, bottle2View.frame.size.width, bottle2View.frame.size.height);
						bottle2View.hidden=YES;
						NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/oh_no.wav"];
						SystemSoundID soundID;
						NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
						AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
						AudioServicesPlaySystemSound(soundID);
						score+=50;
						scoreLabel.text= [NSString stringWithFormat:@"%d", score+=50];

					}
					
				
				
				}

				
				
					
							
				
			
			
			
			
		}
			
}
	
	if ([targetDic count]==0) {
		
		//[self.view addSubview:<#(UIView * )view#>;
		[self.view removeFromSuperview];
		//[self release];
		//self=nil;
		
				UIApplication *tempWin=[ UIApplication sharedApplication];//.delegate.window;
		MarioMoveAppDelegate* tempdel=tempWin.delegate;
		tempdel.marioController=self;
		[tempdel.window addSubview:tempdel.startController.view];//self.view];//;
		return;
	
	//addSubview:self.view];
		//return
	}
	
	[self performSelector:@selector(onTimer) withObject:nil afterDelay:1.0 / 30.0];
}//ends function 
	
	//NSLog(@" timer post   %lf",bogy.velocity.y)  ;

-(IBAction) fff
{
}



#pragma mark END OF TIMER (((((((******************************************************************************************************
-(void)hideCopView:(Cop*) tempCop
{
	tempCop.currentView.image=[UIImage imageNamed:@"cop_small.png"];
	tempCop.isUsed=NO;
	tempCop.currentView.hidden=YES;
}
							  
					
-(void)killCop:(Cop*) cop
{
		
		
			

}
					
//NSEnumerator
-(void) unlockAnimationLock
{
	bogy.animationLock=NO;
}


-(void) bulletProgress:(budLightBullet*) bullet

{
	
	if (bottle1&& bottle1==bullet) 
	{
		if([bottle1 shoot])
			bottle1View.frame=CGRectMake(bottle1.position.x, bottle1.position.y, bottle1View.frame.size.width, bottle1View.frame.size.height);
		else {
			//[bottle1 release];
			bottle1=nil;
			//NSLog(@"retain2 %d",[bottle1 retainCount]);
			bottle1View.hidden=YES;
			[(MoverView*)self.view setTouchOrigin:CGPointMake(mover.position.x,500)];
			
			
		}
	}
		if (bottle2&& bottle2==bullet) 
		{
			if([bottle2 shoot])
				bottle2View.frame=CGRectMake(bottle2.position.x, bottle2.position.y, bottle1View.frame.size.width, bottle1View.frame.size.height);
			else {
				//[bottle2 release];
				bottle2=nil;
				//NSLog(@"retain2 %d",[bottle2 retainCount]);
				bottle2View.hidden=YES;
				[(MoverView*)self.view setTouchOrigin:CGPointMake(mover.position.x,500)];
				
				
			}
		}
			
			if (bottle3&& bottle3==bullet) 
			{
				if([bottle3 shoot])
					bottle3View.frame=CGRectMake(bottle3.position.x, bottle3.position.y, bottle3View.frame.size.width, bottle3View.frame.size.height);
				else {
					//[bottle3 release];
					bottle3=nil;
					//NSLog(@"retain2 %d",[bottle3 retainCount]);
					bottle3View.hidden=YES;
					[(MoverView*)self.view setTouchOrigin:CGPointMake(mover.position.x,500)];
					
					
				}
		
			}
	}

			
-(void) allocBullet:(budLightBullet*) bullet
	{ 
		if(bullet ==bottle1)
		{
	bottle1= [budLightBullet alloc] ;
			//[bottle1 autorelease];
	[bottle1 initWithStartingPoint:mover.position];
	bottle1View.hidden=NO;
			return;
		}
		if(bullet ==bottle2)
		{
			bottle2= [budLightBullet alloc] ;
			[bottle2 initWithStartingPoint:mover.position];
			bottle2View.hidden=NO;
			return;
		}
		if(bullet ==bottle3)
		{
			bottle3= [budLightBullet alloc] ;
			[bottle3 initWithStartingPoint:mover.position];
			bottle3View.hidden=NO;
		}
	}
		
			
			

-(void)restoreSahi
{
	//bogyView.image=[UIImage imageNamed:@"stonedDrawing_no_joint.png"];
}
-(void)playBarViewTagRestore //restores a bunch of different parameters
{

	playBarView.tag=665;
	// NSLog(@" restor   %lf",bogy.velocity.y)  ;
//if	(bogy.velocity.y<0)
	//bogy.velocity=CGPointMake(bogy.velocity.x,bogy.velocity.y+2);
	
	//else
	//bogy.velocity=CGPointMake(bogy.velocity.x,bogy.velocity.y-2);
	//NSLog(@" postrestor   %lf",bogy.velocity.y)  ;

	
			

	
	

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSUserDefaults *pastData=[NSUserDefaults standardUserDefaults];
//	if([pastData integerForKey:@"highscore"]!=7 )
	//{//integerForKey:@"highscore"]!=nil)
	//	[pastData setInteger:7 forKey:@"highscore"];
	
		
//[pastData synchronize];
//	}
	
	
	
	bogyView.animationImages = [NSArray arrayWithObjects:   
						[UIImage imageNamed:@"stonedDrawing.png"],
						[UIImage imageNamed:@"stonedDrawing_2.png"],
						[UIImage imageNamed:@"stonedDrawing_3.png"],
						[UIImage imageNamed:@"stonedDrawing_4.png"],
						[UIImage imageNamed:@"stonedDrawing_5_1.png"],
						[UIImage imageNamed:@"stonedDrawing_6.png"],
						[UIImage imageNamed:@"stonedDrawing_7.png"],
						[UIImage imageNamed:@"stonedDrawing_8.png"],
						[UIImage imageNamed:@"stonedDrawing_9.png"],
						[UIImage imageNamed:@"stonedDrawing_10.png"],
						[UIImage imageNamed:@"stonedDrawing_11.png"],nil];
	NSLog(@"aaaaaa%@",bogyView.animationImages);
	
	
	bogyView.animationDuration = 5.00;
	// repeat the annimation forever
	bogyView.animationRepeatCount = 650;
	// start animating
	[bogyView startAnimating];
scoreLabel.text= [NSString stringWithFormat:@"%d", 0];
	
	
	
	mover = [Mover alloc];
	mover.position = CGPointMake(134, 400);
	mover.velocity = CGPointMake(0.0, 0.0);
	mover.radius = 10.0;
	mover.color = [UIColor greenColor].CGColor;
	
	[(MoverView*)self.view setTouchOrigin:CGPointMake(0,500)];
	bogy=[Bogy alloc];
	bogy.position = CGPointMake(50, 250);
	bogy.velocity = CGPointMake(3, 6);
	mover.radius = 40.0;
	//[NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	targetDic=[[NSMutableDictionary alloc] init];
	for(int i=101;i<145;i++)
	{
		if([targetView viewWithTag:i])
		[targetDic setObject:[targetView viewWithTag:i] forKey:[NSString stringWithFormat:@"%d",i]];
		
		
		
		
	}
	
	
	cops=[[NSMutableArray alloc]initWithObjects:[Cop alloc],[Cop alloc] ,[Cop alloc],[Cop alloc],nil];
	copViewArray=[[NSMutableArray alloc]initWithObjects:cop1View,cop2View,cop3View,cop4View,nil];
	
	firstRun=YES;
	
	
	
	
	
		
	
	//NSLog(@"%@",targetDic);
	
	
	
	//[NSTimer scheduledTimerWithTimeInterval:1.0 / 30.0 target:self selector:@selector(printTime) userInfo:nil repeats:YES];
	
	bottle1=nil;
	bottle2=nil;
	bottle3=nil;
	
	
	[self onTimer];
}
//-(void)printTime
//{
//	timeLabel.text=[NSString stringWithFormat:@"%lf

-(IBAction) moverMove:(id)sender
{
	//NSLog(@"%@",[(MoverView*)self.view viewWithTag:2]);
	
	//NSLog(@"                                     bbbbbbbbbbbbbbbbbbbbbb%@",[(MoverView*)self.view viewWithTag:1]);
	//NSLog(@"             %@",(MoverView*)self.view.subviews);
	
	if (sender==[(MoverView*)self.view viewWithTag:1]) {
		mover.velocity = CGPointMake(mover.velocity.x+3, mover.velocity.y);
		[self performSelector:@selector (stop) withObject:nil afterDelay:2];// go right
	}
	if (sender==[(MoverView*)self.view viewWithTag:2]) {
		mover.velocity = CGPointMake(mover.velocity.x-3,mover.velocity.y);

		[self performSelector:@selector (stop) withObject:nil afterDelay:2];//go  left
	}
	
	if (sender==[(MoverView*)self.view viewWithTag:3]) {
		mover.velocity = CGPointMake(mover.velocity.x,mover.velocity.y-10);
		[(MoverView*)self.view viewWithTag:3].userInteractionEnabled=NO;
		
		[self performSelector:@selector (gravity) withObject:nil afterDelay:1];//go  left
		NSLog(@"movermove");
	}
	
}




-(void) stop
{
	mover.velocity = CGPointMake(0.0, 0.0);
		
}
	
-(void)gravity
{
	
			if (mover.position.y+mover.radius<390) {
			mover.velocity=CGPointMake(mover.velocity.x, 7);
		[self performSelector:@selector (gravity) withObject:nil afterDelay:0.05];
		}
		else {
			mover.velocity=CGPointMake(0, 4);
			//mover.position=CGPointMake(mover.position.x,400);
			[(MoverView*)self.view viewWithTag:3].userInteractionEnabled=YES;
			NSLog(@"gravity");
			
		}

	
	
}
-(void) animateBogy
{
	
}

 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
 }

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[bogyView release];
	[playBarView release] ;
	[bottle1View release];
	[targetView release];
	[bottle2View release];
	[bottle3View release];
	[bulletView release];
	[cop1View release];
	[cop2View release];
	[cop3View release];
	[cop4View release]; 
	[cops release];
	[copViewArray release];
	[scoreLabel release];
}

@end
