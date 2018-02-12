//
//  CountCollectionViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 27/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
@interface CountCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) IBOutlet UIView *vwCount;
@property(strong,nonatomic) IBOutlet UILabel *lblCounts;

@end
