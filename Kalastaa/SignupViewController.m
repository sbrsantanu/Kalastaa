//
//  SignupViewController.m
//  Kalastaa
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "SignupViewController.h"
#import "LoginViewController.h"
#import "UITextField+Extaintation.h"
#import "DashboardViewController.h"
#import "NSString+PJR.h"
@class handelURLConnection;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define ShowAlert(myTitle, myMessage) [[[UIAlertView alloc] initWithTitle:myTitle message:myMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

@interface SignupViewController ()<UITextFieldDelegate,UIScrollViewDelegate,HnadleNsUrlConnectionDelegate, UIAlertViewDelegate>

@property (nonatomic,retain) handelURLConnection *URLConnection;
@property (nonatomic,retain) UIScrollView * BackgroundScroollView;
@property (nonatomic,retain) UITextField  *Userfullname, *Username,*UserEmail,*UserPassword,*UserRetpePassword;
@end

@implementation SignupViewController

const float RegTextXcord          = 50.0f;
const float RegTextYcord          = 70.0f;
const float RegTextYcord4s        = 45.0f;
const float RegTextWidth          = 90.0f;
const float RegTextHeight         = 50.0f;
const float gapbetweenTwotext     = -5.0f;
const float RegRestTextWidth      = 150.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"SignupViewController" bundle:nil]:[super initWithNibName:@"SignupViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self SetupHeaderViewWithView:self.view withBackButton:YES withTitle:@"Signup"];
    
    self.HandleURLConnection = [[handelURLConnection alloc] init];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"111-1.png"]]];
    
    /*
     Decleare background scrollview
     */
    
    self.BackgroundScroollView = (UIScrollView *)[self.view viewWithTag:99];
    [self.BackgroundScroollView setDelegate:self];
    
    /*
     */
    
    UILabel *RegTextlabel = [[UILabel alloc] initWithFrame:CGRectMake(RegTextXcord, (IS_IPHONE5)?RegTextYcord:RegTextYcord4s, RegTextWidth, RegTextHeight)];
    [RegTextlabel setBackgroundColor:[UIColor clearColor]];
    [RegTextlabel setTextColor:UIColorFromRGB(0x000000)];
    [RegTextlabel setText:@"Register"];
    [RegTextlabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegTextlabel];
    
    UILabel *RegRestText = [[UILabel alloc] initWithFrame:CGRectMake(RegTextXcord+RegTextWidth+gapbetweenTwotext, (IS_IPHONE5)?RegTextYcord:RegTextYcord4s, RegRestTextWidth, RegTextHeight)];
    [RegRestText setBackgroundColor:[UIColor clearColor]];
    [RegRestText setTextColor:UIColorFromRGB(0x000000)];
    [RegRestText setText:@"Your Account"];
    [RegRestText setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegRestText];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(RegTextXcord-10, (IS_IPHONE5)?120:RegTextYcord4s+RegTextHeight-5, RegTextWidth+RegRestTextWidth+gapbetweenTwotext, 1)];
    [BorderLabel setBackgroundColor:UIColorFromRGB(0x00c4ad)];
    [self.BackgroundScroollView addSubview:BorderLabel];
    
    /*
     Searchfor uitextfield in main scrollview
     */
    
    for(id aSubView in [self.BackgroundScroollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            /*
             Decleare the textfield
             */
            
            UITextField *textField=(UITextField*)aSubView;
            [textField setBackgroundColor:[UIColor whiteColor]];
            [textField setTextColor:[UIColor blackColor]];
            [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textField setDelegate:self];
            
            /*
             Add placholder to textfield
             */
            
            switch (textField.tag) {
                case 11:
                    self.Userfullname = textField;
                    [textField setPlaceholder:@"Your Name"];
                    break;
                case 12:
                    self.UserEmail = textField;
                    [textField setPlaceholder:@"Email"];
                    break;
                case 13:
                    self.Username = textField;
                    [textField setPlaceholder:@"Username"];
                    break;
                case 14:
                    self.UserPassword = textField;
                    [textField setPlaceholder:@"Password"];
                    [textField setSecureTextEntry:YES];
                    break;
                case 15:
                    self.UserRetpePassword = textField;
                    [textField setPlaceholder:@"Retype password"];
                    [textField setSecureTextEntry:YES];
                    break;
            }
            
            /*
             Add padding to textfield
             */
            
            [self PaddingViewWithTextField:textField];
            
            /*
             Set border
             */
            
            [textField.layer setBorderColor:UIColorFromRGB(0xd9d9d9).CGColor];
            [textField.layer setBorderWidth:1.0f];
            [textField.layer setCornerRadius:1.0f];
        }
    }
    
    /*
     Add register button
     */
    
    UIButton *RegisterButton = (UIButton *)[self.BackgroundScroollView viewWithTag:100];
    [RegisterButton setBackgroundColor:UIColorFromRGB(0x00c4ad)];
    [RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [RegisterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [RegisterButton.titleLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:15.0f]];
    
    /*
     label one
     */
    
    UILabel *AlreadyRegisteredLabel = (UILabel *)[self.BackgroundScroollView viewWithTag:101];
    [AlreadyRegisteredLabel setTextColor:UIColorFromRGB(0x000000)];
    [AlreadyRegisteredLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     label two
     */
    
    UILabel *GotoLoginLabel = (UILabel *)[self.BackgroundScroollView viewWithTag:102];
    [GotoLoginLabel setTextColor:UIColorFromRGB(0x00c4ad)];
    [GotoLoginLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     Go to Login Button
     */
    
    UIButton *GotoLoginButton = (UIButton *)[self.BackgroundScroollView viewWithTag:103];
    
    /*
     Add event target to the buttons
     */
    
    [RegisterButton addTarget:self action:@selector(doregistration:) forControlEvents:UIControlEventTouchUpInside];
    [GotoLoginButton addTarget:self action:@selector(GotoLogin:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)PaddingViewWithTextField:(UITextField *)UITextField
{
    UIView *paddingView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UITextField.layer.frame.size.height-25, UITextField.layer.frame.size.height)];
    UITextField.leftView        = paddingView;
    UITextField.leftViewMode    = UITextFieldViewModeAlways;
    [UITextField addSubview:paddingView];
}
-(IBAction)doregistration:(id)sender
{
    [self GotoLogin:nil];
}
-(IBAction)GotoLogin:(id)sender
{
    LoginViewController *RR = [[LoginViewController alloc] initWithNibName:NSStringFromClass(LoginViewController.class) bundle:nil];
    [self GotoDifferentViewWithAnimation:RR];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 11:
        {
            [UIView animateWithDuration:1.0f animations:^(void){
                [self.BackgroundScroollView setContentOffset:CGPointMake(0, 20) animated:YES];
            }];
            break;
        }
        case 12:
        {
            [UIView animateWithDuration:1.0f animations:^(void){
                [self.BackgroundScroollView setContentOffset:CGPointMake(0, 40) animated:YES];
            }];
            break;
        }
        case 13:
        {
            [UIView animateWithDuration:1.0f animations:^(void){
                [self.BackgroundScroollView setContentOffset:CGPointMake(0, 60) animated:YES];
            }];
            break;
        }
        case 14:
        {
            [UIView animateWithDuration:1.0f animations:^(void){
                [self.BackgroundScroollView setContentOffset:CGPointMake(0, 80) animated:YES];
            }];
            break;
        }
        case 15:
        {
            [UIView animateWithDuration:1.0f animations:^(void){
                [self.BackgroundScroollView setContentOffset:CGPointMake(0, 100) animated:YES];
            }];
            break;
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1.0f animations:^(void){
        [self.BackgroundScroollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }];
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma URL connection protocol required method details

/*
 URL connection success handler
 */
- (void)HnadleNsUrlConnection:(handelURLConnection *)myObj json:(NSDictionary *)json
{
    NSLog(@"json --- %@",json);
    [self.view setUserInteractionEnabled:YES];
    [self stopSpin];
    if ([[json objectForKey:[StaticStrings WSStatusStringString]] isEqualToString:[StaticStrings WSReturnSuccessString]]) {
        
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully registered, Go to login" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert setTag:999];
        [Alert show];
        
    } else {
        
        ShowAlert([StaticStrings WSInvaliedString], [json objectForKey:[StaticStrings WSMessageString]]);
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999) {
        LoginViewController *loginview = [[LoginViewController alloc] initWithNibName:NSStringFromClass(LoginViewController.class) bundle:nil];
        [self GotoDifferentViewWithAnimation:loginview];
    }
}
/*
 URL connection Error Handler
 */
- (void)HnadleNsUrlConnectionErr:(handelURLConnection *)myObj Errdata:(NSError *)Errdata
{
    NSLog(@"URL connection handle error --- %@",[NSString stringWithFormat:@"%@",Errdata]);
}


@end
