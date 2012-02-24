//
//  FaceView.h
//  TestGesture
//
//  Created by Jian Hua Chen on 12/2/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView
@property (nonatomic) float scale;
- (void) pinch:(UIPinchGestureRecognizer*) gesture;
@end
