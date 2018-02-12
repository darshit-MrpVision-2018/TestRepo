//
//
//  Created by ossc on 13/02/16.
//  Copyright © 2016 ossc. All rights reserved.
//

#import "AWGuidanceCVCell.h"

@implementation AWGuidanceCVCell

@synthesize imgView;//lblClientsName

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    if (selected){
        self.layer.borderColor = UIColor.blueColor.CGColor;
        self.layer.borderWidth = 3;
    }else {
        self.layer.borderColor = UIColor.clearColor.CGColor;
    }
}

@end
