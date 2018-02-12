//
//  UIFont+Utils.m
//  OneTouch
//
//  Copyright © 2016 sourcetask. All rights reserved.
//

#import "UIFont+Utils.h"

@implementation UIFont (Utils)

#pragma mark - Museo

+ (UIFont *)light:(CGFloat)size {
    return [UIFont fontWithName:@"Quicksand-Light" size:size];
}

+ (UIFont *)regular:(CGFloat)size {
    return [UIFont fontWithName:@"Quicksand-Regular" size:size];
}

+ (UIFont *)bold:(CGFloat)size {
    return [UIFont fontWithName:@"Quicksand-Bold" size:size];
}

+ (UIFont *)medium:(CGFloat)size {
    return [UIFont fontWithName:@"Quicksand-Medium" size:size];
}

@end
