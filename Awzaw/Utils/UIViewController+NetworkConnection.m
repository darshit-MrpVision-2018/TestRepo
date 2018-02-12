//
//  UIViewController+NetworkConnection.m
//  StepSister
//
//  Created by ossc on 06/12/16.
//  Copyright © 2016 Mrpvision. All rights reserved.
//
#import "MDSnackbar.h"
#import "UIViewController+NetworkConnection.h"
#import "Reachability.h"

@implementation UIViewController (NetworkConnection)
-(void)showNotificationForInternet{
    MDSnackbar *snackbar=[APP_DEL.window viewWithTag:45788];
    if(!snackbar){
        snackbar = [[MDSnackbar alloc] initWithText:@"Please turn on your data or connect to wifi." actionTitle:@""];
        snackbar.tag=45788;
        snackbar.multiline=true;
        snackbar.actionTitleColor = [UIColor colorWithRed:225.0/255.0 green:0.0/255.0 blue:80.0/255.0 alpha:0.6];
        [snackbar setTextColor:[UIColor colorWithRed:225.0/255.0 green:0.0/255.0 blue:80.0/255.0 alpha:0.6]];//
        snackbar.backgroundColor = [UIColor whiteColor];
    }
    if(![snackbar isShowing]){
        [snackbar show];
    }
}

-(BOOL)checkInternetConnection{
    Reachability *reachTest = [Reachability reachabilityWithHostname:@"www.apple.com"];
    NetworkStatus internetStatus = [reachTest  currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)){
        // [self hideActivity];
        return NO;
    }
    return YES;
}

@end
