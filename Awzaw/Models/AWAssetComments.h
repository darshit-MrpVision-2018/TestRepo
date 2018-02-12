
#import <Foundation/Foundation.h>

@interface AWAssetComments : NSObject
{
}

@property (nonatomic,strong) NSString *commentUserInitials,*commentDescByOther,*commentDescBySelf,*commentBy,*commentAuthorImageURL;


- (id)initWithDict:(NSMutableDictionary*)dictT;

@end


