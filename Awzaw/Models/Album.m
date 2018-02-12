#import "Album.h"
#import <Photos/Photos.h>

@implementation Album

@synthesize albumName,albumURL;

-(id)initWithDict:(NSMutableDictionary*) dictT Filename:(NSString *)fileName{
    self = [super init];
    if(self)
    {
        self.albumURL = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"PHImageFileURLKey"]];
        self.albumName = fileName;
//        self.Id=[NSString stringWithFormat:@"%@",[dictT objectForKey:@"main_service_id"]];
    }
    return self;
}


@end
