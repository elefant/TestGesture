//
//  FaceView.m
//  TestGesture
//
//  Created by Jian Hua Chen on 12/2/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
@synthesize scale = _scale;

-(CGFloat) scale
{
    if( !_scale)
    {
        return 0.75;
    } else {
        return _scale;
    }
}

- (void) setScale:(float)scale
{
    if( scale != _scale ) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

-(void) pinch:(UIPinchGestureRecognizer *) gesture
{
    
    if( (gesture.state == UIGestureRecognizerStateChanged )|| (gesture.state == UIGestureRecognizerStateEnded) ) 
    {
        NSLog(@"gesture.scale %f", gesture.scale);
        self.scale = gesture.scale;
        // is this line really needed???????
        //gesture.scale =1;
    }
}

-(void) setup
{
    self.contentMode = UIViewContentModeRedraw;
}

-(void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) drawCircleAtPoint: (CGPoint) p withRadius:(CGFloat)radius inContext:(CGContextRef) context
{
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw face
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width /2 ;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width /2;
    if(self.bounds.size.height < self.bounds.size.width ) size = self.bounds.size.height /2;
    size *= self.scale;
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor greenColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    // draw eyes
    
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * 0.2;
    eyePoint.y = midPoint.y - size * 0.2;
    [self drawCircleAtPoint:eyePoint withRadius:size*0.1 inContext:context];
    eyePoint.x += 2 * size * 0.2;
    [self drawCircleAtPoint:eyePoint withRadius:size*0.1 inContext:context];
    // no nose
    // draw mouth
    
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.3
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += 2* MOUTH_H*size;
    
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3 ;
    
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3 ;
    
    float smile = 1.0;
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}


@end
