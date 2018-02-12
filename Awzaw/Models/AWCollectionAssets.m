 #import "AWCollectionAssets.h"
#import "AWAssetComments.h"

@implementation AWCollectionAssets

@synthesize assetId,assetImageURL,assetArrComments;

- (id)initWithDict:(NSMutableDictionary*)dictT {
    self = [super init];
    if(self)
    {
        if ([dictT objectForKey:@"assetId"])
            self.assetId = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"assetId"]];
        
        if([dictT objectForKey:@"assetImageURL"])
            self.assetImageURL = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"assetImageURL"]];
        
        for (int i=0; [[dictT objectForKey:@"assetComments"] count] > 0; i++) {
            AWAssetComments *comment = [[AWAssetComments alloc] initWithDict:[[dictT objectForKey:@"assetComments"] objectAtIndex:i]];
            [self.assetArrComments addObject:comment];
        }
    }
    return self;
}



@end
