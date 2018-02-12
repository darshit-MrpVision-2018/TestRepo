 #import "AWCollectionData.h"

@implementation AWCollectionData

@synthesize collectionId,collectionTitle,collectionCaption,collectionAuthorId,collectionArrAssets,collectionAuthorName,collectionArrRecipients,collectionAuthorInitials;

- (id)initWithDict:(NSMutableDictionary*)dictT {
    self = [super init];
    if(self)
    {
        if ([dictT objectForKey:@"collectionId"])
            self.collectionId = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"collectionId"]];
        
        if([dictT objectForKey:@"collectionTitle"])
            self.collectionTitle = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"collectionTitle"]];
        
        if([dictT objectForKey:@"collectionCaption"])
            self.collectionCaption = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"collectionCaption"]];
        
        if([dictT objectForKey:@"collectionAuthorId"])
            self.collectionAuthorId = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"collectionAuthorId"]];
        
        if([dictT objectForKey:@"collectionAuthorName"]){
            
            self.collectionAuthorName = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"collectionAuthorId"]];
            self.collectionAuthorInitials = [self.collectionAuthorInitials getInitialCharactersFromString:[dictT objectForKey:@"collectionAuthorInitials"]];
        }
        
        if ([[dictT objectForKey:@"collectionAssets"] count] > 0) {
            self.collectionArrAssets = [dictT objectForKey:@"collectionAssets"];
        }
        
        if ([[dictT objectForKey:@"collectionArrRecipients"] count] > 0) {
            self.collectionArrRecipients = [dictT objectForKey:@"collectionArrRecipients"];
        }
    }
    return self;
}



@end
