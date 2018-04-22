//
//  KKRefreshingView.m
//  DZNEmptyDataSet
//
//  Created by keke on 2018/4/21.
//

#import "KKRefreshingView.h"

@implementation KKRefreshingView

- (void)kk_startCircle {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 2. 设置动画属性
    // 不停的旋转
    // 1) 旋转一周
    [anim setToValue:@(2 * M_PI)];
    // 2) 不停的旋转 - 动画循环播放
    // HUGE_VALF 是一个非常大得浮点数，指定此数值可以认为动画无限循环
    // MAXFLOAT
    [anim setRepeatCount:HUGE_VALF];
    
    [anim setDuration:0.8f];
    
    // 3) 动画完成时删除
    // 对于循环播放的动画效果，一定要将removedOnCompletion设置为NO，否则无法恢复动画
    [anim setRemovedOnCompletion:NO];
    
    // 3. 添加动画
    // key可以随便指定，用于判断图层中是否存在该动画
    [self.layer addAnimation:anim forKey:@"rotationAnim"];
}

- (void)kk_removeCircle {
    [self.layer removeAllAnimations];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, self.circleLineColorWhite ? [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.5].CGColor : [UIColor colorWithRed:0.69 green:0.76 blue:0.83 alpha:1.00].CGColor);
    CGContextAddArc(context, 25, 25, 13, -M_PI_2, -M_PI_2 + (M_PI * 2  - M_PI_4 / 2)* 0.97, 0);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);
}

@end
