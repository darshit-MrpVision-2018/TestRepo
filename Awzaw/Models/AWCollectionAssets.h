
#import <Foundation/Foundation.h>

@interface AWCollectionAssets : NSObject
{
}

@property (nonatomic,strong) NSString *assetId,*assetImageURL;
@property (nonatomic,strong) NSMutableArray *assetArrComments;

- (id)initWithDict:(NSMutableDictionary*)dictT;

@end


