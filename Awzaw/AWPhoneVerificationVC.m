//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWPhoneVerificationVC.h"
#import "AWContainerVC.h"

@interface AWPhoneVerificationVC ()<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txt1,*txt2,*txt3,*txt4;
@property (nonatomic, strong) NSString *StrTxt;
@property (nonatomic, strong) IBOutlet UIButton *sendAgainBtn;

@end

@implementation AWPhoneVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate];
    [self setUpNavigationBar];
    [self setUpButtons];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

- (void)setUpNavigationBar {
    [self.navigationController setNavigationBarHidden:NO];
    
    UIButton *leftBtn = [self setCustomNavigationButtonWithFrame:CGRectMake(0, 0, 50,self.navigationController.navigationBar.bounds.size.height) title:@"< Back" font:[UIFont regular:15.0] textColor:[UIColor blackColor]];
    [leftBtn addTarget:self action:@selector(btnLeftNavigationBarClick:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [self setCustomNavigationButtonWithFrame:CGRectMake(0, 0, 50,self.navigationController.navigationBar.bounds.size.height) title:@"Next >" font:[UIFont regular:15.0] textColor:[UIColor blackColor]];
    [rightBtn addTarget:self action:@selector(btnRightNavigationBarClick:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self setCustomNavigationWithTitle:@"CONTINUE WITH PHONE NUMBER" bgColor:[UIColor whiteColor] leftButton:leftBtn rightButton:rightBtn];
}

- (void)setDelegate {
    self.txt1.delegate = self;
    self.txt2.delegate = self;
    self.txt3.delegate = self;
    self.txt4.delegate = self;
}

- (void)setUpButtons {
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"send me the code again" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    [self.sendAgainBtn setAttributedTitle:titleString forState:UIControlStateNormal];
}

#pragma mark - Custom Actions -

- (IBAction)btnLeftNavigationBarClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRightNavigationBarClick:(id)sender {
    AWContainerVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWContainerVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnSendAgainClick:(id)sender {
    
}

#pragma mark - Gesture Recognition -
-(void)gestureHandlerMethod:(UITapGestureRecognizer*)sender {
    [self dismissKeyboard];
}

#pragma mark - UITextField Delegates -
- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = YES;
    
    if ([textField.text length] == 0 && [textField.text isEqualToString:@""]) {
        long tagValue = textField.tag - 1;
        UITextField *txtField = (UITextField*) [self.view viewWithTag:tagValue];
        [txtField becomeFirstResponder];
    }
    return shouldDelete;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // This allows numeric text only, but also backspace for deletes
    int currentTag = (int)textField.tag;
    
    if(string.length==0 && range.length==1)
    {
        textField.text = @"";
        UITextField *newTextField = (UITextField *) [textField.superview viewWithTag:(currentTag-1)];
        [newTextField becomeFirstResponder];
        self.StrTxt = [self.StrTxt substringToIndex:currentTag-1];
        return NO;
    }
    else
        self.StrTxt = [self.StrTxt stringByAppendingString:string];
    
    if((textField.text.length + string.length) >= 1)
    {
        if(currentTag == 4)
        {
            if(textField.text.length<1)
                return YES;
            else
                return NO;
        }
        
        UITextField *newTextField = (UITextField *) [textField.superview viewWithTag:(currentTag+1)];
        if(newTextField.text.length==0)
            [newTextField becomeFirstResponder];
        if(textField.text.length==0)
        {
            textField.text = [textField.text stringByAppendingString:string];
            return NO;
        }
        else
        {
            if(currentTag+1 == 4)
            {
                if(newTextField.text.length>=1)
                    return NO;
            }
            else
                if(newTextField.text.length>=1)
                    return NO;
            return YES;
        }
    }
    return YES;
}

#pragma mark - Dismiss Keyboard -

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
