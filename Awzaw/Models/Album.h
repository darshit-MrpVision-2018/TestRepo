
#import <Foundation/Foundation.h>

@interface Album : NSObject
{
}

@property (nonatomic,strong) NSString *albumName,*albumURL;

-(id)initWithDict:(NSMutableDictionary*) dictT Filename:(NSString *)fileName;

@end


