//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWSignUpVC.h"
#import "AWSignUPCell.h"
#import "AWSignUpData.h"
#import "AWPhoneVerificationVC.h"

@interface AWSignUpVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(strong,nonatomic) IBOutlet UITableView *tblSignUp;
@property(strong,nonatomic) NSMutableArray *arrPlaceHolder;
@property(strong,nonatomic) AWSignUpData *signUpData;

#define APhone 0
#define AName 1
#define AEmail 2
#define Tag_SEND 5

@end

@implementation AWSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrPlaceHolder =[[NSMutableArray alloc] initWithObjects:@"PHONE NUMBER (+1)", @"Full NAME", @"EMAIL",nil];
    [self performSelector:@selector(setTableViewHeader) withObject:self afterDelay:0.2];
    [self performSelector:@selector(setTableViewFooter) withObject:self afterDelay:0.2];
    self.tblSignUp.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod:)];
    [self.tblSignUp addGestureRecognizer:gest];
    
    [self setUpNavigationBar];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)gestureHandlerMethod:(UITapGestureRecognizer*)sender {
    [self dismissKeyboard];
}

- (void)setUpNavigationBar {
    [self.navigationController setNavigationBarHidden:NO];

    UIButton *leftBtn = [self setCustomNavigationButtonWithFrame:CGRectMake(0, 0, 20,self.navigationController.navigationBar.bounds.size.height) title:@"<" font:[UIFont regular:14.0] textColor:[UIColor blackColor]];
    [leftBtn addTarget:self action:@selector(btnLeftNavigationBarClick:)
         forControlEvents:UIControlEventTouchUpInside];

    [self setCustomNavigationWithTitle:@"CONTINUE WITH PHONE NUMBER" bgColor:[UIColor whiteColor] leftButton:leftBtn rightButton:nil];
}

#pragma mark - Custom Actions -

- (IBAction)btnSendClick:(id)sender {
    AWPhoneVerificationVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWPhoneVerificationVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnLeftNavigationBarClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrPlaceHolder.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AWSignUpCell *cell =[self.tblSignUp dequeueReusableCellWithIdentifier:@"AWSignUpCell"];
    if (cell == nil) {
        cell =[[AWSignUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AWSignUpCell"];
    }
    cell.txtData.delegate = self;
    cell.txtData.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.txtData.placeholder =[self.arrPlaceHolder objectAtIndex:indexPath.row];
    [cell.txtData addTarget:self action:@selector(textDidChangeForVerification:) forControlEvents:UIControlEventEditingChanged];
    switch (indexPath.row) {
        case APhone:
            cell.txtData.keyboardType = UIKeyboardTypePhonePad;
            cell.txtData.text = self.signUpData.phoneNumber;
            [cell.imgIcon setImage:[UIImage imageNamed:@"phone_icon"]];
            break;
        case AName:
            cell.txtData.text = self.signUpData.name;
            cell.txtData.keyboardType = UIKeyboardTypeDefault;
            break;
        case AEmail:
            cell.txtData.keyboardType = UIKeyboardTypeEmailAddress;
            cell.txtData.text = self.signUpData.email;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Tableview header/Footer Method -

-(void)setTableViewHeader{
    UIView *vwHeader = [[[NSBundle mainBundle]loadNibNamed:@"AWSignUpHeader" owner:self options:nil]objectAtIndex:0];
    ;
    self.tblSignUp.tableHeaderView = vwHeader;
}

-(void)setTableViewFooter{
    UIView *vwFooter = [[[NSBundle mainBundle]loadNibNamed:@"AWSignUpFooter" owner:self options:nil]objectAtIndex:0];
    ;
    
    UIButton *btnSend = (UIButton *)[vwFooter viewWithTag:Tag_SEND];
    [btnSend addTarget:self action:@selector(btnSendClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tblSignUp.tableFooterView = vwFooter;
}

#pragma mark - textField Delegate Method -
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    AWSignUpCell *cell =[self.tblSignUp cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    [cell.txtData resignFirstResponder];
    self.tblSignUp.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    return true;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tblSignUp.contentInset=UIEdgeInsetsMake(0, 0, 216, 0);
    [self.tblSignUp scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.tblSignUp.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    return true;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [textField phoneNumberFormatStringFromRange:range AndStringIs:string];
    self.signUpData.phoneNumber = textField.text;
    return NO;
}

-(void)textDidChangeForVerification:(UITextField *)textField{
    AWSignUpCell *cell =[self.tblSignUp cellForRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0]];
    if(textField.tag == APhone){
        self.signUpData.phoneNumber = cell.txtData.text;
    }
    if(textField.tag == AName){
        self.signUpData.name = cell.txtData.text;
    }
    if (textField.tag == AEmail) {
        self.signUpData.email = cell.txtData.text;
    }
}


@end
