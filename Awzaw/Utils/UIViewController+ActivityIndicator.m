//
//  UIViewController+NetworkConnection.m
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//
#import "UIViewController+NetworkConnection.h"
#import "MRPSpinner.h"


@implementation UIViewController (ActivityIndicator)

-(void)showActivityIndicatorwithTitle:(NSString *)title animated:(BOOL)animated {
    
    [MRPSpinner setOnView:APP_DEL.window withTitle:title animated:animated];
//    [spinner showActivityIndicatorwithTitle:title animated:animated];
}

-(void)hideActivityIndicator {
    [MRPSpinner hideFromView:APP_DEL.window animated:YES];
}

@end
