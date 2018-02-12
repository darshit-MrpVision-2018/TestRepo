#import "User.h"

@implementation User
@synthesize email,name,phoneNumber,userId,registrationStepScreen,registerType,isFacebook,facebookId,deviceToken,accessToken;
@synthesize strProfilePic,signUpData;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        self.email = [decoder decodeObjectForKey:@"email"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phoneNumber = [decoder decodeObjectForKey:@"phoneNumber"];
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.registerType = [[decoder decodeObjectForKey:@"registerType"]intValue];
        self.isFacebook = [[decoder decodeObjectForKey:@"isFacebook"]boolValue];
        self.facebookId = [decoder decodeObjectForKey:@"facebookId"];
        self.signUpData = [decoder decodeObjectForKey:@"signUpData"];
        self.deviceToken = [decoder decodeObjectForKey:@"deviceToken"];
        self.strProfilePic = [decoder decodeObjectForKey:@"strProfilePic"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:phoneNumber forKey:@"phoneNumber"];
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:userId forKey:@"userId"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",registrationStepScreen] forKey:@"registrationStepScreen"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",registerType] forKey:@"registerType"];
    [encoder encodeObject:[NSString stringWithFormat:@"%d",isFacebook] forKey:@"isFacebook"];
    [encoder encodeObject:signUpData forKey:@"signUpData"];
    [encoder encodeObject:facebookId forKey:@"facebookId"];
    [encoder encodeObject:deviceToken forKey:@"deviceToken"];
    [encoder encodeObject:strProfilePic forKey:@"strProfilePic"];
    
}

- (void) saveUserWhenSignUpWithDictionary:(NSDictionary *)dictRepose {
    
    AWSignUpData *objAWSignUpData = [[AWSignUpData alloc] init];
    objAWSignUpData.facebookId = [dictRepose objectForKey:@"id"];
    objAWSignUpData.name = [dictRepose objectForKey:@"name"];
    objAWSignUpData.email = [dictRepose objectForKey:@"email"];
    self.strProfilePic = [NSString stringWithFormat:@"%@",[dictRepose valueForKeyPath:@"picture.data.url"]];
    self.signUpData = objAWSignUpData;
    self.deviceToken = [[dictRepose objectForKey:@"devicetoken"] safeString];
    [self saveUser];

    
/*    Registration *objRegisterd = [[Registration alloc] init];
    objRegisterd.facebookId = [dictRepose objectForKey:@"id"];
    objRegisterd.name = [dictRepose objectForKey:@"name"];
    objRegisterd.email = [dictRepose objectForKey:@"email"];
    
    self.coverPhoto = [NSString stringWithFormat:@"%@",[[dictRepose objectForKey:@"cover"] objectForKey:@"source"]];
    self.profilePhoto = [NSString stringWithFormat:@"%@",[[[dictRepose objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
    self.objRegister = objRegisterd;
    self.deviceToken = [[dictRepose objectForKey:@"devicetoken"] safeString];
    [self saveUser];
 */
}


- (void) saveUserWhenLoginWithDictionary : (NSDictionary *) dictRepose{
    self.registrationStepScreen = -1;
    self.userId = [NSString stringWithFormat:@"%@",[dictRepose objectForKey:@"id"]];
    self.phoneNumber=[[dictRepose objectForKey:@"phone"] safeString];
    self.name=[[NSString stringWithFormat:@"%@",[dictRepose objectForKey:@"name"]] safeString];
    self.email=[[NSString stringWithFormat:@"%@",[dictRepose objectForKey:@"email"]] safeString];
    self.strProfilePic=[[NSString stringWithFormat:@"%@",[dictRepose objectForKey:@"profile_photo"]] safeString];
    self.deviceToken=[[NSString stringWithFormat:@"%@",[dictRepose objectForKey:@"devicetoken"]] safeString];
    [self saveUser];
}

- (void) saveUser{
    NSLog(@"save User Id :%@",self.userId);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (User *) getUser{
    User *objUser;
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    objUser =[NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSLog(@"got User id : %@",objUser.userId);
    if(!objUser){
        objUser = [[User alloc]init];
    }
    return objUser;
}

@end
