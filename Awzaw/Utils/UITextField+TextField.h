//
//  UITextField+TextField.h
//  Azwaz
//
//  Created by Nahim Makhani on 17/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (TextField)
- (BOOL)validateEmailWithString;
-(void) setLeftPadding:(int) paddingValue;
- (BOOL) phoneNumberFormatStringFromRange : (NSRange) range AndStringIs : (NSString *) string;
@end
