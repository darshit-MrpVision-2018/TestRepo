//
//  VistitedCollectionViewCell.h
//  Azwaz
//
//  Created by Nahim Makhani on 20/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
@interface VistitedCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) IBOutlet KNCirclePercentView *vwVisited;
@property(strong,nonatomic) IBOutlet UILabel *lblUserName;
@end
