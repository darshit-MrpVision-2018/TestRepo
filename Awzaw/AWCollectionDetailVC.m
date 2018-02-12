//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWCollectionDetailVC.h"
#import "AWCollectionDetailOtherCommentCell.h"
#import "AWCollectionDetailUserCommentCell.h"
#import "AWPreviewCVCell.h"
#import "AWRecipientsCVCell.h"
#import "AWLabel.h"
#import "AWCreateCollectionVC.h"
#import "AWAddRecipientsVC.h"

//Header Tags
#define Tag_Send_Button 1
#define Tag_Comment_Textfield 2
//Footer Tags
#define Tag_Caption_Label 5
#define Tag_Preview_CollectionView 6
#define Tag_Recipients_CollectionView 7
#define Tag_Add_Asset_Button 8
#define Tag_Add_Recipients_Button 9

@interface AWCollectionDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic) IBOutlet UITableView *tblCollectionDetailObj;
@property(strong,nonatomic) UICollectionView *previewCVObj;
@property(strong,nonatomic) UICollectionView *recipientsCVObj;
@property(strong,nonatomic) NSMutableArray *arrAssests,*arrComments;
@property(strong,nonatomic) NSString *strTempComment;
@end

@implementation AWCollectionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self performSelector:@selector(setUpTableFooter) withObject:self afterDelay:0.2];
    [self performSelector:@selector(setUpTableHeader) withObject:self afterDelay:0.2];

    self.arrAssests = [[NSMutableArray alloc] initWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", nil];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    [self loadComments];
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

- (void)loadComments {
    self.arrComments = [[NSMutableArray alloc] init];
    
    for (int i=0; i<10; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        if (i%2==0) {
            [dict setObject:@"NM" forKey:@"comment_user_initials"];
        [dict setObject:@"other" forKey:@"comment_by"];
            [dict setObject:@"On the deck there's a BBQ and the tools are awesome, so in love with this view..On the deck there's a BBQ and the tools are awesome, so in love with this view..On the deck there's a BBQ and the tools are awesome, so in love with this view..On the deck there's a BBQ and the tools are awesome, so in love with this view..On the deck there's a BBQ and the tools are awesome, so in love with this view..On the deck there's a BBQ and the tools are awesome, so in love with this view" forKey:@"comment_desc"];
            [dict setObject:[NSString stringWithFormat:@"10/%d/2017 10:01 AM",i+1] forKey:@"comment_timestamp"];
            
//        } else{
//            [dict setObject:@"NM" forKey:@"comment_user_initials"];
//            [dict setObject:@"On the deck there's a BBQ and the tools are awesome, so in love with this view....On the deck there's a BBQ and the tools are awesome, so in love with this view....On the deck there's a BBQ and the tools are awesome, so in love with this view" forKey:@"comment_desc"];
//            [dict setObject:[NSString stringWithFormat:@"10/%d/2017 10:01 AM",i+1] forKey:@"comment_timestamp"];
//            
//        }
        
        [self.arrComments addObject:dict];
    }
}

-(CGFloat)heightForLabel:(UILabel *)label withText:(NSString *)text{
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:label.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){label.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:NSLineBreakByWordWrapping];
    
    return ceil(rect.size.height);
}


#pragma mark - Custom Actions -

- (IBAction)btnAddAssestClick:(id)sender {
    AWCreateCollectionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWCreateCollectionVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnAddRecipientsClick:(id)sender {
    AWAddRecipientsVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWAddRecipientsVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnSendClick:(UIButton *)sender {
    
    [self dismissKeyboard];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:@"DV" forKey:@"comment_user_initials"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.strTempComment] forKey:@"comment_desc"];
    [dict setObject:@"self" forKey:@"comment_by"];

    //@"Hello Everyone! its great to see you all here. Thanks for commenting your views."
        [dict setObject:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"comment_timestamp"];
    [self.arrComments addObject:dict];
    
    UITextField *text =(UITextField *)[self.tblCollectionDetailObj.tableFooterView viewWithTag:Tag_Comment_Textfield];
    [text setText:@""];
    
    [self.tblCollectionDetailObj reloadData];
}

- (IBAction)btnBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Tableview Delegate Method -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_by"] isEqualToString:@"self"]) {
        AWCollectionDetailUserCommentCell *cell =[self.tblCollectionDetailObj dequeueReusableCellWithIdentifier:@"AWCollectionDetailUserCommentCell"];
        if (cell == nil) {
            cell = [[AWCollectionDetailUserCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWCollectionDetailUserCommentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgUserProfilePic.clipsToBounds = YES;
        cell.imgUserProfilePic.layer.cornerRadius = cell.imgUserProfilePic.layer.frame.size.width/2;
        
        cell.imgUserProfilePic.backgroundColor = [UIColor magentaColor];
        [cell.lblInitials setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_user_initials"]];
        [cell.lblComment setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_desc"]];
        [cell.lblDate setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_timestamp"]];
        for(int i=0;i<cell.lblComment.constraints.count;i++){
            NSLayoutConstraint *constraints=[cell.lblComment.constraints objectAtIndex:i];
            if(constraints.firstItem==cell.lblComment && constraints.firstAttribute==NSLayoutAttributeHeight){
                constraints.constant = [self heightForLabel:cell.lblComment withText:[[self.arrComments objectAtIndex:indexPath.row] valueForKey:@"comment_desc"]];
                NSLog(@"Constraint : %f",constraints.constant);
                break;
            }
        }
        [cell layoutSubviews];
        return cell;
    }
    else{
        AWCollectionDetailOtherCommentCell *cell =[self.tblCollectionDetailObj dequeueReusableCellWithIdentifier:@"AWCollectionDetailOtherCommentCell"];
        if (cell == nil) {
            cell = [[AWCollectionDetailOtherCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWCollectionDetailOtherCommentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgUserProfilePic.clipsToBounds = YES;
        cell.imgUserProfilePic.layer.cornerRadius = cell.imgUserProfilePic.layer.frame.size.width/2;
        
        cell.imgUserProfilePic.backgroundColor = [UIColor orangeColor];
        [cell.lblInitials setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_user_initials"]];
        [cell.lblComment setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_desc"]];
        [cell.lblDate setText:[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_timestamp"]];
        
        for(int i=0;i<cell.lblComment.constraints.count;i++){
            NSLayoutConstraint *constraints=[cell.lblComment.constraints objectAtIndex:i];
            if(constraints.firstItem==cell.lblComment && constraints.firstAttribute==NSLayoutAttributeHeight){
                constraints.constant = [self heightForLabel:cell.lblComment withText:[[self.arrComments objectAtIndex:indexPath.row] valueForKey:@"comment_desc"]];
                NSLog(@"Constraint : %f",constraints.constant);
                break;
            }
        }
        [cell layoutSubviews];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[self.arrComments objectAtIndex:indexPath.row] objectForKey:@"comment_by"] isEqualToString:@"self"]) {
        AWCollectionDetailUserCommentCell *cell = (AWCollectionDetailUserCommentCell *) [self tableView:self.tblCollectionDetailObj cellForRowAtIndexPath:indexPath];
        for(int i=0;i<cell.lblComment.constraints.count;i++){
            NSLayoutConstraint *constraints=[cell.lblComment.constraints objectAtIndex:i];
            if(constraints.firstItem==cell.lblComment && constraints.firstAttribute==NSLayoutAttributeHeight){
                constraints.constant = [self heightForLabel:cell.lblComment withText:[[self.arrComments objectAtIndex:indexPath.row] valueForKey:@"comment_desc"]];
                NSLog(@"Constraint : %f",constraints.constant);
                break;
            }
        }
        [cell layoutSubviews];
        return cell.lblComment.frame.origin.y + cell.lblComment.bounds.size.height + 5;
    } else{
        AWCollectionDetailOtherCommentCell *cell = (AWCollectionDetailOtherCommentCell *) [self tableView:self.tblCollectionDetailObj cellForRowAtIndexPath:indexPath];
        for(int i=0;i<cell.lblComment.constraints.count;i++){
            NSLayoutConstraint *constraints=[cell.lblComment.constraints objectAtIndex:i];
            if(constraints.firstItem==cell.lblComment && constraints.firstAttribute==NSLayoutAttributeHeight){
                constraints.constant = [self heightForLabel:cell.lblComment withText:[[self.arrComments objectAtIndex:indexPath.row] valueForKey:@"comment_desc"]];
                NSLog(@"Constraint : %f",constraints.constant);
                break;
            }
        }
        [cell layoutSubviews];
        return cell.lblComment.frame.origin.y + cell.lblComment.bounds.size.height + 5;
    }
}


#pragma mark - Tableview header/Footer Method -

- (void)setUpTableHeader {
    
    UIView *vwHeader =[[[NSBundle mainBundle] loadNibNamed:@"AWCollectionDetailHeader" owner:self options:nil]objectAtIndex:0];
    
    self.previewCVObj = (UICollectionView *)[vwHeader viewWithTag:Tag_Preview_CollectionView];
    self.previewCVObj.delegate = self;
    self.previewCVObj.dataSource = self;
    self.previewCVObj.pagingEnabled = YES;
    [self.previewCVObj registerNib:[UINib nibWithNibName:@"AWPreviewCollectionCellNib" bundle:nil] forCellWithReuseIdentifier:@"AWPreviewCVCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.previewCVObj setCollectionViewLayout:flowLayout];
    self.previewCVObj.backgroundColor = [UIColor clearColor];

    self.recipientsCVObj = (UICollectionView *)[vwHeader viewWithTag:Tag_Recipients_CollectionView];
    self.recipientsCVObj.dataSource = self;
    self.recipientsCVObj.delegate = self;
    [self.recipientsCVObj registerNib:[UINib nibWithNibName:@"AWRecipientsCollectionCellNib" bundle:nil] forCellWithReuseIdentifier:@"AWRecipientsCVCell"];

    UIButton *btnAddRecipients = (UIButton *)[vwHeader viewWithTag:Tag_Add_Recipients_Button];
    [btnAddRecipients addTarget:self action:@selector(btnAddRecipientsClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnAddAssest = (UIButton *)[vwHeader viewWithTag:Tag_Add_Asset_Button];
    [btnAddAssest addTarget:self action:@selector(btnAddAssestClick:) forControlEvents:UIControlEventTouchUpInside];

    self.tblCollectionDetailObj.tableHeaderView = vwHeader;
}

- (void)setUpTableFooter {
    UIView *vwFooter =[[[NSBundle mainBundle]loadNibNamed:@"AWCollectionDetailFooter" owner:self options:nil]objectAtIndex:0];
    UITextField *text =(UITextField *)[vwFooter viewWithTag:Tag_Comment_Textfield];
    text.delegate = self;
    text.layer.borderWidth = 1.0;
    text.layer.borderColor = [UIColor blackColor].CGColor;
//    self.txtNotes = (UITextField *)text;
    
    UIButton *btnSend = (UIButton *)[vwFooter viewWithTag:Tag_Send_Button];
    [btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tblCollectionDetailObj.tableFooterView = vwFooter;
}


#pragma mark - CollectionView Delegate Method -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == Tag_Preview_CollectionView) {
        return self.arrAssests.count;
    } else{
        return 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == Tag_Preview_CollectionView) {
        AWPreviewCVCell *cell =[self.previewCVObj dequeueReusableCellWithReuseIdentifier:@"AWPreviewCVCell" forIndexPath:indexPath];
        
        cell.imgView = (UIImageView *)[cell viewWithTag:1];
        cell.imgView.image =[UIImage imageNamed:[self.arrAssests objectAtIndex:indexPath.row]];
        
        cell.pageControlObj = (UIPageControl *)[cell viewWithTag:2];
        cell.pageControlObj.numberOfPages = self.arrAssests.count;
        cell.pageControlObj.currentPage = indexPath.row;
        return cell;
    } else{
        AWRecipientsCVCell *cell =[self.recipientsCVObj dequeueReusableCellWithReuseIdentifier:@"AWRecipientsCVCell" forIndexPath:indexPath];
        cell.imgView.backgroundColor = [UIColor blueColor];
        cell.imgView.layer.masksToBounds = YES;
        cell.imgView.layer.cornerRadius = cell.imgView.bounds.size.width/2;
        cell.lblInitials.layer.masksToBounds = YES;
        cell.lblInitials.layer.cornerRadius = cell.lblInitials.bounds.size.width/2;

        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == Tag_Preview_CollectionView) {
        return CGSizeMake(self.previewCVObj.bounds.size.width, 280.0f);
    } else{
        return CGSizeMake(35.0f, 35.0f);//size+padding
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

#pragma mark - Textfield Delegate Method -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.tblCollectionDetailObj.contentInset=UIEdgeInsetsMake(0, 0, 256, 0);
    [self.tblCollectionDetailObj scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.arrComments.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.tblCollectionDetailObj.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.strTempComment = textField.text;
    return true;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    [textField phoneNumberFormatStringFromRange:range AndStringIs:string];
////    self.signUpData.phoneNumber = textField.text;
//    self.strTempComment = textField.text;
//    return NO;
//}

- (void)textDidChangeForVerification:(UITextField *)textField {
    self.strTempComment = textField.text;
}


# pragma mark - Dissmiss Keyboard -

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end

