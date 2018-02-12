//
//  NSString+String.m
//  BlankDemo
//
//  Created by ossc on 30/11/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import "NSString+String.h"

@implementation NSString (String)

- (NSString *)safeString {
    if ([self isKindOfClass:[NSNull class]]){
        return @"";
    }
    if ([self isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@", self];
    }
    if([self isEqualToString:@"null"] || [self isEqualToString:@"<null>"] || [self isEqualToString:@"(null)"] || [self isEqual:NULL] || [self isEqualToString:@""] || [self isEqual:nil] || [self isEqual:Nil] || [self isEqualToString:@"NULL"] || self.length==0){
        return @"";
    }
    return self;
}

- (NSString *)ordinalNumber {
    
    if([self safeString].length==0){
        return @"";
    }
    NSString *lastDigit = [self substringFromIndex:([self length]-1)];
    NSString *ordinal;
    if ([self hasSuffix:@"11"] || [self hasSuffix:@"12"] || [self hasSuffix:@"13"]) {
        ordinal = @"th";
    } else if ([lastDigit isEqualToString:@"1"]) {
        ordinal = @"st";
    } else if ([lastDigit isEqualToString:@"2"]) {
        ordinal = @"nd";
    } else if ([lastDigit isEqualToString:@"3"]) {
        ordinal = @"rd";
    } else {
        ordinal = @"th";
    }
    return [NSString stringWithFormat:@"%@%@", self, ordinal];
}

- (BOOL)validEmail {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    NSString *str = [[self componentsSeparatedByString:@"@"] objectAtIndex:0];
    NSLog(@"String: %@",[str substringToIndex:1]);
    if ([[str substringToIndex:1] isEqualToString:@"."] || [[str substringToIndex:1] isEqualToString:@"_"]){
        return NO;
    }
    
    NSString *str2 = [NSString stringWithFormat:@"%c",[str characterAtIndex:str.length-1]];
    if ([str2 isEqualToString:@"."] || [str2 isEqualToString:@"_"])
    {
        return NO;
    }
    return [emailTest evaluateWithObject:self];
    
}

- (NSString *)getInitialCharactersFromString:(NSString *)str {
    NSString *strInitials = @"";
    if (self.length > 0) {
        strInitials = [[[[str componentsSeparatedByString:@","] objectAtIndex:0] substringToIndex:1] capitalizedString];
        
        if ([[str componentsSeparatedByString:@","] objectAtIndex:1].length > 0) {
            strInitials = [NSString stringWithFormat:@"%@%@",strInitials,[[[[str componentsSeparatedByString:@","] objectAtIndex:0] substringToIndex:1] capitalizedString]];
        }
    }
    return strInitials;
}

- (NSString *)initialNameFromFirstName:(NSString *)firstName MiddleName:(NSString *)middleName LastName:(NSString *)lastName {
    NSString *strInitials = @"";
    if (firstName.length > 0) {
        strInitials = [NSString stringWithFormat:@"%@%@",strInitials,[[firstName substringToIndex:1] capitalizedString]];
    }
    
    if (lastName.length > 0) {
        strInitials = [NSString stringWithFormat:@"%@%@",strInitials,[[lastName substringToIndex:1] capitalizedString]];
    }
    NSLog(@"Initial :%@",strInitials);
    return strInitials;
}


- (NSString *)removeDash {
    NSString *strTemp = [self stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return strTemp;
}

- (CGRect)boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [NSParagraphStyle.defaultParagraphStyle mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect boundingRect = [self boundingRectWithSize: size
    options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes: @{
     NSFontAttributeName : font,NSParagraphStyleAttributeName : paragraphStyle
  }  context: NULL];
    return boundingRect;
}

- (NSString *)removeSpecialCharactersFromString:(NSString *)str {
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"!$_.<>"];
    NSString *st = [[str componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    NSLog(@"st : %@",st);
    return st;
}

@end
