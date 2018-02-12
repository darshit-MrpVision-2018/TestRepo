//
//  MRPSpinner.m
//  Awzaw
//
//  Created by Darshit Vora on 13/11/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "MRPSpinner.h"

@implementation MRPSpinner

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (MRPSpinner *)setOnView:(UIView *)view withTitle:(NSString *)title animated:(BOOL)animated
{
    UIView *vw=[[UIView alloc]initWithFrame:APP_DEL.window.frame];
    vw.backgroundColor=[UIColor clearColor];
    vw.tag=1;
    
    MRPSpinner *spinner = [[MRPSpinner alloc] initWithFrame:CGRectMake(vw.frame.size.width/2 - 90, vw.frame.size.height/2 - 62, 180.0, 100.0)];
    spinner.tag = 2;
    spinner.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
    spinner.layer.masksToBounds = YES;
    spinner.layer.cornerRadius = 8.0;
    
    DGActivityIndicatorView *indicator = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader];
    [indicator setType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader];
    indicator.layer.frame = CGRectMake(spinner.bounds.size.width/2 - 20, 20, 40, 40);
    [indicator setTintColor:[UIColor blackColor]];
//    [indicator setBackgroundColor:[UIColor redColor]];
    indicator.tag = 3;
    [indicator setSize:40.0];
    [indicator startAnimating];
    [spinner addSubview:indicator];
    
    UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake(0, indicator.frame.origin.y + indicator.bounds.size.height + 10 , spinner.bounds.size.width, 25)];
//    lblText.backgroundColor = [UIColor yellowColor];
    lblText.tag = 4;
    lblText.text = title;
    lblText.textAlignment = NSTextAlignmentCenter;
    [spinner addSubview:lblText];
    
    [vw addSubview:spinner];
    [view addSubview:vw];
    
    float height = [[UIScreen mainScreen] bounds].size.height;
    float width = [[UIScreen mainScreen] bounds].size.width;
    CGPoint center = CGPointMake(width/2, height/2);
    spinner.center = center;
    
    return spinner;
}

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated {
    MRPSpinner *spinner = (MRPSpinner *)[view viewWithTag:1];
    if (spinner) {
        [spinner removeFromSuperview];
        return YES;
    }
    return NO;
}

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        //[self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
}




@end
