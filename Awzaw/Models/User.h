
#import <Foundation/Foundation.h>
#import "AWSignUpData.h"

@interface User : NSObject
{
}
@property (nonatomic,strong) NSString *userId,*accessToken,*deviceToken;
@property (nonatomic,strong) NSString *email,*name,*phoneNumber,*facebookId;
@property (nonatomic,strong) NSString *strProfilePic;
@property BOOL isFacebook;
@property int registrationStepScreen;
@property int registerType;
@property (nonatomic,strong) AWSignUpData *signUpData;



//Facebook Profile Photo and Cover Photo

- (void) saveUserWhenSignUpWithDictionary:(NSDictionary *)dictRepose;
- (void) saveUserWhenLoginWithDictionary : (NSDictionary *) dict;
- (void) saveUser;
+ (User *) getUser;
@end


