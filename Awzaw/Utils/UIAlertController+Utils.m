//
//  UIAlertController+AlertControlller.m
//  Vitto_Project
//
//  Created by ossc on 30/11/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import "UIAlertController+Utils.h"

@implementation UIAlertController (Utils)
+ (instancetype)showAlertIn:(UIViewController *)controller
                  WithTitle:(NSString *)title
                    message:(NSString *)message
          cancelButtonTitle:(NSString *)cancelButtonTitle
          otherButtonTitles:(NSArray *)otherButtonTitles
                     style : (int) style
                   tapBlock:(UIAlertCompletionBlock)tapBlock {
    
    UIAlertController *alertController = [self alertControllerWithTitle:title message:message preferredStyle:style];
    
    if(cancelButtonTitle != nil) {
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle:cancelButtonTitle
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           tapBlock(alertController, 0); // CANCEL BUTTON CALL BACK ACTION
                                       }];
        [alertController addAction:cancelButton];
    }
    for(int k=0;k<otherButtonTitles.count;k++){
      //  if(otherButtonTitle != nil) {
            
            UIAlertAction *otherButton = [UIAlertAction
                                          actionWithTitle:[otherButtonTitles objectAtIndex:k]
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action)
                                          {
                                              tapBlock(alertController, k+1); // OTHER BUTTON CALL BACK ACTION
                                          }];
            
            [alertController addAction:otherButton];
        //}
    }
    
    [controller presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

@end
