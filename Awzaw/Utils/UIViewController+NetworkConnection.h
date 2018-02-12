//
//  UIViewController+NetworkConnection.h
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSnackbar.h"
@interface UIViewController (NetworkConnection)
-(void)showNotificationForInternet;
-(BOOL)checkInternetConnection;
@end
