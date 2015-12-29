//
//  YMCirclePullToRefresh.m
//  YMCircleRefreshView
//
//  Created by zym on 15/11/25.
//  Copyright © 2015年 zym. All rights reserved.
//

#import "THCircleRefreshHeader.h"
#import "THCircleAnimation.h"

@interface THCircleRefreshHeader ()
@property (nonatomic, strong) THCircleAnimation *circleAnimation;

@end

@implementation THCircleRefreshHeader


-(void)prepare{
    [super prepare];
    self.circleAnimation = [[THCircleAnimation alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [self addSubview:self.circleAnimation];
}

-(void)placeSubviews{
    [super placeSubviews];
    self.circleAnimation.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
}


-(void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    if (state == MJRefreshStateIdle){
        [self.circleAnimation stopAnimating];
    }
    if (state == MJRefreshStateRefreshing) {
        [self.circleAnimation startAnimating];
    }
}

-(void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    if (self.state == MJRefreshStateIdle ) {
        self.circleAnimation.circle.transform = CATransform3DMakeScale(pullingPercent, pullingPercent, pullingPercent);
    }
    
}

-(void)executeRefreshingCallback{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MJRefreshMsgSend(MJRefreshMsgTarget(self.refreshingTarget), self.refreshingAction, self);
            });
        }
    });
}


@end
