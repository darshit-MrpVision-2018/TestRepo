//
//  UIViewController+NetworkConnection.h
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)


- (NSString *)getFBToken;
- (void)fbLogin;
- (void)fetchUserInforamtion;
@end
