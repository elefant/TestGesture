//
//  TestGestureViewController.m
//  TestGesture
//
//  Created by bird on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestGestureViewController.h"
#import "FaceView.h"

@interface TestGestureViewController () <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView* faceView;
@end

@implementation TestGestureViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize panRecognizer = _panRecognizer;

- (float) smileForFaceView:(FaceView *)faceview
{
    return (self.happiness - 50) / 50.0;
}

- (void) setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
    
}

-(void) setFaceView:(FaceView *)faceView
{
    NSLog(@"xxxxooxxxxx");
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    self.panRecognizer.minimumNumberOfTouches = 2;
    [self.faceView addGestureRecognizer:self.panRecognizer];
    self.faceView.dataSource = self;
}

- (void) handlePan:(UIPanGestureRecognizer *)gesture
{
    if( gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded )
    {
        CGPoint translation = [gesture translationInView:self.view];
        NSLog(@"handlePan %f", translation.y);
    
        int happiness = self.happiness + translation.y / 2;
        [self setHappiness:happiness];
    
        [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    NSLog(@"oooooo");
    return YES;
}
@end