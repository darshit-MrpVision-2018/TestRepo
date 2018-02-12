 #import "AWContact.h"

@implementation AWContact

@synthesize contactFirstname,contactLastname,contactFullname,contactCategory,contactNumber,contactInitials,contactProfilePicData,isContactSelected;

- (id)initWithContact:(CNContact*)contact {
    self = [super init];
    if(self)
    {
        if(contact.givenName)
            self.contactFirstname = [NSString stringWithFormat:@"%@",contact.givenName];
        
        if(contact.familyName)
            self.contactLastname = [NSString stringWithFormat:@"%@",contact.familyName];
        
        self.contactFullname = [NSString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
        if( contact.phoneNumbers){
            self.contactNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
            self.contactCategory = [[contact.phoneNumbers firstObject] label];
            self.contactCategory = [self.contactCategory removeSpecialCharactersFromString:[[contact.phoneNumbers firstObject] label]];
        }
        if (contact.imageData)
            self.contactProfilePicData = contact.imageData;
        NSString *str = @"";
        self.contactInitials = [str initialNameFromFirstName:contact.givenName MiddleName:nil LastName:contact.familyName];
    }
    return self;
}



@end
