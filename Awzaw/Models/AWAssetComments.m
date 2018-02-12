 #import "AWAssetComments.h"

@implementation AWAssetComments

@synthesize commentBy,commentDescByOther,commentUserInitials,commentAuthorImageURL,commentDescBySelf;

- (id)initWithDict:(NSMutableDictionary*)dictT {
    self = [super init];
    if(self)
    {
        if ([[dictT objectForKey:@"comment_user_imageURL"] length] > 0){
            self.commentAuthorImageURL = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"comment_user_imageURL"]];
        } else{
            self.commentUserInitials = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"comment_user_initials"]];
        }
        
        if([[dictT objectForKey:@"comment_desc"] length] > 0)
            self.commentDescByOther = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"comment_desc"]];
        
        if([[dictT objectForKey:@"comment_by"] isEqualToString:@"other"]){
            self.commentDescByOther = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"comment_by"]];
        } else{
            self.commentDescBySelf = [NSString stringWithFormat:@"%@",[dictT objectForKey:@"comment_by"]];
        }
    }
    return self;
}



@end
