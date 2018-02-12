//
//  UITextField+TextField.m
//  Azwaz
//
//  Created by Nahim Makhani on 17/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "UITextField+TextField.h"

@implementation UITextField (TextField)
- (BOOL)validateEmailWithString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(void) setLeftPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
- (BOOL) phoneNumberFormatStringFromRange : (NSRange) range AndStringIs : (NSString *) string{
    if (range.location == 12 || (self.text.length >= 12 && range.length == 0) || string.length + self.text.length > 12 ) {
        return NO;
    }
    if (range.length == 0 &&
        ![[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[string characterAtIndex:0]]) {
        return NO;
    }
    UITextRange* selRange = self.selectedTextRange;
    UITextPosition *currentPosition = selRange.start;
    NSInteger pos = [self offsetFromPosition:self.beginningOfDocument toPosition:currentPosition];
    if (range.length != 0) { //deleting
        if (range.location == 3 || range.location == 7) { //deleting a dash
            if (range.length == 1) {
                range.location--;
                pos-=2;
            }else{
                pos++;
            }
        }
        else{
            if (range.length > 1){
                NSString* selectedRange = [self.text substringWithRange:range];
                NSString* hyphenless = [selectedRange stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSInteger diff = selectedRange.length - hyphenless.length;
                pos += diff;
            }
            pos --;
        }
    }
    NSMutableString* changedString = [NSMutableString stringWithString:[[self.text stringByReplacingCharactersInRange:range withString:string] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    if (changedString.length > 3) {
        [changedString insertString:@"-" atIndex:3];
        if (pos == 3) {
            pos++;
        }
    }
    if (changedString.length > 7) {
        [changedString insertString:@"-" atIndex:7];
        if (pos == 7) {
            pos++;
        }
    }
    pos += string.length;
    self.text = changedString;
    if (pos > changedString.length) {
        pos = changedString.length;
    }
    currentPosition = [self positionFromPosition:self.beginningOfDocument offset:pos];
    [self setSelectedTextRange:[self textRangeFromPosition:currentPosition toPosition:currentPosition]];
    return NO;
}

@end
