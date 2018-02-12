//
//  SettingTableViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 02/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWLabel.h"

@interface AWCollectionDetailOtherCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgUserProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *lblInitials,*lblDate;
@property (strong, nonatomic) IBOutlet AWLabel *lblComment;

- (void)layoutSubviews;
- (CGSize)intrinsicContentSize;
@end
