//
//  NotificationTableViewCell.m
//  Azwaz
//
//  Created by Nahim Makhani on 03/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "AWAddRecipientsTVCell.h"

@implementation AWAddRecipientsTVCell

@synthesize lblRecipientName,lblRecipientType,lblRecipientPhoneNumber,imgProfilePic,imgCheck,lblRecipientInitials,btnCheck;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        [self.imgCheck setImage:[UIImage imageNamed:@"checked"]];
    } else{
        [self.imgCheck setImage:[UIImage imageNamed:@"unchecked"]];
    }
    
//    [self.btnCheck setSelected:selected];
}

@end
