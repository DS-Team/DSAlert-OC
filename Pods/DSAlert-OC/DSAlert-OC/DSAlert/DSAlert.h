
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


#import <UIKit/UIKit.h>

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height

#define DSWeak         __weak __typeof(self) weakSelf = self


/*! 背景高斯模糊枚举 默认：1 */
typedef NS_ENUM(NSInteger, DSAlertBlurEffectStyle) {
    /*! 较亮的白色模糊 */
    DSAlertBlurEffectStyleExtraLight = 1,
    /*! 一般亮的白色模糊 */
    DSAlertBlurEffectStyleLight,
    /*! 深色背景模糊 */
    DSAlertBlurEffectStyleDark
} NS_ENUM_AVAILABLE_IOS(7_0);

/*! 进出场动画枚举 默认：1 */
typedef NS_ENUM(NSUInteger, DSAlertAnimatingStyle) {
    /*! 缩放显示动画 */
    DSAlertAnimatingStyleScale = 1,
    /*! 晃动动画 */
    DSAlertAnimatingStyleShake,
    /*! 天上掉下动画 / 上升动画 */
    DSAlertAnimatingStyleFall,
};

@interface DSAlert : UIView

/*! 背景颜色 默认：半透明*/
@property (nonatomic, strong) UIColor   *bgColor;

///*! 按钮字体颜色 默认：白色*/
//@property (nonatomic, strong) UIColor   *buttonTitleColor;

/*! 是否开启边缘触摸隐藏 alert 默认：NO */
@property (nonatomic, assign) BOOL       isTouchEdgeHide;

/*! 背景图片名字 默认：没有图片*/
@property (nonatomic, strong) NSString  *bgImageName;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL       showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) DSAlertAnimatingStyle animatingStyle;

/*! 背景高斯模糊枚举 默认：1 */
@property (nonatomic, assign) DSAlertBlurEffectStyle blurEffectStyle;

/*!
 * 按钮点击事件回调
 */
@property (strong, nonatomic) void (^buttonActionBlock)(NSInteger index);

/**
 *  autoresizing的开关,如果在使用全自定义的方式而且使用autoresizing的情况下可以设置这个为true.  默认:false
 */
@property (assign, nonatomic) BOOL UseAutoresizing;


#pragma mark - 1、高度封装一行即可完全配置alert，如不习惯，可使用第二种常用方法
/*!
 *  创建一个完全自定义的 alertView
 *
 *  @param customView    自定义 View
 *  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
 */
+ (void)ds_showCustomView:(UIView *)customView
            configuration:(void (^)(DSAlert *tempView)) configuration;

/*!
 *  创建一个类似于系统的alert
 *
 *  @param title         标题：可空
 *  @param message       消息内容：可空
 *  @param image         图片：可空
 *  @param buttonTitles  按钮标题：不可空
 *  @param buttonTitles  按钮标题颜色：可空，默认蓝色
 *  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
 *  @param action        按钮的点击事件处理
 */
+ (void)ds_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                        image:(UIImage *)image
                 buttonTitles:(NSArray *)buttonTitles
            buttonTitlesColor:(NSArray <UIColor *>*)buttonTitlesColor
                configuration:(void (^)(DSAlert *tempView)) configuration
                  actionClick:(void (^)(NSInteger index)) action;

#pragma mark - 2、常用方法
/*!
 *  初始化自定义动画视图
 *  @return instancetype
 */
- (instancetype)initWithCustomView:(UIView *)customView;

/*!
 *  创建一个类似系统的警告框
 *
 *  @param title        title
 *  @param message      message
 *  @param image        image
 *  @param buttonTitles 按钮的标题
 *  @param buttonTitles  按钮标题颜色：可空，默认蓝色
 *  @return 创建一个类似系统的警告框
 */
- (instancetype)ds_showTitle:(NSString *)title
                     message:(NSString *)message
                       image:(UIImage *)image
                buttonTitles:(NSArray *)buttonTitles
           buttonTitlesColor:(NSArray <UIColor *>*)buttonTitlesColor;

/*!
 *  视图显示
 */
- (void)ds_showAlertView;

/*!
 *  视图消失
 */
- (void)ds_dismissAlertView;


@end
