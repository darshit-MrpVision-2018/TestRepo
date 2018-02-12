//
//  SettingTableViewCell.m
//  Azwaz
//
//  Created by Nahim Makhani on 02/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "AWHomeViewTVCell.h"

@implementation AWHomeViewTVCell

@synthesize assetCollectionView,userProfileImageView,lblTimeStamp,lblAssetCount,lblUserInitials,lbCollectionTitle,recipientCVObj;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
