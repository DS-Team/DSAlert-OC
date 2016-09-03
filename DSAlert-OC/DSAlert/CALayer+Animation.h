
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


#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (MyAnimation)
/*!
 *  晃动动画
 *
 *  @param duration 一次动画用时
 *  @param radius   晃动角度0-180
 *  @param repeat   重复次数
 *  @param finish   动画完成
 */
- (void )shakeAnimationWithDuration:(NSTimeInterval )duration
                       shakeRadius:(CGFloat )radius
                            repeat:(NSUInteger )repeat
                   finishAnimation:(void(^)()) finish;

/*!
 *  根据路径执行动画
 *
 *  @param duration 一次动画用时
 *  @param path     路径CGPathRef
 *  @param repeat   重复次数
 *  @param finish   动画完成
 */
- (void )pathAnimationWithDuration:(NSTimeInterval )duration
                             path:(CGPathRef )path
                           repeat:(NSUInteger )repeat
                  finishAnimation:(void(^)()) finish;


/*! 这两个动画只适合本项目 */
/*! 天上掉下 */
- (void )fallAnimationWithDuration:(NSTimeInterval )duration
                  finishAnimation:(void(^)()) finish;
/*! 上升 */
- (void )floatAnimationWithDuration:(NSTimeInterval )duration
                   finishAnimation:(void(^)()) finish;
@end


@interface UIView (MyAnimation)
/*!
 *  缩放显示动画
 *
 *  @param finish 动画完成
 */

- (void )scaleAnimationShowFinishAnimation:(void(^)()) finish;
/*!
 *  缩放隐藏动画
 *
 *  @param finish 动画完成
 */
- (void )scaleAnimationDismissFinishAnimation:(void(^)()) finish;

@end