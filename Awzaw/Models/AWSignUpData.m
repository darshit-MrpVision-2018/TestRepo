//
//  AWSignUpData.m
//  Azwaz
//
//  Created by Darshit Vora on 17/11/17.
//  Copyright © 2017 Darshit Vora. All rights reserved.
//

#import "AWSignUpData.h"

@implementation AWSignUpData

@synthesize name,email,password,phoneNumber,strProfilePic,facebookId;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.facebookId = [decoder decodeObjectForKey:@"email"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.phoneNumber = [decoder decodeObjectForKey:@"phoneNumber"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:facebookId forKey:@"facebookId"];
    [encoder encodeObject:email forKey:@"email"];
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeObject:phoneNumber forKey:@"phoneNumber"];
}



@end
