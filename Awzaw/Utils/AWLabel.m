//
//  HOButton.m
//  HowzitApp
//
//  Created by Vlad Batrinu on 12/28/15.
//  Copyright © 2015 sourcetask. All rights reserved.
//

#import "AWLabel.h"

#define PADDING 5.0
#define CORNER_RADIUS 4.0

@implementation AWLabel

- (void)drawRect:(CGRect)rect {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CORNER_RADIUS;
    UIEdgeInsets insets = {0, PADDING, 0, PADDING};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize] ;
    intrinsicSuperViewContentSize.width += PADDING * 2 ;
    return intrinsicSuperViewContentSize ;
}


@end
