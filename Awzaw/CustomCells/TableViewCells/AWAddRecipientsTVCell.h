//
//  NotificationTableViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 03/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWAddRecipientsTVCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIImageView *imgProfilePic,*imgCheck;
@property(strong,nonatomic) IBOutlet UILabel *lblRecipientName;
@property(strong,nonatomic) IBOutlet UILabel *lblRecipientPhoneNumber;
@property(strong,nonatomic) IBOutlet UILabel *lblRecipientType;
@property(strong,nonatomic) IBOutlet UILabel *lblRecipientInitials;
@property(strong,nonatomic) IBOutlet UIButton *btnCheck;
@property(nonatomic) BOOL isChecked;

@end
