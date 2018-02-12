//
//  NSString+String.h
//  BlankDemo
//
//  Created by ossc on 30/11/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (String)
- (NSString *)safeString;
- (NSString *)ordinalNumber;
- (BOOL)validEmail;
- (NSString *)removeDash;
- (CGRect)boundingRectWithSize:(CGSize)size font:(UIFont *)font;
- (NSString *)getInitialCharactersFromString:(NSString *)str;
- (NSString *)initialNameFromFirstName:(NSString *)firstName MiddleName:(NSString *)middleName LastName:(NSString *)lastName;
- (NSString *)removeSpecialCharactersFromString:(NSString *)st;

@end
