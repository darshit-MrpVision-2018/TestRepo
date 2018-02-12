//
//  UIViewController+NetworkConnection.m
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//
#import "UIViewController+Utils.h"
#import "AWIntroVC.h"

@implementation UIViewController (Utils)


#pragma mark - FB Login Helper Method -

- (NSString *)getFBToken {
    return [FBSDKAccessToken currentAccessToken].tokenString.length==0?@"":[FBSDKAccessToken currentAccessToken].tokenString;
}

- (void)fbLogin {
    FBSDKLoginManager *login ;
    login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    
    [login logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Logged in");
            NSLog(@"%@",result);
            [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
            [self fetchUserInforamtion];
        }
    }];
}

- (void)fetchUserInforamtion {
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,cover,picture,email,gender"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             if([self isKindOfClass:[AWIntroVC class]]){
                 AWIntroVC *intro = (AWIntroVC *) self;
                 [intro userFacebookDetails:result];
             }
             //             else if([self isKindOfClass:[RegistrationViewController class]]){
             //                 RegistrationViewController *regVC = (RegistrationViewController *) self;
             //                 [regVC fbDidSuccess:result];
             //             }
         }
         else{
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
}

@end
