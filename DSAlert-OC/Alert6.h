//
//  Alert6.h
//  DSAlert-OC
//
//  Created by zeroLu on 16/9/8.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Alert6 : UIView

+ (instancetype)makeViewWithFrame:(CGRect)frame Title:(NSString *)title buttonTitles:(NSArray *)buttonTitles buttonBlock:(void (^)(NSInteger))block;

@end
