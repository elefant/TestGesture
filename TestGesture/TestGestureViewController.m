//
//  TestGestureViewController.m
//  TestGesture
//
//  Created by bird on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestGestureViewController.h"
#import "FaceView.h"

@interface TestGestureViewController ()
@property (nonatomic, weak) IBOutlet FaceView* faceView;
@end

@implementation TestGestureViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;


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
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    NSLog(@"oooooo");
    return YES;
}
@end