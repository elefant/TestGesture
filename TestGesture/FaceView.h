//
//  FaceView.h
//  TestGesture
//
//  Created by Jian Hua Chen on 12/2/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource

-(float) smileForFaceView:(FaceView*) faceview;
@end

@interface FaceView : UIView
@property (nonatomic) float scale;
- (void) pinch:(UIPinchGestureRecognizer*) gesture;
@property (nonatomic, weak) id<FaceViewDataSource> dataSource;
@end
