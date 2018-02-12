//
//  SettingTableViewCell.m
//  Azwaz
//
//  Created by Nahim Makhani on 02/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "AWCollectionDetailOtherCommentCell.h"

@implementation AWCollectionDetailOtherCommentCell

@synthesize imgUserProfilePic,lblComment,lblInitials,lblDate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lblComment setNeedsLayout];
    [self.lblComment layoutIfNeeded];
}

- (CGSize)intrinsicContentSize {
    CGSize intrinsicSuperViewContentSize = [super intrinsicContentSize] ;
    intrinsicSuperViewContentSize.width += 5.0 * 2 ;// padding * 2
    return intrinsicSuperViewContentSize ;
}


@end
