
/*!
 *  @brief      DSAlert-OC
 *
 *  @author     DS-Team
 *  @copyright  Copyright © 2016年 DS-Team. All rights reserved.
 *  @version    V1.0.0
 */

/*
 ***************************   DSAlert 项目简介：  **********************
 
 1、开发人员【DS-Team】：
 孙博岩：[『https://github.com/boai』](https://github.com/boai)<br>
 陆晓峰：[『https://github.com/zeR0Lu』](https://github.com/zeR0Lu)<br>
 陈集  ：[『https://github.com/chenjipdc』](https://github.com/chenjipdc)
 2、项目源码地址：
 OC版   ：https://github.com/DS-Team/DSAlert-OC
 swift版：https://github.com/DS-Team/DSAlert-swift
 3、安装及使用方式：
 * 3.1、pod 导入【当前最新版本：1.0.0】：
 pod 'DSAlert'
 导入头文件：#import <DSAlert.h>
 * 3.2、下载demo，把 DSAlert 文件夹拖入项目即可，
 导入头文件：#import "DSAlert.h"
 4、如果开发中遇到特殊情况或者bug，请及时反馈给我们，谢谢！
 5、也可以加入我们的大家庭：QQ群 【 479663605 】，希望广大小白和大神能够积极加入！
 
 */




#import "CALayer+Animation.h"

@implementation CALayer (MyAnimation)
- (void )shakeAnimationWithDuration:(NSTimeInterval )duration
                        shakeRadius:(CGFloat )radius
                             repeat:(NSUInteger )repeat
                    finishAnimation:(void(^)()) finish
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.duration = duration;
    keyAnimation.keyPath = @"transform.rotation.z";
    keyAnimation.values = @[@((0) / 180.0 * M_PI),@((-radius) / 180.0 * M_PI),@((radius) / 180.0 * M_PI),@((-radius) / 180.0 * M_PI),@((0) / 180.0 * M_PI)];
    keyAnimation.repeatCount = repeat;
    [self addAnimation:keyAnimation forKey:nil];
    if (finish)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * (CGFloat )repeat * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            finish();
        });
    }
}

- (void )pathAnimationWithDuration:(NSTimeInterval )duration
                              path:(CGPathRef )path
                            repeat:(NSUInteger )repeat
                   finishAnimation:(void(^)()) finish
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    keyAnimation.duration = duration;
    keyAnimation.repeatCount = repeat;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.path = path;
    [self addAnimation:keyAnimation forKey:nil];
    if (finish)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration * (CGFloat )repeat - 0.1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            finish();
        });
    }
}

- (void )fallAnimationWithDuration:(NSTimeInterval )duration
                   finishAnimation:(void(^)()) finish
{
    CGRect frame = [UIScreen mainScreen].bounds;
    CGPoint center = CGPointMake(CGRectGetWidth(frame)*0.5, (CGRectGetHeight(frame) * 0.5));
    CGPoint point = CGPointMake(CGRectGetWidth(frame)*0.5, -(CGRectGetHeight(self.frame)));
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point];
    [path addLineToPoint:center];
    
    [self pathAnimationWithDuration:duration path:path.CGPath repeat:1 finishAnimation:^{
        if (finish)
        {
            finish();
        }
    }];
}

- (void )floatAnimationWithDuration:(NSTimeInterval )duration
                    finishAnimation:(void(^)()) finish
{
    CGRect frame = [UIScreen mainScreen].bounds;
    CGPoint center = CGPointMake(CGRectGetWidth(frame)*0.5, (CGRectGetHeight(frame) * 0.5));
    CGPoint point = CGPointMake(CGRectGetWidth(frame)*0.5, -(CGRectGetHeight(self.frame)));
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addLineToPoint:point];
    
    [self pathAnimationWithDuration:duration path:path.CGPath repeat:1 finishAnimation:^{
        if (finish)
        {
            finish();
        }
    }];
}
@end


@implementation UIView(MyAnimation)


- (void )scaleAnimationShowFinishAnimation:(void(^)()) finish
{
    self.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    [UIView animateWithDuration:0.35f animations:^{
        self.transform = CGAffineTransformMakeScale(1.18f, 1.18f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        } completion:^(BOOL finished) {
            if (finish) {
                finish();
            }
        }];
    }];
}

- (void )scaleAnimationDismissFinishAnimation:(void(^)()) finish
{
    [UIView animateWithDuration:0.15f animations:^{
        self.transform = CGAffineTransformMakeScale(1.18f, 1.18f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001f, 0.0001f);
        } completion:^(BOOL finished) {
            if (finish) {
                finish();
            }
        }];
    }];
}

@end
