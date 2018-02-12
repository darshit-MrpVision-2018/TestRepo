//
//  UIAlertController+AlertControlller.h
//  Vitto_Project
//
//  Created by ossc on 30/11/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


typedef void (^UIAlertCompletionBlock) (UIAlertController *alertViewController, NSInteger buttonIndex);

@interface UIAlertController (AlertControlller)

+ (instancetype)showAlertIn:(UIViewController *)controller
                  WithTitle:(NSString *)title
                    message:(NSString *)message
          cancelButtonTitle:(NSString *)cancelButtonTitle
          otherButtonTitles:(NSArray *)otherButtonTitles
                     style : (int) style
                   tapBlock:(UIAlertCompletionBlock)tapBlock;

- (NSString *)getFBToken;
- (void)fbLogin;
- (void)fetchUserInforamtion;

@end
