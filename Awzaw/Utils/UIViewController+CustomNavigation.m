//
//  UIViewController+NetworkConnection.m
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//
#import "UIViewController+CustomNavigation.h"

@implementation UIViewController (CustomNavigation)

- (void)setCustomNavigationWithTitle:(NSString *)title bgColor:(UIColor *)color leftButton:(UIButton *)leftBtn rightButton:(UIButton *)rightBtn {
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont regular:14.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = title;
    // emboss in the same way as the native title
    [label setShadowColor:[UIColor darkGrayColor]];
    [label setShadowOffset:CGSizeMake(0, -0.5)];
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.backgroundColor = color;
}

- (UIButton *)setCustomNavigationButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    btn.frame = frame;//CGRectMake(10, 0, 44, 44.0);
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    return btn;
    
}

@end
