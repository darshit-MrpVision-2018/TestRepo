//
//  CollectionDetailViewController.m
//  Azwaz
//
//  Created by Nahim Makhani on 06/11/17.
//  Copyright © 2017 Nahim Makhani. All rights reserved.
//

#import "CollectionDetailVC.h"
#import "CollectionDetailTableViewCell.h"
#import "CollectionDetailCollectionViewCell.h"
#import "CollectionDetailEvenTableViewCell.h"
#import "VistitedCollectionViewCell.h"
#import "CountCollectionViewCell.h"
#import "KNCirclePercentView.h"

@interface CollectionDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic) IBOutlet UITableView *tblCollectionDetail;
@property(strong,nonatomic) NSMutableArray *arrCollectionDetail;
@property(strong,nonatomic) UICollectionView *collectionViewDetail;
@property(strong,nonatomic) UICollectionView *collectionViewVisited;
@property(strong,nonatomic) UITextField *txtNotes;
@property(strong,nonatomic) NSMutableArray *arrVisited;

@end

@implementation CollectionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrVisited =[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    self.arrCollectionDetail =[[NSMutableArray alloc]initWithObjects:@"1.jpeg",@"2.jpeg",@"3.jpg",@"4.jpeg",@"5.jpeg",@"1.jpeg",@"2.jpeg",@"3.jpg",@"4.jpeg",@"5.jpeg", nil];
    [self performSelector:@selector(collectionDetailTableviewHeader) withObject:self afterDelay:0.2];
    [self performSelector:@selector(collectionDetailTableviewFooter) withObject:self afterDelay:0.2];
    self.tblCollectionDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self automaticallyAdjustsScrollViewInsets];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.collectionViewDetail reloadData];
}

#pragma mark - Tableview Delegate Method -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrCollectionDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
    CollectionDetailTableViewCell *cell =[self.tblCollectionDetail dequeueReusableCellWithIdentifier:@"CollectionDetailTableViewCell"];
    if (cell == nil) {
        cell =[[CollectionDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionDetailTableViewCell"];
    }
      cell.imagevieProfile.clipsToBounds = YES;
      cell.imagevieProfile.layer.cornerRadius = cell.imagevieProfile.layer.frame.size.width/2;
      cell.imageviewPlaceholder.layer.cornerRadius = 5.0f;
      cell.lblData.layer.cornerRadius = 5.0f;
      cell.selectionStyle =UITableViewCellSelectionStyleNone;
     return cell;
    }else{
      CollectionDetailEvenTableViewCell *cell =[self.tblCollectionDetail dequeueReusableCellWithIdentifier:@"CollectionDetailEvenTableViewCell"];
        if (cell == nil) {
            cell =[[CollectionDetailEvenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionDetailEvenTableViewCell"];
        }
        cell.profileImage.clipsToBounds = YES;
        cell.profileImage.layer.cornerRadius = cell.profileImage.layer.frame.size.width/2;
        cell.placeholderImg.layer.cornerRadius = 5.0f;
        cell.lblData.layer.cornerRadius = 5.0f;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MyContactsViewController *contact =[self.storyboard instantiateViewControllerWithIdentifier:@"MyContactsViewController"];
//    [self.navigationController pushViewController:contact animated:YES];
}


#pragma mark - Tableview header/Footer Method -

- (void)collectionDetailTableviewHeader {
    UIView *vwHeader =[[[NSBundle mainBundle]loadNibNamed:@"CollectionDetailHeader" owner:self options:nil]objectAtIndex:0];
    UICollectionView *collectionForProfile =(UICollectionView *)[vwHeader viewWithTag:ACollectionDetail];
    self.collectionViewDetail = (UICollectionView *)collectionForProfile;
    self.collectionViewDetail.dataSource = self;
    self.collectionViewDetail.delegate = self;
    self.collectionViewDetail.pagingEnabled = YES;
    [self.collectionViewDetail registerNib:[UINib nibWithNibName:@"CollectionDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionDetailCollectionViewCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionViewDetail setCollectionViewLayout:flowLayout];
    self.collectionViewDetail.backgroundColor = [UIColor clearColor];
    UIButton *btnRight =(UIButton *)[vwHeader viewWithTag:2];
    [btnRight addTarget:self action:@selector(btnRight:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btnLeft =(UIButton *)[vwHeader viewWithTag:3];
    [btnLeft addTarget:self action:@selector(btnLeft:) forControlEvents:UIControlEventTouchUpInside];
    /// ------------ Visited CollectionView ----------------//
     self.collectionViewVisited = (UICollectionView *)[vwHeader viewWithTag:ACollectionVisited];

    NSLog(@"%@",NSStringFromCGRect(self.collectionViewVisited.frame));
    self.collectionViewVisited.dataSource = self;
    self.collectionViewVisited.delegate = self;
    [self.collectionViewVisited registerNib:[UINib nibWithNibName:@"VistitedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VistitedCollectionViewCell"];
    [self.collectionViewVisited registerNib:[UINib nibWithNibName:@"CountCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CountCollectionViewCell"];
    self.tblCollectionDetail.tableHeaderView = vwHeader;
}

- (void)collectionDetailTableviewFooter {
    UIView *vwHeader =[[[NSBundle mainBundle]loadNibNamed:@"CollectionDetailFooter" owner:self options:nil]objectAtIndex:0];
    UITextField *text =(UITextField *)[vwHeader viewWithTag:1];
    text.delegate = self;
    self.txtNotes = (UITextField *)text;
    UIButton *btnSend = (UIButton *)[vwHeader viewWithTag:2];
    [btnSend addTarget:self action:@selector(btnSend:) forControlEvents:UIControlEventTouchUpInside];
     self.tblCollectionDetail.tableFooterView = vwHeader;
}

- (void)btnSend:(UIButton *)sender {
    
}

#pragma mark - CollectionView Delegate Method - 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(collectionView.tag == ACollectionVisited){
        return 2;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     if (collectionView.tag == ACollectionDetail) {
        return 10;
    }
    else if(collectionView.tag == ACollectionVisited){
        if(section == 0){
        return 5;
        }else if(section == 1){
            return 1;
        }else{
            return 0;
        }
    }else{
        
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == ACollectionDetail) {
        CollectionDetailCollectionViewCell *cell =[self.collectionViewDetail dequeueReusableCellWithReuseIdentifier:@"CollectionDetailCollectionViewCell" forIndexPath:indexPath];
        cell.imgData.image =[UIImage imageNamed:[self.arrCollectionDetail objectAtIndex:indexPath.row]];
        NSLog(@"%@",NSStringFromCGRect(cell.frame));
        NSLog(@"%@",NSStringFromCGRect(cell.imgData.frame));
        return cell;
    }else if (collectionView.tag == ACollectionVisited){
        if (indexPath.section == 0) {
            VistitedCollectionViewCell *cell =[self.collectionViewVisited dequeueReusableCellWithReuseIdentifier:@"VistitedCollectionViewCell" forIndexPath:indexPath];
            [cell.vwVisited bringSubviewToFront:cell.lblUserName];
            NSLog(@"%@",NSStringFromCGRect(cell.frame));
            if (indexPath.row == 0) {
                [cell.vwVisited drawCircleWithPercent:50 duration:0 lineWidth:1 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor whiteColor] strokeColor:[UIColor greenColor] animatedColors:nil];
                cell.lblUserName.textColor = [UIColor greenColor];
            }else if(indexPath.row == 1){
                [cell.vwVisited drawPieChartWithPercent:100 duration:0 clockwise:YES fillColor:[UIColor clearColor] strokeColor:[UIColor greenColor] animatedColors:nil];
                cell.lblUserName.textColor = [UIColor whiteColor];
            }else{
                [cell.vwVisited drawCircleWithPercent:100 duration:0 lineWidth:1 clockwise:YES lineCap:kCALineCapRound fillColor:[UIColor whiteColor] strokeColor:[UIColor lightGrayColor] animatedColors:nil];
                cell.lblUserName.textColor = [UIColor lightGrayColor];
            }
            return cell;
        }
        else if(indexPath.section == 1){
             if (self.arrVisited.count>5 ) {
            CountCollectionViewCell *cell =[self.collectionViewVisited dequeueReusableCellWithReuseIdentifier:@"CountCollectionViewCell" forIndexPath:indexPath];
                 cell.vwCount.layer.masksToBounds = true;
                 cell.vwCount.layer.borderColor = [[UIColor greenColor]CGColor];
                 cell.vwCount.layer.borderWidth = 1.0f;
                 cell.vwCount.layer.cornerRadius = cell.vwCount.frame.size.width/2;
                 cell.lblCounts.text =@"+5";
                 cell.lblCounts.textColor = [UIColor blackColor];
                 UITapGestureRecognizer *tapBtn =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtn:)];
                 [cell.vwCount addGestureRecognizer:tapBtn];
            return cell;
        }
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.tag == ACollectionDetail) {
         return CGSizeMake(240, 140);
    }else if (collectionView.tag == ACollectionVisited ){
        return CGSizeMake(30, 30);
    }else{
        return CGSizeMake(0, 0);
    }
}


#pragma mark - Custom Method - 
-(void)tapBtn:(UITapGestureRecognizer *)tap {
    
}

-(void)btnRight:(UIButton *)sender{
    if ( self.arrCollectionDetail != nil) {
        if ( self.arrCollectionDetail.count != 0) {
            [self scrollToPreviousOrNextCell:@"Previous"];
        }
    }
}

-(void)btnLeft:(UIButton *)sender{
    if ( self.arrCollectionDetail != nil) {
        if (self.arrCollectionDetail.count != 0) {
            [self scrollToPreviousOrNextCell:@"Next"];
        }
    }
}

- (void)scrollToPreviousOrNextCell:(NSString *)direction {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        
        NSInteger firstIndex = 0;
        NSInteger lastIndex =  self.arrCollectionDetail.count - 1;
        
        NSArray *currentIndex = [self.collectionViewDetail indexPathsForVisibleItems];
        NSInteger nextIndex = [[currentIndex objectAtIndex:0] row] + 1;
        NSInteger previousIndex = [[currentIndex objectAtIndex:0] row] - 1;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextIndex inSection:0];
        NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:previousIndex inSection:0];
        
        if ([direction isEqualToString:@"Previous"]) {
            if (previousIndex < firstIndex) {
                
            } else {
                [self.collectionViewDetail scrollToItemAtIndexPath:previousIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
            
        } else if ([direction isEqualToString:@"Next"]) {
            if (nextIndex > lastIndex) {
                
            } else {
                [self.collectionViewDetail scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            }
        }
    });
}


#pragma mark - Textfield Delegate Method - 

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.txtNotes resignFirstResponder];
    return true;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tblCollectionDetail.contentInset=UIEdgeInsetsMake(0, 0, 256, 0);
    [self.tblCollectionDetail scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.tblCollectionDetail.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    return true;                                                                                                                                                                                                               
}

@end
