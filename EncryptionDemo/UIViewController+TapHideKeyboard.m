//
//  UIViewController+TapHideKeyboard.m
//  SmartFoot
//
//  Created by GrayLand on 16/11/18.
//  Copyright © 2016年 icomwell. All rights reserved.
//

#import "UIViewController+TapHideKeyboard.h"

@implementation UIViewController (TapHideKeyboard)

- (void)addTapToHideGestureInView:(UIView *)view
{
    if ([view isEqual:self.view] || !view) {
        UIView *tapView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHideKeyboard)];
        tap.numberOfTapsRequired    = 1;
        tap.numberOfTouchesRequired = 1;
        [tapView addGestureRecognizer:tap];
        [self.view addSubview:tapView];
        [self.view sendSubviewToBack:tapView];
    }else{
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHideKeyboard)];
        tap.numberOfTapsRequired    = 1;
        tap.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:tap];
    }
}

- (void)onHideKeyboard
{
    [self.view endEditing:YES];
}
@end
