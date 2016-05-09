//
//  ProgressView.h
//  CircleAnimationTest
//
//  Created by ly on 15/11/6.
//  Copyright (c) 2015年 zmit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView


@property (nonatomic,assign) float haveFinished;
@property (nonatomic,assign) CGRect rect;

@property (nonatomic,assign) float strokeStart;
@property (nonatomic,assign) float strokeEnd;

@property (nonatomic,assign) float lineWidth;
@end
