//
//  SettingTableViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 02/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AWHomeViewTVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UICollectionView *assetCollectionView;
@property (nonatomic,strong) IBOutlet UICollectionView *recipientCVObj;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (strong, nonatomic) IBOutlet UILabel *lblUserInitials;
@property (strong, nonatomic) IBOutlet UILabel *lblAssetCount;
@property (strong, nonatomic) IBOutlet UILabel *lbCollectionTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeStamp;
@end

