
#import <Foundation/Foundation.h>

@interface AWCollectionData : NSObject
{
}

@property (nonatomic,strong) NSString *collectionTitle,*collectionId,*collectionCaption,*collectionAuthorId,*collectionAuthorName,*collectionAuthorInitials;
@property (nonatomic,strong) NSMutableArray *collectionArrAssets,*collectionArrRecipients;

- (id)initWithDict:(NSMutableDictionary*)dictT;

@end


