//
//  NotificationTableViewCell.m
//  Azwaz
//
//  Created by Nahim Makhani on 03/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "AWNotificationViewCell.h"

@implementation AWNotificationViewCell

@synthesize lblDate,lblDesc,imgNotification,userImageView,userInitials;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
