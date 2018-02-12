
#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>

@interface AWContact : NSObject
{
}

@property (nonatomic,strong) NSString *contactFirstname,*contactLastname,*contactFullname,*contactNumber,*contactCategory,*contactInitials;
@property (nonatomic,strong) NSData *contactProfilePicData;
@property (nonatomic) BOOL isContactSelected;

- (id)initWithContact:(CNContact*)contact;

@end


