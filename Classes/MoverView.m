//
//  MoverView.m
//  MarioMove
//
//  Created by yair stabinsky on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoverView.h"


@implementation MoverView
//@synthesize touchOrigin;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
            }
    return self;
}
- (void)refresh:(CGRect)rect {
    moverRect = rect;
    [self setNeedsDisplay];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */
- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
	CGContextSetLineWidth(context, 1.0);
	CGContextAddEllipseInRect(context, CGRectMake (moverRect.origin.x,moverRect.origin.y,25,25));
	CGContextAddEllipseInRect(context, CGRectMake(0,0,50,90) ) ;
	CGContextStrokePath(context);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject]; 
	
	touchOrigin= [touch locationInView:self];
}
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	

	UITouch* touch = [touches anyObject]; 
	touchOrigin= [touch locationInView:self];
	//NSLog(@" %l@",touch);
	//NSLog(@" %lf",event.timestamp);
	//NSLog(@" %@",[touches allObjects]);
	
	
	//if( numTaps >= 1 )
	//[m_pManager doStateChange:[gsTest class]];
	
}

-(CGPoint) returnTouchOrigin
{   	return touchOrigin;
		

}


- (void)dealloc {
    [super dealloc];
}
 

-(void) setTouchOrigin:(CGPoint)newPoint
{
	touchOrigin=newPoint;
}
	


@end
