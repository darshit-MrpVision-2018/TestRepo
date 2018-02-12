//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWHomeVC.h"
#import "AWHomeViewTVCell.h"
#import "AWPreviewCVCell.h"
#import "AWRecipientsCVCell.h"

@interface AWHomeVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView *tblHome;
@property (nonatomic,strong) IBOutlet NSMutableArray *arrAssets,*arrRecipients;

@end

@implementation AWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.arrAssets = [[NSMutableArray alloc] initWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg",@"1.jpg", @"2.jpg", @"3.jpg", nil];
    self.tblHome.estimatedRowHeight = 10;
    self.tblHome.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate Method -

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AWHomeViewTVCell *cell = [self.tblHome dequeueReusableCellWithIdentifier:@"AWHomeViewTVCell"];
    if (cell == nil) {
        cell = [[AWHomeViewTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWHomeViewTVCell"];
    }
    cell.assetCollectionView.delegate = self;
    cell.assetCollectionView.dataSource = self;
    
    cell.recipientCVObj.delegate = self;
    cell.recipientCVObj.dataSource = self;
    
    cell.userProfileImageView.layer.masksToBounds = YES;
    cell.userProfileImageView.layer.cornerRadius = cell.userProfileImageView.bounds.size.width/2;
    
    cell.lblUserInitials.layer.masksToBounds = YES;
    cell.lblUserInitials.layer.cornerRadius = cell.lblUserInitials.bounds.size.width/2;
    
    cell.lblAssetCount.layer.masksToBounds = YES;
    cell.lblAssetCount.layer.cornerRadius = cell.lblAssetCount.bounds.size.width/2;
    
    cell.assetCollectionView.tag = 0;
    cell.recipientCVObj.tag = 1;
//    cell.assetCollectionView.accessibilityValue = (int)indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AWHomeViewTVCell *cell = (AWHomeViewTVCell *) [self tableView:self.tblHome cellForRowAtIndexPath:indexPath];
    
    if (self.arrAssets.count > 5) {
       return 2 * ((cell.assetCollectionView.bounds.size.width - 20)/5) + 20 + cell.assetCollectionView.frame.origin.y + cell.recipientCVObj.bounds.size.height;
    }
    
    return ((cell.assetCollectionView.bounds.size.width - 20)/5) + 10 + cell.assetCollectionView.frame.origin.y + cell.recipientCVObj.bounds.size.height;
    
//    return cell.assetCollectionView.frame.origin.y + cell.assetCollectionView.bounds.size.height;
}


#pragma mark - CollectionView Methods -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        // Recipient
        return 5.0f;
    }
    return self.arrAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == 1) {
        // Recipient
        AWRecipientsCVCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"AWRecipientsCVCell" forIndexPath:indexPath];
        
        cell.imgView.image = [UIImage imageNamed:[self.arrRecipients objectAtIndex:indexPath.row]];
        
        cell.imgView.layer.masksToBounds = YES;
        cell.imgView.layer.cornerRadius = cell.imgView.bounds.size.width/2;

        cell.lblInitials.layer.masksToBounds = YES;
        cell.lblInitials.layer.cornerRadius = cell.lblInitials.bounds.size.width/2;
        
        return cell;
    } else{
        AWPreviewCVCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"AWPreviewCVCell" forIndexPath:indexPath];
        
        cell.imgView.image =[UIImage imageNamed:[self.arrAssets objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (collectionView.tag == 1) {
        return CGSizeMake(40, 40);
    } else{
        return CGSizeMake((collectionView.bounds.size.width - 20)/5, (collectionView.bounds.size.width - 20)/5);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0f;
}

// Still working on creating collection module where working on maintaining the serial of selected/unselected counters.

@end
