//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWContainerVC.h"
#import "AWCreateCollectionVC.h"
#import "AWNotificationVC.h"
#import "AWHomeVC.h"


@interface AWContainerVC ()<UITabBarDelegate>

@property (nonatomic, weak) IBOutlet UITabBar *tabBarObj;

@end

@implementation AWContainerVC

@synthesize tabbarIndex, containerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.tabbarIndex = 0;
    [self setUpTabBar];
}

#pragma mark - Custom Methods -

- (void)setUpTabBar {
    self.tabBarObj.delegate = self;
    [self displayContentController:[[self storyboard] instantiateViewControllerWithIdentifier:@"AWHomeVC"]];
    [self.tabBarObj setSelectedItem:[self.tabBarObj.items objectAtIndex:self.tabbarIndex]];
    [self.tabBarObj.items objectAtIndex:self.tabbarIndex].badgeValue = [NSString stringWithFormat:@"10"];
}

- (UIViewController *)allocateViewControllerObject:(NSString *)strId {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:strId];
    return vc;
}


#pragma mark - Public Methods -

- (void)displayContentController:(UIViewController *)content {
    [self addChildViewController:content];
    content.view.frame = self.containerView.frame;
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}


#pragma mark - Tabbar Methods -

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    if (self.tabbarIndex == item.tag) {
        return;
    }
    switch (item.tag)
    {
        case 0:
            // HomeVC
           [self displayContentController:[[super storyboard] instantiateViewControllerWithIdentifier:@"AWHomeVC"]];
            self.tabbarIndex = (int)item.tag;
            NSLog(@"Home Clicked");
            break;
        case 1:
            // CameraVC
//            [self displayContentController:[[super storyboard] instantiateViewControllerWithIdentifier:@"AWCreateCollectionVC.h"]];
            
            self.tabbarIndex = (int)item.tag;
            [self.navigationController pushViewController:[self allocateViewControllerObject:@"AWCreateCollectionVC"] animated:YES];
            NSLog(@"Plus Icon Tab Clicked");
            break;
        case 2:
            // NotificationVC
            [self displayContentController:[[super storyboard] instantiateViewControllerWithIdentifier:@"AWNotificationVC"]];
            self.tabbarIndex = (int)item.tag;
            NSLog(@"Notification Clicked");
            break;
    }
}

@end
