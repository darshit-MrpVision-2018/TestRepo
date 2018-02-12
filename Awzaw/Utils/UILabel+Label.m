//
//  UILabel+Label.m
//  PynkBook
//
//  Created by ossc on 15/12/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import "UILabel+Label.h"

#define PADDING 8.0
#define CORNER_RADIUS 4.0

@implementation UILabel (Label)

- (void)shakeAnimation {
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.keyPath=@"position";
    animation.duration = 0.07;
    animation.repeatCount = 4;
    animation.autoreverses = true;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x - 10, self.center.y)];
    animation.toValue =[NSValue valueWithCGPoint:CGPointMake(self.center.x + 10, self.center.y)];
    [self.layer addAnimation:animation forKey:@"position"];
}

- (CGSize)boundingRect {
    NSMutableParagraphStyle *paragraphStyle = [NSParagraphStyle.defaultParagraphStyle mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect boundingRect = [self.text boundingRectWithSize: self.frame.size
                                             options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes: @{
                                                                                                                                           NSFontAttributeName : self.font,NSParagraphStyleAttributeName : paragraphStyle
                                                                                                                                           }  context: NULL];
    return boundingRect.size;
}

@end
