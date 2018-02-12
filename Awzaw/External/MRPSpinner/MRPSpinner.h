//
//  MRPSpinner.h
//  Awzaw
//
//  Created by Darshit Vora on 13/11/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"


@interface MRPSpinner : UIView

@property (nonatomic, strong) DGActivityIndicatorView *indicator;
@property (nonatomic, strong) UILabel *lblText;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setup;
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;
+ (UIView *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated;
@end
