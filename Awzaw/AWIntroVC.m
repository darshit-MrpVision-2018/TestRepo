//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWIntroVC.h"
#import "AWPhoneVerificationVC.h"
#import "AWCreateCollectionVC.h"
#import "AWHomeVC.h"
#import "AWSignUpVC.h"

@interface AWIntroVC ()

@property(strong,nonatomic) IBOutlet UIButton *continueWithPhoneNumberBtn;
@property(strong,nonatomic) IBOutlet UIButton *continueWithFacebookBtn;
@property(strong,nonatomic) IBOutlet UIButton *recoverPasswordBtn;

@end

@implementation AWIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpButtons];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

- (void)setUpButtons {
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"recover password?" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    [self.recoverPasswordBtn setAttributedTitle:titleString forState:UIControlStateNormal];
}

#pragma mark - Facebook Login Method -
- (void) fbLoginServiceWithUserDict : (NSDictionary *) dict {
/*
    NSString *profilePicURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[dict objectForKey:@"id"]];
    NSString *jsonStr = [NSString stringWithFormat:@"wsmethod=facebooklogin&user_email=%@&user_fname=%@&user_lname=%@&user_photo=%@&fb_id=%@&device_token=%@",[dict objectForKey:@"email"],[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"],profilePicURL,[dict objectForKey:@"id"],[self getDeviceToken]];
    [WSManager POST:HostName withParamters:jsonStr success:^(id results, NSURLSessionDataTask *operation) {
        NSArray *resultArray = (NSArray *) results;
        if(resultArray.count>0){
            NSMutableDictionary *dictResponse =[results objectAtIndex:0];
            if ([[dictResponse objectForKey:@"status"]intValue]==200) {
                User *user = [User getUser];
                [user saveUserWhenLoginInWithDictionary:dictResponse];
                user = [User getUser];
                if (user.isFirstTimeLogin){
                    WelcomeVc *welcm =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVc"];
                    [self.navigationController pushViewController:welcm animated:YES];
                }else{
                    MenuViewController  *menuVC =[self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
                    [self.navigationController pushViewController:menuVC animated:false];
                    HomeViewController  *home =[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                    [self.navigationController pushViewController:home animated:YES];
                }
                
            }else if([[dictResponse objectForKey:@"status"]intValue]==400){
                [UIAlertController showAlertIn:self WithTitle:@"" message:[dictResponse objectForKey:@"status_msg"] cancelButtonTitle:@"Ok" otherButtonTitles:nil style:UIAlertControllerStyleAlert tapBlock:^(UIAlertController *alertViewController, NSInteger buttonIndex) {
                    
                }];
            }
            
        }
        [self dismissGlobalHUD];
    } failure:^(NSError *error, NSURLSessionDataTask *operation) {
        [self dismissGlobalHUD];
    }];
*/ 
}

-(void)fbDidSuccess :(NSMutableDictionary *)dictFB {
    [self performSelector:@selector(fbLoginServiceWithUserDict:) withObject:dictFB afterDelay:0.2];
}

- (void)userFacebookDetails:(NSDictionary *)details {
    NSLog(@"details : %@",details);
    
}

#pragma mark - Custom Actions -

- (IBAction)btnWithNumberClick:(id)sender {

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer
                                  serializerWithReadingOptions:NSJSONReadingAllowFragments];

    NSMutableArray *arrimages = [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil];
    
//    NSMutableArray *arrimages = [[NSMutableArray alloc] initWithObjects:@"https://tinyurl.com/y838v3jv",@"https://tinyurl.com/y96qhz2p",@"https://tinyurl.com/ycsa4fcm", nil];
    
    NSMutableDictionary *dict=[NSMutableDictionary new];
//    [dict setObject:@"Darshit" forKey:@"name"];
//    [dict setObject:@"darshit@mrpvision.com" forKey:@"email"];
//    [dict setObject:@"9427170506" forKey:@"phone"];
//    [dict setObject:@"123456" forKey:@"password"];

    
    [dict setObject:arrimages forKey:@"image"];
//    [dict setObject:@"Darshit Images" forKey:@"title"];

    
    
//    [manager POST:CreateCollectionServiceURL parameters:dict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//                NSLog(@"JSON: %@", responseObject);
//            } failure:^(NSURLSessionTask *operation, NSError *error) {
//                NSLog(@"Error: %@", error);
//            }];
    
    [manager POST:CreateCollectionServiceURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageNamed:[arrimages objectAtIndex:0]], 0.8) name:@"image" fileName:[arrimages objectAtIndex:0] mimeType:@"image/jpeg"];
        NSLog(@"formData : %@",formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];


//    NSMutableArray *arrimages = [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg", nil];
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:CreateCollectionServiceURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData:UIImageJPEGRepresentation([UIImage imageNamed:@"1.jpg"], 0.8) name:@"image"];
//        
//    } error:nil];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSURLSessionUploadTask *uploadTask;
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:^(NSProgress * _Nonnull uploadProgress) {
//                      // This is not called back on the main queue.
//                      // You are responsible for dispatching to the main queue for UI updates
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          //Update the progress view
//                         // [progressView setProgress:uploadProgress.fractionCompleted];
//                      });
//                  }
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      if (error) {
//                          NSLog(@"Error: %@", error);
//                      } else {
//                          NSLog(@"%@ %@", response, responseObject);
//                      }
//                  }];
//    
//    [uploadTask resume];
    
    
    AWSignUpVC *Phonevc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWSignUpVC"];
    [self.navigationController pushViewController:Phonevc animated:YES];
}

- (IBAction)btnWithFacebookClick:(id)sender {
    
//    AWHomeVC *Phonevc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWHomeVC"];
//    [self.navigationController pushViewController:Phonevc animated:YES];
    
    if(![self checkInternetConnection]){
        [self showNotificationForInternet];
        return;
    }
    
    [self fbLogin];
}

@end
