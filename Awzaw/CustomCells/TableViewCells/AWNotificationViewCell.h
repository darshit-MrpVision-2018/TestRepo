//
//  NotificationTableViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 03/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWNotificationViewCell : UITableViewCell

@property(strong,nonatomic) IBOutlet UIImageView *imgNotification;
@property(strong,nonatomic) IBOutlet UILabel *lblDesc;
@property(strong,nonatomic) IBOutlet UILabel *lblDate;
@property(strong,nonatomic) IBOutlet UIImageView *userImageView;
@property(strong,nonatomic) IBOutlet UILabel *userInitials;


@end
