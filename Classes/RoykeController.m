//
//  MarioMoveViewController.m
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "RoykeController.h"
#import "MarioMoveViewController.h"
#import "MoverView.h"
#import "bulletView.h"
//#import"Cop.h"
//#import"AudioServices.h"
#import<AudioToolbox/AudioServices.h>
#import "MarioMoveAppDelegate.h"
#import"DropStarOperation.h"


@implementation RoykeController
@synthesize queue,seconds,minutes,bogyView,playBarView,bottle1View,startController,scoreLabel,targetView,bottle2View,bottle3View,score,clockLabel,continueView, cop1View,cop2View,cop3View,cop4View,bulletView1,cop1,cop2,cop3,cop4;
#import "budLightBullet.h"


- (void)onTimer 
{
	float closestXDistance=0;
	float closestYDistance=0; 
	
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
		score-=100;
	}		
	if([continueView isDescendantOfView:(MoverView*)self.view])
	{
		if([  continueView      returnFired]  )
		{
			bogy.velocity=CGPointMake(2,-7 );
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
					
					
					if((bogyView.frame.origin.x+bogyView.frame.size.width/2)<(playBarView.frame.origin.x+playBarView.frame.size.width/2)-15)
					{
						if((bogyView.frame.origin.x+bogyView.frame.size.width/2)<playBarView.frame.origin.x+5)
							bogy.velocity=CGPointMake(-4,-(bogy.velocity.y));
						else
							bogy.velocity=CGPointMake(-2,-(bogy.velocity.y)) ;
					}
					if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>(playBarView.frame.origin.x+playBarView.frame.size.width/2)+15)
					{
						if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>playBarView.frame.origin.x+55)
							bogy.velocity=CGPointMake(4,-(bogy.velocity.y));
						else
							bogy.velocity=CGPointMake(2,-(bogy.velocity.y)) 	;
					}
					if((bogyView.frame.origin.x+bogyView.frame.size.width/2)>=(playBarView.frame.origin.x+playBarView.frame.size.width/2)-15&&(bogyView.frame.origin.x+bogyView.frame.size.width/2)<=(playBarView.frame.origin.x+playBarView.frame.size.width/2)+15)
					{
						if((bogyView.frame.origin.x+bogyView.frame.size.width/2)<=(playBarView.frame.origin.x+playBarView.frame.size.width/2))
						
						bogy.velocity=CGPointMake(-0.8,-(bogy.velocity.y));
						else bogy.velocity=CGPointMake(0.8,-(bogy.velocity.y));

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
	
	UIImageView *closestView;
	closestView=nil;
	
	
	for(int i=101;i<140;i++) 
		// bogy target colision checking
	{//
				UIImageView* tempView=[targetDic objectForKey:  [NSString stringWithFormat:@"%d",i]];
		if(tempView==nil)
			continue;
		CGPoint bogyCenter= CGPointMake(    bogyView.frame.origin.x+bogyView.frame.size.width/2, bogyView.frame.origin.y+bogyView.frame.size.height/2 )	;
		CGPoint
		tempViewCenter= CGPointMake( tempView.frame.origin.x+tempView.frame.size.width/2, tempView.frame.origin.y+tempView.frame.size.height/2)	;
		float yDistance;
		float xDistance;
		
		if (tempViewCenter.x>bogyCenter.x) 
			xDistance=tempViewCenter.x-bogyCenter.x;
		else 
				xDistance=bogyCenter.x-tempViewCenter.x;
		
		
		
		if (tempViewCenter.y>bogyCenter.y) 
			yDistance=tempViewCenter.y-bogyCenter.y;
		else 
			yDistance=bogyCenter.y-tempViewCenter.y;
		
		
		
		
		if( xDistance>20||yDistance>20)
			continue;
		
					
		
		
		
		
		if (closestView==nil) {
			closestView=tempView;
			closestXDistance=xDistance;
			closestYDistance=yDistance;
			NSLog(@"first analyzed %d xdist:%lf ydist:%lf",closestView.tag,xDistance,yDistance);
			
		}
		else {
			
			CGRect tempRect1=CGRectIntersection(bogyView.frame, closestView.frame);
			CGRect tempRect2=CGRectIntersection(bogyView.frame,tempView.frame );
			if(tempRect2.size.height+tempRect2.size.width>tempRect1.size.width+tempRect1.size.height)
			{
				closestView=tempView;
				closestXDistance=xDistance;
				closestYDistance=yDistance;
				NSLog(@"next analyzed %d xdist:%lf ydist:%lf",closestView.tag,xDistance,yDistance);

				
			}
		}
					
		
		
					
		
		
	}//ends the for loop
	
	
		if (  !bogy.animationLock && (closestXDistance!=0||closestYDistance!=0) )
		{
						
			
			
						
			
			
			
			
			NSLog(@"closestView %d, closestx %lf,closesty %lf",closestView.tag,closestXDistance,closestYDistance);
			NSLog(@"bogys old velocity is %lf,%lf" ,bogy.velocity.x,bogy.velocity.y);
						
			
			
			CGRect leftSideRect=CGRectMake(closestView.frame.origin.x  ,closestView.frame.origin.y,5, closestView.frame.size.height);
			CGRect rightSideRect=CGRectMake(closestView.frame.origin.x+closestView.frame.size.width-5  ,closestView.frame.origin.y, 5, closestView.frame.size.height);
			CGRect topSideRect=CGRectMake(closestView.frame.origin.x  ,closestView.frame.origin.y, closestView.frame.size.width, 5);
			CGRect downSideRect=CGRectMake(closestView.frame.origin.x  ,closestView.frame.origin.y+closestView.frame.size.height-5,closestView.frame.size.width, 5);
			
			CGRect leftInter=CGRectIntersection(bogyView.frame, leftSideRect);
			CGRect rightInter=CGRectIntersection(bogyView.frame, rightSideRect);

			CGRect topInter=CGRectIntersection(bogyView.frame, topSideRect);

			CGRect downInter=CGRectIntersection(bogyView.frame, downSideRect);
			int leftSum=leftInter.size.height+leftInter.size.width;
			int rightSum=rightInter.size.height+rightInter.size.width;

			int topSum=topInter.size.height+topInter.size.width;

			int downSum=downInter.size.height+downInter.size.width;
			
			
			
			
			
			 if((leftSum-topSum==1||leftSum-topSum==-1)||(rightSum-topSum==1||rightSum-topSum==-1))
			 {
				[self performSelector:@selector(onTimer) withObject:nil afterDelay:1.0 / 30.0];
				 return;
			 }
			if((leftSum-downSum==1||leftSum-downSum==-1)||(rightSum-downSum==1||rightSum-downSum==-1))
			{
				[self performSelector:@selector(onTimer) withObject:nil afterDelay:1.0 / 30.0];
				return;
			}
			
			
			
			if(leftSum==0&&rightSum==0&&topSum==0&&downSum==0)
			{
			[self performSelector:@selector(onTimer) withObject:nil afterDelay:1.0 / 30.0];
				return;
			}
			
			
			
			if(leftSum>rightSum)
			  {
				  
				 
				  
				  
				  if (leftSum>topSum) 
						{
								
							
							
							if(leftSum>downSum)//leftsum biggest
										{
													bogy.position=CGPointMake(bogy.position.x-0, bogy.position.y);
						
						
						
						
						
						
																if(leftSum==downSum||leftSum==rightSum||topSum==leftSum )
																		{
																					bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);//unused
																		}
						
						
						
						
																else 
																{
																	if (bogy.velocity.x<0) 
																	{
																		bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
																	}
																	else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
																}	
										}
				 
							else//downsum is biggest
									{
														//bogy.position=CGPointMake(bogy.position.x, bogy.position.y+2);
														
										if(leftSum==downSum||leftSum==rightSum)
										{
										   
														if(leftSum==downSum)
															{
						
																	if (bogy.velocity.y<0&&bogy.velocity.x<0)
																		{
																			bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
							
																		}
						
						
						
																	else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
					
					
															}
						
					 
						
						
						
													if(downSum==rightSum)
														{
							
																	if (bogy.velocity.y<0&&bogy.velocity.x>0)
																		{
																			bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
								
																		}
							
							
							
																	else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
														}
						                }
										else//regular downside hit
										{
											if(bogy.velocity.y>0)
												bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
											else
												bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
										}
					
					
					
									}
						
					
					
					
							
					   }
												//}
				
			
				  else
				      {//topsum>leftsum					{
									if (topSum>downSum) //topsum biggest
									{
												bogy.position=CGPointMake(bogy.position.x, bogy.position.y-0);
												
					
										if (topSum==leftSum||topSum==rightSum) 
										{
											
										
												if(topSum==rightSum)
							
												{
														if (bogy.velocity.y>0&&bogy.velocity.x>0)
														{
															bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
															
														}
							
							
						
														else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
												}
						
												if (topSum==leftSum) 
													{
							
						
														if (bogy.velocity.y>0&&bogy.velocity.x<0) 
														{
															bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
								
														}
							
							
							
														else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
						
						
									                }
										}
										else
										{
										
											if(bogy.velocity.y<0)
												bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
											else
												bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
											
										
										
										}							
							
							
							
							
							
							
							
									}
						
						
						
						
						
						
						
						
						
									else// downsum > top//downsum biggest
									{
												bogy.position=CGPointMake(bogy.position.x, bogy.position.y-2);
												if(leftSum==downSum||downSum==rightSum||topSum==downSum )
													bogy.velocity=CGPointMake(-bogy.velocity.x, -bogy.velocity.y);//unused
												else
												{
													
												
													if(bogy.velocity.y>0)
														bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
													else
														bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
													
												}
													


					
					
									}
					
				     }
			}
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		else//rightsum>leftsum
			{
				if (rightSum>downSum) 
				{
					if(rightSum>topSum)//rightsum biggest
					{
						bogy.position=CGPointMake(bogy.position.x+2, bogy.position.y);

						
					
						if(rightSum==downSum||leftSum==rightSum||topSum==rightSum )
						bogy.velocity=CGPointMake(-bogy.velocity.x, -bogy.velocity.y);
						else 
						{
							if (bogy.velocity.x>0) 
							{
								bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
							}
							else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
						}

							
				    }
					else //topsum<rightsum//topsum biggest
					{
						bogy.position=CGPointMake(bogy.position.x, bogy.position.y-2);

						
						if (topSum==leftSum||topSum==rightSum) 
						{
							
							
							if(topSum==rightSum)
								
							{
								if (bogy.velocity.y>0&&bogy.velocity.x>0)
								{
									bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
									
								}
								
								
								
								else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
							}
							
							if (topSum==leftSum) 
							{
								
								
								if (bogy.velocity.y>0&&bogy.velocity.x<0) 
								{
									bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
									
								}
								
								
								
								else bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
								
								
							}
						}
						else 
						{
							if(bogy.velocity.y<0)
								bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
							else
								bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
							
						
						
						}						
						
						
						
					}
					
				}
				else//downsum>rightsum &leftsum
				{
					if (downSum>topSum)//downsum biggest
					{
						bogy.position=CGPointMake(bogy.position.x, bogy.position.y+0);
						
					}
					else//topsum biggest
						bogy.position=CGPointMake(bogy.position.x, bogy.position.y-0);
					
					if(bogy.velocity.y>0)
							bogy.velocity=CGPointMake(-bogy.velocity.x, bogy.velocity.y);
					else
						bogy.velocity=CGPointMake(bogy.velocity.x, -bogy.velocity.y);
					

				}
				
				
				
			}
			
				

			
	/*if (bogy.velocity.x>0) 
	{
		if(bogy.velocity.x<1.5)
		{
		bogy.velocity=CGPointMake(3, bogy.velocity.y+arc4random()%1) ;
			//bogy.position=CGPointMake(bogy.position.x+5, bogy.position.y);

		
		}
		
		
	}
		 if(bogy.velocity.x<0)
		 {
							
		 if(bogy.velocity.x>-1.5)
		 {
			 bogy.velocity=CGPointMake(-3, bogy.velocity.y) ;

			 // bogy.position=CGPointMake(bogy.position.x-5, bogy.position.y);
			  
			  }
			  
			  
			  }
			
					 
			NSLog(@"bogys new velocity is %lf,%lf", bogy.velocity.x,bogy.velocity.y);

		 */
		 
		 
		 if (closestView.tag>110) 
			{ //if it is a mizrahi				
				
				
				
						if(closestView.image==[UIImage imageNamed:@"s_mizrahi_small.png"])
							{
								closestView.image=[UIImage imageNamed:@"s_mizrahi_emboss.png"];
								scoreLabel.text= [NSString stringWithFormat:@"%d", score+=15];
								
								NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/thunk.wav"];
								SystemSoundID soundID;
								NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
								AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
								AudioServicesPlaySystemSound(soundID);
							}
						else
						{
									if(!closestView.isAnimating)
										{
													closestView.animationImages = [NSArray arrayWithObjects:   
																			[UIImage imageNamed:@"explosion1.png"],
																			[UIImage imageNamed:@"explosion2.png"],
																			[UIImage imageNamed:@"explosion3.png"],
																			[UIImage imageNamed:@"explosion4.png"],
																			[UIImage imageNamed:@"explosion5.png"],
																			[UIImage imageNamed:@"explosion6.png"],
																			[UIImage imageNamed:@"explosion7.png"],
																			[UIImage imageNamed:@"explosion8.png"],
																			[UIImage imageNamed:@"explosion9.png"],
																			[UIImage imageNamed:@"explosion10.png"],
																			[UIImage imageNamed:@"explosion11.png"],
												   [UIImage imageNamed:@"explosion12.png"],
												   [UIImage imageNamed:@"explosion13.png"],
												   [UIImage imageNamed:@"explosion14.png"],
												   [UIImage imageNamed:@"explosion15.png"],
												   [UIImage imageNamed:@"explosion16.png"],
												   [UIImage imageNamed:@"explosion17.png"],
												   [UIImage imageNamed:@"explosion18.png"],
												   [UIImage imageNamed:@"explosion19.png"],
												   [UIImage imageNamed:@"explosion20.png"],
												   [UIImage imageNamed:@"explosion21.png"],
												   [UIImage imageNamed:@"explosion23.png"],
												   [UIImage imageNamed:@"explosion24.png"],
												   
												   
												   
												   
												   
												   
												   
												   nil];
					
					
										closestView.animationDuration = 1.00;
										// repeat the annimation forever
										closestView.animationRepeatCount =10;
										// start animating
										[closestView startAnimating];
											bogyView.image=[UIImage imageNamed:@"royke_devil_hurt_top.png"];
											bogy.animationLock=YES;
											[self performSelector:@selector (unlockAnimationLock) withObject:nil afterDelay: 0.10];
											
											
											scoreLabel.text= [NSString stringWithFormat:@"%d", score+=30];

											
											NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/metal_crunch.wav"];
											SystemSoundID soundID;
											NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
											AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
											AudioServicesPlaySystemSound(soundID);
											
											NSString *path1=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/fire.wav"];
											SystemSoundID soundID1;
											NSURL *filePath1=[ NSURL fileURLWithPath:path1 isDirectory:NO];
											AudioServicesCreateSystemSoundID((CFURLRef)filePath1, &soundID1);
											AudioServicesPlaySystemSound(soundID1);
											
										}
									else 
									{ 
										//[self mizrahiDrop:closestView ];
										  //
										[targetDic removeObjectForKey:[NSString stringWithFormat:@"%d",closestView.tag] ];
										[closestView removeFromSuperview];
										score+=50;
										scoreLabel.text= [NSString stringWithFormat:@"%d", score+=50];

									}
					}

					
				
				
			
			}
			
			
			
			
			
			
			
			else//if it is a macabi star
			{
				[copViewArray addObject:closestView];
			}
						

				
				
	/*			
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
							[tempCop initWithStartingPoint:closestView.frame.origin andView:tempCopView];
							
							NSLog(@"activeCop Created");
							score+=25;
							scoreLabel.text= [NSString stringWithFormat:@"%d", score];			
							break;
						}
					}
					
					
					
					
					
					
					
					
					[   closestView  removeFromSuperview]         ;
					[targetDic removeObjectForKey:[NSString stringWithFormat:@"%d",closestView.tag] ];
				}
			}	
			
			
			*/
			
			bogyView.image=[UIImage imageNamed:@"royke_devil_hurt_top.png"];
			bogy.animationLock=YES;
			[self performSelector:@selector (unlockAnimationLock) withObject:nil afterDelay: 0.10];
			
			
			
			NSString *path=[NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],@"/yyyyyyyyyyyyyyboing_x.wav"];
			SystemSoundID soundID;
			NSURL *filePath=[ NSURL fileURLWithPath:path isDirectory:NO];
			AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
			AudioServicesPlaySystemSound(soundID);
			
			
			
			
			
			
			
		//	break;
		}

	
	/*
	
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
	 */
	
	if ([targetDic count]<11) {
		
		//[self.view addSubview:<#(UIView * )view#>;
		[self.view removeFromSuperview];
		//[self release];
		//self=nil;
		
		UIApplication *tempWin=[ UIApplication sharedApplication];//.delegate.window;
		MarioMoveAppDelegate* tempdel=tempWin.delegate;
		tempdel.roykeController=self;
		[tempdel.window addSubview:tempdel.startController.view];//self.view];//;
		return;
		
		//addSubview:self.view];
		//return
	}
	if ([copViewArray count]>0)
	{
		DropStarOperation *dropOp=[[DropStarOperation alloc]init];//WithArray:copViewArray];
		dropOp.starsToDrop=copViewArray;
		[queue addOperation:dropOp];
		//[dropOp release];
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
	//bogyView.image=[UIImage imageNamed:@"royke_devil_small.png"];
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

										 -(void)mizrahiDrop:(UIImageView*) closestView
										 {
											 [copViewArray addObject:closestView];
											 [self performSelectorInBackground:@selector(mizrahiDown) withObject:nil];
										 }
			-(void)mizrahiDown
			{
				
					NSAutoreleasePool *pool = [NSAutoreleasePool new];
					
					
					
				

				
				BOOL keepOn=NO;
				for (int i=0;i<[copViewArray count];i++)
				{
					UIImageView *tempView=(UIImageView*)[copViewArray objectAtIndex:i];
					if(tempView.frame.origin.y<340)
					{
					tempView.frame=CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y+5, tempView.frame.size.width, tempView.frame.size.height);
						keepOn=YES;
					}
				}
				if(keepOn ==YES)
				{
					//[self performSelector:@selector(mizrahiDown)withObject:nil afterDelay:0.03];
					 [self performSelectorInBackground:@selector(mizrahiDown) withObject:nil];
				}
				[pool drain];
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
		if([[pastData objectForKey:@"royScores"] count]==0)//||YES)
	{
		NSArray *newArray=[NSArray arrayWithObjects:@"0:00",@"0:00",@"0:00",
						   @"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",@"0:00",nil];
		[pastData setObject:newArray forKey:@"royScores"];
	}

	NSArray *fuckit=[pastData objectForKey:@"royScores"];



		
		
	
	
	//[pastData synchronize];
	//	}
	
	
	
	/*bogyView.animationImages = [NSArray arrayWithObjects:   
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
	
	*/
	
	queue = [[NSOperationQueue alloc] init];

	
	mover = [Mover alloc];
	mover.position = CGPointMake(134, 300);
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
	for(int i=101;i<140;i++)
	{
		if([targetView viewWithTag:i])
			[targetDic setObject:[targetView viewWithTag:i] forKey:[NSString stringWithFormat:@"%d",i]];
		
		
		
		
	}
	
	
	//cops=[[NSMutableArray alloc]initWithObjects:[Cop alloc],[Cop alloc] ,[Cop alloc],[Cop alloc],nil];
	copViewArray=[[NSMutableArray alloc]init ];//WithObjects:cop1View,cop2View,cop3View,cop4View,nil];
	
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
