//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWAddRecipientsVC.h"
#import "AWAddRecipientsTVCell.h"
#import <Contacts/Contacts.h>
#import "AWContact.h"
#import "AWPreviewCVCell.h"

@interface AWAddRecipientsVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>

@property(strong,nonatomic) NSMutableArray *arrRecipients,*arrAssets,*arrFilterContact;
@property(strong,nonatomic) IBOutlet UITableView *tblRecipientsObj;
@property(strong,nonatomic) IBOutlet UICollectionView *addRecipientCollection;
@property(strong,nonatomic) IBOutlet UISearchBar *searchBarObj;
@property(strong,nonatomic) IBOutlet UIView *previewView;
@property(nonatomic) BOOL isSearching;

@end

//Currently working on the Add Recipients module in preview section where user candle to see the preview of assets and also the caption where user is supposed to edit the caption. (Rule : only author is allowed to edit the caption). Right now integrating statically later on it will be done dynamically after API integration.

@implementation AWAddRecipientsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrRecipients = [[NSMutableArray alloc] init];
    self.arrAssets = [[NSMutableArray alloc] initWithObjects:@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", nil];

    [self loadContactList];
    self.arrFilterContact = [[NSMutableArray alloc] init];
    self.searchBarObj.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(dismissKeyboard)];
    [self.previewView addGestureRecognizer:tap];
    
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

-(void)loadContactList {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if( status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"access denied");
    }
    else 
    {
        //Create repository objects contacts
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        //Select the contact you want to import the key attribute  ( https://developer.apple.com/library/watchos/documentation/Contacts/Reference/CNContact_Class/index.html#//apple_ref/doc/constant_group/Metadata_Keys )
        
        NSArray *keys = [[NSArray alloc]initWithObjects:CNContactIdentifierKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey,CNContactThumbnailImageDataKey, CNContactPhoneNumbersKey, [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName], nil];
        
        // Create a request object
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        request.predicate = nil;
        
        [contactStore enumerateContactsWithFetchRequest:request
                                                  error:nil
                                             usingBlock:^(CNContact* __nonnull contact, BOOL* __nonnull stop)
         {
             // Contact one each function block is executed whenever you get
             
             NSLog(@"contact : %@",contact);
             
//             NSString *phoneNumber = @"";
//             if( contact.phoneNumbers){
//                 phoneNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
//                 NSLog(@"%@",[[contact.phoneNumbers firstObject] label]);
//             }
//             
//             NSLog(@"phoneNumber = %@", phoneNumber);
//             NSLog(@"givenName = %@", contact.givenName);
//             NSLog(@"familyName = %@", contact.familyName);
//             NSLog(@"email = %@", contact.emailAddresses);
             
             AWContact *awcontact = [[AWContact alloc] initWithContact:contact];
             
             [self.arrRecipients addObject:awcontact];
         }];
        
        [self.tblRecipientsObj reloadData];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}


#pragma mark - Custom Actions -



#pragma mark - TableView Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearching) {
        return self.arrFilterContact.count;
    }
    return self.arrRecipients.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AWAddRecipientsTVCell *cell =[self.tblRecipientsObj dequeueReusableCellWithIdentifier:@"AWAddRecipientsTVCell"];
    if (cell == nil) {
        cell =[[AWAddRecipientsTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWAddRecipientsTVCell"];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.imgProfilePic.clipsToBounds = YES;
    cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.layer.frame.size.width/2;
    
    if (self.isSearching) {
        if ([[self.arrFilterContact objectAtIndex:indexPath.row] isContactSelected]) {
            [cell.btnCheck setSelected:YES];
        } else{
            [cell.btnCheck setSelected:NO];
        }
        
        if ([[self.arrFilterContact objectAtIndex:indexPath.row] contactProfilePicData]) {
            [cell.imgProfilePic setImage:[UIImage imageWithData:[[self.arrFilterContact objectAtIndex:indexPath.row] contactProfilePicData]]];
            [cell.lblRecipientInitials setHidden:YES];
        } else{
            [cell.lblRecipientInitials setHidden:NO];
            [cell.lblRecipientInitials setText:[[self.arrFilterContact objectAtIndex:indexPath.row] contactInitials]];
            [cell.imgProfilePic setBackgroundColor:[UIColor magentaColor]];
        }
        
        [cell.lblRecipientName setText:[[self.arrFilterContact objectAtIndex:indexPath.row] contactFullname]];
        if ([[self.arrFilterContact objectAtIndex:indexPath.row] contactNumber]) {
            [cell.lblRecipientPhoneNumber setText:[[self.arrFilterContact objectAtIndex:indexPath.row] contactNumber]];
            [cell.lblRecipientType setText:[[self.arrFilterContact objectAtIndex:indexPath.row] contactCategory]];
        }
        
    } else{
        if ([[self.arrRecipients objectAtIndex:indexPath.row] isContactSelected]) {
            [cell.btnCheck setSelected:YES];
        } else{
            [cell.btnCheck setSelected:NO];
        }
        
        if ([[self.arrRecipients objectAtIndex:indexPath.row] contactProfilePicData]) {
            [cell.imgProfilePic setImage:[UIImage imageWithData:[[self.arrRecipients objectAtIndex:indexPath.row] contactProfilePicData]]];
            [cell.lblRecipientInitials setHidden:YES];
        } else{
            [cell.lblRecipientInitials setHidden:NO];
            [cell.lblRecipientInitials setText:[[self.arrRecipients objectAtIndex:indexPath.row] contactInitials]];
            [cell.imgProfilePic setBackgroundColor:[UIColor magentaColor]];
        }
        
        [cell.lblRecipientName setText:[[self.arrRecipients objectAtIndex:indexPath.row] contactFullname]];
        if ([[self.arrRecipients objectAtIndex:indexPath.row] contactNumber]) {
            [cell.lblRecipientPhoneNumber setText:[[self.arrRecipients objectAtIndex:indexPath.row] contactNumber]];
            [cell.lblRecipientType setText:[[self.arrRecipients objectAtIndex:indexPath.row] contactCategory]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected number : %ld",(long)indexPath.row);
    AWAddRecipientsTVCell *cell = (AWAddRecipientsTVCell *)[self.tblRecipientsObj cellForRowAtIndexPath:indexPath];
    
    if (cell.btnCheck.isSelected) {
        [cell.btnCheck setSelected:NO];
        [[self.arrRecipients objectAtIndex:indexPath.row] setIsContactSelected:NO];

    } else{
        [cell.btnCheck setSelected:YES];
        [[self.arrRecipients objectAtIndex:indexPath.row] setIsContactSelected:YES];
    }
    [self.tblRecipientsObj reloadData];

}


#pragma mark - CollectionView Methods -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AWPreviewCVCell *cell =[self.addRecipientCollection dequeueReusableCellWithReuseIdentifier:@"AWPreviewCVCell" forIndexPath:indexPath];
    
    cell.imgView.image =[UIImage imageNamed:[self.arrAssets objectAtIndex:indexPath.row]];
    
    cell.pageControlObj.numberOfPages = self.arrAssets.count;
    cell.pageControlObj.currentPage = indexPath.row;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.addRecipientCollection.bounds.size.width, self.addRecipientCollection.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText {
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"self.contactFirstname CONTAINS[cd] %@ OR self.contactLastname CONTAINS[cd] %@ OR self.contactNumber  CONTAINS[cd] %@ ",
                                    searchText,searchText,searchText];
//    NSArray *array = [[NSArray alloc] init];
    self.arrFilterContact = (NSMutableArray *)[self.arrRecipients filteredArrayUsingPredicate:resultPredicate];
    [self.tblRecipientsObj reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchBar.text.length == 0) {
        self.isSearching = NO;
        [self.tblRecipientsObj reloadData];
    }
    else {
        self.isSearching = YES;        [self filterContentForSearchText:searchBar.text];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    [searchBar resignFirstResponder];
    self.isSearching = YES;
    [self filterContentForSearchText:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
   
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    self.isSearching = NO;
    [self.tblRecipientsObj reloadData];
}

@end
