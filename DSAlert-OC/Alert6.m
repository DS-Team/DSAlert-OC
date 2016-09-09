//
//  Alert6.m
//  DSAlert-OC
//
//  Created by zeroLu on 16/9/8.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "Alert6.h"

@interface Alert6 ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (copy, nonatomic) void(^callback)(NSInteger index);
@end

@implementation Alert6

+ (instancetype)makeViewWithFrame:(CGRect)frame Title:(NSString *)title buttonTitles:(NSArray *)buttonTitles buttonBlock:(void (^)(NSInteger))block {
    Alert6 *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Alert6 class]) owner:self options:nil] firstObject];
    view.frame = frame;
    [view setNeedsLayout];
    
    view.titleLabel.text = title;
    if ( buttonTitles.count == 2 ) {
        [view.leftBtn setTitle:buttonTitles[0] forState:UIControlStateNormal];
        [view.rightBtn setTitle:buttonTitles[1] forState:UIControlStateNormal];
        view.leftBtn.tag = 1;
        view.rightBtn.tag = 2;
    }else {
        NSLog(@"按钮标题数要跟按钮个数一致");
    }
    view.callback = block;
    return view;
}

- (IBAction)didButtonAction:(UIButton *)sender {
    if ( self.callback ) {
        self.callback(sender.tag);
    }
}


@end
