
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



#import "DSActionSheet.h"
#import "DSTableCell.h"

@interface DSActionSheet ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
/*! tableView */
@property (strong, nonatomic) UITableView  *tableView;
/*! 触摸背景消失 */
@property (strong, nonatomic) UIControl    *overlayControl;
/*! 数据源 */
@property (strong, nonatomic) NSArray      *dataArray;
/*! 图片数组 */
@property (strong, nonatomic) NSArray      *imageArray;
/*! 标记颜色是红色的那行 */
@property (assign, nonatomic) NSInteger    specialIndex;
/*! 标题 */
@property (copy, nonatomic  ) NSString     *title;
/*! 点击事件回调 */
@property (copy, nonatomic) void(^callback)(NSInteger index);
/*! 自定义样式 */
@property (assign, nonatomic) DSCustomActionSheetStyle viewStyle;

@end

@implementation DSActionSheet

+ (instancetype)shareActionSheet
{
    DSActionSheet *actionSheet   = [[self alloc] init];
    actionSheet.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    return actionSheet;
}

/*!
 *
 *  @param style             样式
 *  @param contentArray      选项数组(NSString数组)
 *  @param imageArray        图片数组(UIImage数组)
 *  @param redIndex          特别颜色的下标数组(NSNumber数组)
 *  @param title             标题内容(可空)
 *  @param clikckButtonIndex block回调点击的选项
 */
+ (void)ds_showActionSheetWithStyle:(DSCustomActionSheetStyle)style
                       contentArray:(NSArray<NSString *> *)contentArray
                         imageArray:(NSArray<UIImage *> *)imageArray
                           redIndex:(NSInteger)redIndex
                              title:(NSString *)title
                      configuration:(void (^)(DSActionSheet *tempView)) configuration
                  ClikckButtonIndex:(ButtonActionBlock)clikckButtonIndex
{
    DSActionSheet *actionSheet       = [self shareActionSheet];
    actionSheet.dataArray            = contentArray;
    actionSheet.callback             = clikckButtonIndex;
    actionSheet.viewStyle            = style;
    actionSheet.imageArray           = imageArray;
    actionSheet.specialIndex         = redIndex;
    actionSheet.title                = title;
    if (configuration)
    {
        configuration(actionSheet);
    }
    [actionSheet.tableView reloadData];
    [actionSheet show];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        if ( self.viewStyle == DSCustomActionSheetStyleNormal || self.viewStyle == DSCustomActionSheetStyleImage )
        {
            return self.dataArray.count;
        }
        else
        {
            return self.dataArray.count + 1;
        }
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 0)?8.f:0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSTableCell *cell = [tableView dequeueReusableCellWithIdentifier:DSASCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = (self.title)?UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
    if ( 0 == indexPath.section )
    {
        if ( indexPath.row == self.specialIndex )
        {
            cell.customTextLabel.textColor = [UIColor redColor];
        }
        
        if ( self.viewStyle == DSCustomActionSheetStyleNormal )
        {
            cell.customTextLabel.text = self.dataArray[indexPath.row];
        }
        else if ( self.viewStyle == DSCustomActionSheetStyleTitle )
        {
            cell.customTextLabel.text = (indexPath.row ==0) ? self.title : self.dataArray[indexPath.row-1];
        }
        else
        {
            
            NSInteger index = (self.title) ? indexPath.row - 1 : indexPath.row;
            if ( index >= 0 )
            {
                cell.customImageView.image = self.imageArray[index];
            }
            
            cell.customTextLabel.text = (indexPath.row == 0) ? self.title : self.dataArray[indexPath.row-1];
        }
    }
    else
    {
        cell.customTextLabel.text = @"取 消";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 0 == indexPath.section )
    {
        NSInteger index = 0;
        if ( self.viewStyle == DSCustomActionSheetStyleNormal || self.viewStyle == DSCustomActionSheetStyleImage )
        {
            index = indexPath.row;
        }
        else
        {
            index = indexPath.row - 1;
        }
        if (-1 == index)
        {
            NSLog(@"【 DSActionSheet 】标题不能点击！");
            return;
        }
        self.callback(index);
    }
    else if ( 1 == indexPath.section )
    {
        NSLog(@"【 DSActionSheet 】你点击了取消按钮！");
        [self fadeOut];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UpdateFrame
- (void)fadeIn
{
    CGFloat tableViewHeight = MIN(SCREENHEIGHT - 64.f, self.tableView.contentSize.height);
    self.tableView.frame = CGRectMake(0.f, 0.f, SCREENWIDTH, tableViewHeight);
    
    self.frame = CGRectMake(0.f, SCREENHEIGHT, SCREENWIDTH, tableViewHeight);
    DSWeak;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.frame = CGRectMake(0.f, SCREENHEIGHT - tableViewHeight, SCREENWIDTH, tableViewHeight);
    }];
}

- (void)fadeOut
{
    DSWeak;
    [UIView animateWithDuration:.25f animations:^{
        weakSelf.frame = CGRectMake(0.f, SCREENHEIGHT, SCREENWIDTH, CGRectGetHeight(weakSelf.frame));
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.overlayControl removeFromSuperview];
            weakSelf.overlayControl = nil;
            [weakSelf removeFromSuperview];
        }
    }];
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    CGFloat tableViewHeight       = MIN(SCREENHEIGHT - 64.f, self.tableView.contentSize.height);
    self.tableView.frame      = CGRectMake(0.f, 0.f, SCREENWIDTH, tableViewHeight);
    self.frame                = CGRectMake(0.f, SCREENHEIGHT - tableViewHeight, SCREENWIDTH, tableViewHeight);
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self.overlayControl];
    [keywindow addSubview:self];
    [self fadeIn];
}

- (void)ds_dismissDSActionSheet
{
    NSLog(@"【 DSActionSheet 】你触摸了背景隐藏！");
    [self fadeOut];
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if ( !_tableView )
    {
        _tableView                 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.scrollEnabled   = NO;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
        [self addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:DSASCellIdentifier bundle:nil] forCellReuseIdentifier:DSASCellIdentifier];
    }
    return _tableView;
}

- (UIControl *)overlayControl
{
    if ( !_overlayControl )
    {
        _overlayControl                 = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayControl.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_overlayControl addTarget:self action:@selector(ds_dismissDSActionSheet) forControlEvents:UIControlEventTouchUpInside];
        _overlayControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    }
    return _overlayControl;
}

@end
