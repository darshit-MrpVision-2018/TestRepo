//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWNotificationVC.h"
#import "AWNotificationViewCell.h"
#import "AWCreateCollectionVC.h"


@interface AWNotificationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *arrNotification;
@property (nonatomic, strong) IBOutlet UITableView *tblNotification;

@end

@implementation AWNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom Methods -

- (void)loadData {
    self.arrNotification = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"We're in Everything looks in the", @"desc", @"10/11/17 10:01 AM", @"date", nil];
    
    for (int i=0; i<5; i++) {
        [self.arrNotification addObject:dict];
    }
}

#pragma mark - Custom Actions -

- (IBAction)btnSettingClick:(id)sender {
    
//    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnCameraClick:(id)sender {
    AWCreateCollectionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWCreateCollectionVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TableView Methods -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrNotification.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AWNotificationViewCell *cell =[self.tblNotification dequeueReusableCellWithIdentifier:@"AWNotificationViewCell"];
    if (cell == nil) {
        cell =[[AWNotificationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWNotificationViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userImageView.layer.masksToBounds = YES;
    cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width/2;
    
    cell.userInitials.layer.masksToBounds = YES;
    cell.userInitials.layer.cornerRadius = cell.userInitials.frame.size.width/2;
    
    [cell.lblDesc setText:[[self.arrNotification objectAtIndex:indexPath.row] valueForKey:@"desc"]];
    [cell.lblDate setText:[[self.arrNotification objectAtIndex:indexPath.row] valueForKey:@"date"]];
    
//    if(cell.userDetailView.image == nil){
//        NSString *strName =[self.arrNotificationsName objectAtIndex:indexPath.row];
//        NSArray *arr = [strName componentsSeparatedByString:@" "];
//        NSString *str = @"";
//        if(arr.count<=0){
//            str =@"";
//        }else if(arr.count<=1){
//            NSString *strele =[arr objectAtIndex:0];
//            if (strele.length>0) {
//                str = [[arr objectAtIndex:0]substringToIndex:1];
//            }
//        }else {
//            NSString *strele1 =[arr objectAtIndex:0];
//            NSString *strele2 =[arr objectAtIndex:1];
//            
//            if (strele1.length != 0) {
//                str = [NSString stringWithFormat:@"%@",[strele1 substringToIndex:1]];
//            }
//            if(strele2.length != 0){
//                if (str.length == 0) {
//                    str = [NSString stringWithFormat:@"%@",[strele2 substringToIndex:1]];
//                }else{
//                    str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",[strele2 substringToIndex:1] ]];
//                }
//            }
//        }
//        cell.lblName.text =str;
//        NSLog(@"%@",cell.lblName.text);
//    }else{
//        
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
