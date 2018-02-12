//
//  UIViewController+NetworkConnection.h
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomNavigation)

- (void)setCustomNavigationWithTitle:(NSString *)title bgColor:(UIColor *)color leftButton:(UIButton *)leftBtn rightButton:(UIButton *)rightBtn;

- (UIButton *)setCustomNavigationButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor;


@end
