//
//  SettingViewController.m
//  Azwaz
//
//  Created by Darshit Vora on 02/11/17.
//  Copyright © 2017 Darshit Vora. All rights reserved.
//
#define KTextFieldName 0
#define KTextFieldEmail 1
#define KTextFieldPhone 2
#define KTextFieldPassword 3

#import "AWSettingVC.h"
#import "AWSettingViewCell.h"
#import "AWSignUpData.h"

@interface AWSettingVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic) NSMutableArray *arrPlaceHolder;
@property(strong,nonatomic) NSMutableArray *arrImages;
@property(strong,nonatomic) IBOutlet UITableView *tblSetting;
@property(strong,nonatomic) AWSignUpData *userData;
@property(strong,nonatomic) UILabel *lblProfileName;

@end

@implementation AWSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationCustom];
    self.userData = [AWSignUpData new];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.arrPlaceHolder =[[NSMutableArray alloc]initWithObjects:@"NAME",@"EMAIL",@"PHONE (+1)",@"PASSWORD", nil];
    self.arrImages =[[NSMutableArray alloc]initWithObjects:@"phone_icon",@"phone_icon",@"phone_icon",@"phone_icon", nil];
    [self performSelector:@selector(setUpTableViewHeader) withObject:self afterDelay:0.2];
    [self performSelector:@selector(setUpTableViewFooter) withObject:self afterDelay:0.2];
    UITapGestureRecognizer *taptable = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTableview:)];
    [self.tblSetting addGestureRecognizer:taptable];
}


#pragma mark - Custom method - 

- (void)setNavigationCustom{
    // Left bar Item //
    CGRect frameimg = CGRectMake(15,5, 25,25);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:[UIImage imageNamed:@"whiteBackArrow.png"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(btnBAckClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem =backButton;
    // Right bar Item //
    UIBarButtonItem *btnLogOUt =[[UIBarButtonItem alloc]initWithTitle:@"LogOut" style:UIBarButtonItemStyleDone target:self action:@selector(btnLogoutClick:)];
    btnLogOUt.title = @"LOGOUT";
    [btnLogOUt setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"Quicksand-Regular" size:16], NSFontAttributeName,
                                     [UIColor colorWithRed:182.0f/255.0f green:182.0f/255.0f blue:182.0f/255.0f alpha:1.0], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=btnLogOUt;
        // Navigation Bar Color //
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor =[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f  blue:247.0f/255.0f  alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
}

- (void)selectFromGallery{
    UIImagePickerController *select =[[UIImagePickerController alloc]init];
    select.delegate = self;
    select.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    select.allowsEditing = YES;
    [self presentViewController:select animated:YES completion:nil];
}

- (void)capturePhoto{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        [UIAlertController showAlertIn:self WithTitle:Title_Warning message:Msg_Camera_Check cancelButtonTitle:Button_OK otherButtonTitles:nil style:0 tapBlock:^(UIAlertController *alertViewController, NSInteger buttonIndex) {
            
        }];
    }
    UIImagePickerController *capture = [[UIImagePickerController alloc]init];
    capture.delegate = self;
    capture.sourceType = UIImagePickerControllerSourceTypeCamera;
    capture.allowsEditing = YES;
    [self presentViewController:capture animated:YES completion:nil];
}


#pragma mark - Custom Actions -

- (void)btnSaveClick:(UIButton *)sender {
    
}

- (IBAction)btnLogoutClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnBAckClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview Delegate Method -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPlaceHolder.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AWSettingViewCell *cell =[self.tblSetting dequeueReusableCellWithIdentifier:@"AWSettingViewCell"];
    if (cell == nil) {
        cell =[[AWSettingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWSettingViewCell"];
    }
     cell.txtProfile.tag = indexPath.row;
    [cell.txtProfile setLeftPadding:10];
    [cell.txtProfile addTarget:self action:@selector(textDidChangeLogin:) forControlEvents:UIControlEventEditingChanged];

    switch (indexPath.row) {
        case KTextFieldName:
            cell.txtProfile.text = self.userData.name;
            break;
        case KTextFieldEmail:
            cell.txtProfile.keyboardType = UIKeyboardTypeEmailAddress;
            cell.txtProfile.text = self.userData.email;
            break;
         case KTextFieldPhone:
            cell.txtProfile.keyboardType = UIKeyboardTypePhonePad;
            cell.txtProfile.text = self.userData.phoneNumber;
            break;
        case KTextFieldPassword:
            cell.txtProfile.text = self.userData.password;
            cell.txtProfile.secureTextEntry = YES;
            break;
        
        default:
            break;
    }
    cell.txtProfile.placeholder =[self.arrPlaceHolder objectAtIndex:indexPath.row];
    cell.imageProfile.image = [UIImage imageNamed:[self.arrImages objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


#pragma mark - Tableview Header/Footer Method -

- (void)setUpTableViewHeader{
    UIView *vwHeader =[[[NSBundle mainBundle]loadNibNamed:@"AWSettingHeader" owner:self options:nil]objectAtIndex:0];
   ;
    UIImageView *profileImage =[vwHeader viewWithTag:1];
    profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
    profileImage.clipsToBounds = YES;
    profileImage.userInteractionEnabled = true;
    UITapGestureRecognizer *tapImage =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    [profileImage addGestureRecognizer:tapImage];
    UILabel *lblEdit =[vwHeader viewWithTag:2];
    NSMutableAttributedString *text = [lblEdit.attributedText mutableCopy];
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, text.length)];
    lblEdit.attributedText = text;
    self.lblProfileName =[vwHeader viewWithTag:5];
    
    self.tblSetting.tableHeaderView = vwHeader;
}

- (void)setUpTableViewFooter{
    UIView *vwHeader =[[[NSBundle mainBundle]loadNibNamed:@"AWSettingFooter" owner:self options:nil]objectAtIndex:0];
    ;
//    UIButton *btnFbUnlink =[vwHeader viewWithTag:1];
//    [btnFbUnlink addTarget:self action:@selector(btnFbUnlink:) forControlEvents:UIControlEventTouchUpInside];
//    btnFbUnlink.layer.cornerRadius = 5.0f;
    UIButton *btnSave =[vwHeader viewWithTag:2];
    btnSave.layer.cornerRadius = 5.0f;
    [btnSave addTarget:self action:@selector(btnSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tblSetting.tableFooterView = vwHeader;
}


#pragma mark - Tap Gesture Methods -

- (void)tapImage:(UITapGestureRecognizer *)tap{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *selectfromGallery =[UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectFromGallery];
        self.lblProfileName.hidden= YES;
    }];
    [alert addAction:selectfromGallery];
    UIAlertAction *capturePhoto =[UIAlertAction actionWithTitle:@"Capture Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self capturePhoto];
        self.lblProfileName.hidden= YES;
    }];
    [alert addAction:capturePhoto];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tapTableview:(UITapGestureRecognizer *)tap{
    [self dismisKeyboard];
}


#pragma mark - ImagePicker Methods -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagePicked = info[UIImagePickerControllerEditedImage];
    NSURL *imageFileURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    self.userData.strProfilePic =[[NSString alloc] initWithContentsOfURL:imageFileURL
                                                                encoding:NSUTF8StringEncoding error:nil];
    picker.delegate = self;
    UIImageView *imageProfile =[self.tblSetting.tableHeaderView viewWithTag:1];
    imageProfile.image = imagePicked;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Textfield Delegate -

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    AWSettingViewCell *cell =[self.tblSetting cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    [cell.txtProfile resignFirstResponder];
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.tblSetting scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.tblSetting.contentInset=UIEdgeInsetsMake(0, 0, 256, 0);
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.tblSetting.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == KTextFieldPhone) {
        [textField phoneNumberFormatStringFromRange:range AndStringIs:string];
        self.userData.phoneNumber = textField.text;
        return NO;
    }
    return YES;
}

- (void)textDidChangeLogin:(UITextField *)textField{
    AWSettingViewCell *cell =[self.tblSetting cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    if (textField.tag == KTextFieldName) {
        self.userData.name = cell.txtProfile.text;
    }
    if (textField.tag == KTextFieldEmail) {
        self.userData.email = cell.txtProfile.text;
    }
    if (textField.tag == KTextFieldPhone) {
        self.userData.phoneNumber = cell.txtProfile.text;
    }
    if (textField.tag == KTextFieldPassword) {
        self.userData.password = cell.txtProfile.text;
    }
}

- (void)dismisKeyboard{
    for (int i =0; i<3; i++) {
          AWSettingViewCell *cell =[self.tblSetting cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell.txtProfile resignFirstResponder];
    }
}

@end
