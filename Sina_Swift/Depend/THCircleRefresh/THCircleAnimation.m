//
//  YMCircleAnimation.m
//  YMCircleRefreshView
//
//  Created by zym on 15/11/25.
//  Copyright © 2015年 zym. All rights reserved.
//

#import "THCircleAnimation.h"

static NSString* const THPullToRefreshSpinAnimationKey = @"SpinAnimation";

@interface THCircleAnimation ()


@property BOOL animating;

@end

@implementation THCircleAnimation

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        
        CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5;
        CGPoint center = CGPointMake(radius, radius);
        UIBezierPath* bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
        
        self.circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
        self.circle.bounds = self.bounds;
        self.circle.path = bezierPath.CGPath;
        self.circle.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
    }
    return self;
}

- (CAShapeLayer*)circle {
    if(!_circle) {
        _circle = [CAShapeLayer layer];
//        _circle.fillColor = [UIColor colorWithRed:255/255.f green:168/255.f blue:1/255.f alpha:1].CGColor; /*#2c3e50*/
        _circle.fillColor = [UIColor whiteColor].CGColor;
        _circle.contentsScale = self.layer.contentsScale;
        [self.layer addSublayer:_circle];
    }
    return _circle;
}


- (void)startAnimating {
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    self.circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
    self.circle.bounds = self.bounds;
    self.circle.path = bezierPath.CGPath;
    self.circle.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    opacityAnimation.fromValue = @1.0;
    opacityAnimation.toValue = @0.0;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.65 :1];
    
    animationGroup.duration = 1.0;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[ scaleAnimation, opacityAnimation ];
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [self.circle addAnimation:animationGroup forKey:THPullToRefreshSpinAnimationKey];
    self.circle.transform = CATransform3DMakeScale(0, 0, 0);
    self.circle.opacity = 1.0;
    
    self.animating = YES;
}

- (void)stopAnimating {
    [self.circle removeAnimationForKey:THPullToRefreshSpinAnimationKey];
    self.circle.transform = CATransform3DMakeScale(0, 0, 0);
    self.circle.opacity = 1.0;
    
    self.animating = NO;
}


@end
