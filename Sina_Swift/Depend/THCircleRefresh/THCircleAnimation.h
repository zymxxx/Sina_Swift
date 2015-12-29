//
//  YMCircleAnimation.h
//  YMCircleRefreshView
//
//  Created by zym on 15/11/25.
//  Copyright © 2015年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THCircleAnimation : UIView
@property (nonatomic) CAShapeLayer* circle;
- (void)startAnimating;
- (void)stopAnimating;

@end
