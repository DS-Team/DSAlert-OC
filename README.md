#DSAlert
目前为止，最为精简的 alert 和 actionSheet 封装！DSAlert 让你的弹框不再孤单！

---

## 更新提示：【倒叙更新】

#### version 1.0.0 
* 10、再次设计结构，新增frameWork静态库文件封装，喜欢简洁的你可以直接导入frameWork即可！
* 9、多种炫酷入场、退出动画，让你的APP各种叼！
* 8、新增高斯模糊，枚举选择，简单明了！
* 7、新增是否开启边缘触摸隐藏 alert 默认：关闭，属性：isTouchEdgeHide，可自由开关边缘触摸！
* 6、完美适配横竖屏
* 5、简单的两行搞定一个自定义 alert
* 4、手势触摸隐藏
* 3、可以自定义背景图片、按钮颜色
* 2、可以添加文字和图片，且可以滑动查看
* 1、理论完全兼容目前所有 iOS 系统版本

---

## 0、安装和导入示例：
* 0.1、使用方法1：pod 导入【当前最新版本：1.0.0】：<br> 
` pod 'DSAlert' ` <br>
导入头文件：<br>
`  #import <DSAlert.h> `
* 0.2、使用方法2：下载demo，把 DSAlert 文件夹拖入项目即可，<br>
导入头文件：<br>
`  #import "DSAlert.h" `<br>
如果使用 DSActionSheet 需导入头文件：<br>
`#import "DSActionSheet.h"`
* 0.3、使用方法3：frameWork ，把demo中的frameWork直接拖入项目即可<br>
`#import <DSAlertFrameWork/DSAlertFrameWork.h>`
* 0.4、项目源码地址：<br>
 OC版    ：[https://github.com/DS-Team/DSAlert-OC](https://github.com/DS-Team/DSAlert-OC)<br>
 swift 版：[https://github.com/DS-Team/DSAlert-swift](https://github.com/DS-Team/DSAlert-swift)

#### 注：swift 版正在调试，稍后上传！

---

## 1、图片示例：

![DSAlert.gif](https://github.com/DS-Team/DSAlert-OC/blob/master/DSAlert.gif)

---

## 2、代码示例：
* 2.1 类似系统 alert【加边缘手势消失】、高斯模糊背景

```
- (void)alert1
{
    DSWeak;
    /*! 第一种封装使用示例 */
    [DSAlert ds_showAlertWithTitle:@"温馨提示：" message:titleMsg1 image:nil buttonTitles:@[@"取消",@"确定"] configuration:^(DSAlert *temp) {
        
        //        temp.bgColor       = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
        /*! 开启边缘触摸隐藏alertView */
        temp.isTouchEdgeHide = YES;
        /*! 添加高斯模糊的样式 */
        temp.blurEffectStyle = DSAlertBlurEffectStyleLight;
        /*! 开启动画 */
        //        temp.isShowAnimate   = YES;
        //        /*! 进出场动画样式 默认为：1 */
        //        temp.animatingStyle  = 1;
    }actionClick:^(NSInteger index) {
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView1 ds_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert1";
            [weakSelf.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView1 ds_dismissAlertView];
        }
    }];
}
```

* 2.2 自定义按钮颜色

```
- (void)alert2
{
    /*! 2、自定义按钮颜色 */
    _alertView2                  = [[DSAlert alloc] ds_showTitle:@"温馨提示："
                                                         message:titleMsg2
                                                           image:nil
                                                    buttonTitles:@[@"取消", @"跳转VC2"]];
    /*! 自定义按钮文字颜色 */
    _alertView2.buttonTitleColor = [UIColor orangeColor];
    _alertView2.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.3];
    
    /*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
    _alertView2.showAnimate = YES;
    
    /*! 显示alert */
    [_alertView2 ds_showAlertView];
    DSWeak;
    _alertView2.buttonActionBlock = ^(NSInteger index){
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            [weakSelf.alertView2 ds_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert2";
            [weakSelf.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView2 ds_dismissAlertView];
        }
    };
}
```

* 2.3 自定义背景图片

```
- (void)alert3
{
    /*! 3、自定义背景图片 */
    _alertView3                  = [[DSAlert alloc] ds_showTitle:@"温馨提示："
                                                         message:titleMsg1
                                                           image:nil
                                                    buttonTitles:@[@"取消", @"确定"]];
    /*! 自定义按钮文字颜色 */
    _alertView3.buttonTitleColor = [UIColor orangeColor];
    /*! 自定义alert的背景图片 */
    _alertView3.bgImageName      = @"背景.jpg";
    /*! 开启动画，并且设置动画样式，默认：1 */
    //    _alertView3.isShowAnimate = YES;
    
    /*! 没有开启动画，直接进出场动画样式，默认开启动画 */
    _alertView3.animatingStyle  = DSAlertAnimatingStyleFall;
    
    /*! 显示alert */
    [_alertView3 ds_showAlertView];
    DSWeak;
    _alertView3.buttonActionBlock = ^(NSInteger index){
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ds_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert3";
            [weakSelf.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ds_dismissAlertView];
        }
    };
}
```

* 2.4 内置图片和文字，可滑动查看

```
- (void)alert4
{
    /*! 4、内置图片和文字，可滑动查看 */
    _alertView4                  = [[DSAlert alloc] ds_showTitle:@"温馨提示："
                                                         message:titleMsg1
                                                           image:[UIImage imageNamed:@"美女.jpg"]
                                                    buttonTitles:@[@"取消", @"跳转VC2"]];
    /*! 自定义按钮文字颜色 */
    _alertView4.buttonTitleColor = [UIColor orangeColor];
    /*! 自定义alert的背景图片 */
    _alertView4.bgImageName      = @"背景.jpg";
    /*! 是否显示动画效果 */
    _alertView4.showAnimate    = YES;
    /*! 显示alert */
    [_alertView4 ds_showAlertView];
    DSWeak;
    _alertView4.buttonActionBlock = ^(NSInteger index){
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView4 ds_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert4";
            [weakSelf.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView4 ds_dismissAlertView];
        }
    };
}
```

* 2.5 完全自定义alert

```
- (void)alert5
{
    /*! 5、完全自定义alert */
    UIView *view1                = [UIView new];
    view1.frame                  = CGRectMake(30, 100, SCREENWIDTH - 60, 200);
    view1.backgroundColor        = [UIColor yellowColor];
    view1.layer.masksToBounds    = YES;
    view1.layer.cornerRadius     = 10.0f;
    //    view1.clipsToBounds    = YES;
    
    _titleLabel                  = [UILabel new];
    _titleLabel.frame            = CGRectMake(0, 0, view1.frame.size.width, 40);
    _titleLabel.text             = @"测试title";
    _titleLabel.textAlignment    = NSTextAlignmentCenter;
    _titleLabel.font             = [UIFont systemFontOfSize:18];
    _titleLabel.backgroundColor  = [UIColor greenColor];
    [view1 addSubview:_titleLabel];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _chooseBtn                   = [[UIButton alloc]initWithFrame:CGRectMake(0, view1.frame.size.height - 40, view1.frame.size.width, 40)];
    //        _chooseBtn         = [UIButton buttonWithType:UIButtonTypeCustom];
    [_chooseBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_chooseBtn setBackgroundColor:[UIColor redColor]];
    [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_chooseBtn addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:_chooseBtn];
    _chooseBtn.autoresizingMask  = UIViewAutoresizingFlexibleWidth;
    
    _alertView5                  = [[DSAlert alloc] initWithCustomView:view1];
    _alertView5.showAnimate = YES;
    [_alertView5 ds_showAlertView];
}

- (void)cancleButtonAction:(UIButton *)sender
{
    NSLog(@"点击了取消按钮！");
    /*! 隐藏alert */
    [_alertView5 ds_dismissAlertView];
}
```

* 2.6 actionsheet

```
                [DSActionSheet ds_showActionSheetWithStyle:DSCustomActionSheetStyleNormal
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:nil
                                         ClikckButtonIndex:^(NSInteger index) {
                                             NSLog(@"你点击了第 %ld 行！",(long)index);
                                         }];
```

* 2.7 actionsheet带标题

```
[DSActionSheet ds_showActionSheetWithStyle:DSCustomActionSheetStyleTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:@"测试带标题的ActionSheet"
                                         ClikckButtonIndex:^(NSInteger index) {
                                             NSLog(@"你点击了第 %ld 行！",(long)index);
                                         }];
```

* 2.8 actionsheet带标题带图片

```
[DSActionSheet ds_showActionSheetWithStyle:DSCustomActionSheetStyleImageAndTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:@[[UIImage imageNamed:@"123.png"],[UIImage imageNamed:@"背景.jpg"],[UIImage imageNamed:@"美女.jpg"]]
                                                  redIndex:1
                                                     title:@"测试带标题和图片的ActionSheet"
                                         ClikckButtonIndex:^(NSInteger index) {
                                             NSLog(@"你点击了第 %ld 行！",(long)index);
                                         }];
```

## 3、DS-Team 简介
    DS-Team 是一个自发组织的民间团队，成立于2016年，致力于 iOS 最简洁的封装和最新技术的研发，一般都有 OC 和 swift 版本，后期会推出其他语言版本。

    为解决广大小白项目中遇到的各种疑难杂症，小伙伴儿们可以加入我们的QQ群 `479663605`，希望广大小白和大神能够积极加入！


## 4、系统要求

    该项目最低支持 iOS 7.0 和 Xcode 7.2（swift 版本只支持Xcode 7.3及以上版本），理论支持目前所有 iOS 系统版本！
	
---






