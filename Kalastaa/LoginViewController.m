//
//  LoginViewController.m
//  Kalastaa
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "LoginViewController.h"
#import "UITextField+Extaintation.h"
#import "UIButton+Color.h"
#import "UILabel+Presentation.h"
#import "NSString+PJR.h"
#import "KeychainItemWrapper.h"
#import "SignupViewController.h"
#import "ForgetPasswordViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define ShowAlert(myTitle, myMessage) [[[UIAlertView alloc] initWithTitle:myTitle message:myMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic,retain) UIScrollView * BackgroundScroollView;
@property (nonatomic,retain) UITextField  *UserEmail,*UserPassword;
@property (nonatomic,retain) handelURLConnection *URLConnection;
@property (nonatomic,retain) UIButton *LoginButton;
@property (nonatomic, retain) KeychainItemWrapper *keychainItemWrapper;
@end

@implementation LoginViewController

const float LoginTextXcord          = 55.0f;
const float LoginTextYcord          = 120.0f;
const float LoginTextYcord4S        = 80.0f;
const float LoginTextWidth          = 60.0f;
const float LoginTextHeight         = 50.0f;
const float logingapbetweenTwotext  = -5.0f;
const float LoginRestTextWidth      = 175.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"LoginViewController" bundle:nil]:[super initWithNibName:@"LoginViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self SetupHeaderViewWithView:self.view withBackButton:YES withTitle:@"Login"];
    [super viewDidLoad];
    
    self.HandleURLConnection = [[handelURLConnection alloc] init];
    
    /*
     Decleare background scrollview
     */
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"111-1.png"]]];
    
    self.keychainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:[NSString stringWithFormat:@"MY_APP_CREDENTIALS.%@",[[NSBundle mainBundle] bundleIdentifier]] accessGroup:nil];
    [self.keychainItemWrapper resetKeychainItem];
    
    self.BackgroundScroollView = (UIScrollView *)[self.view viewWithTag:99];
    [self.BackgroundScroollView setBackgroundColor:[UIColor clearColor]];
    [self.BackgroundScroollView setDelegate:self];
    
    UILabel *RegTextlabel = [[UILabel alloc] initWithFrame:CGRectMake(LoginTextXcord, (IS_IPHONE5)?LoginTextYcord:LoginTextYcord4S, LoginTextWidth, LoginTextHeight)];
    [RegTextlabel setBackgroundColor:[UIColor clearColor]];
    [RegTextlabel setTextColor:UIColorFromRGB(0x000000)];
    [RegTextlabel setText:@"Login"];
    [RegTextlabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegTextlabel];
    
    UILabel *RegRestText = [[UILabel alloc] initWithFrame:CGRectMake(LoginTextXcord+LoginTextWidth+logingapbetweenTwotext, (IS_IPHONE5)?LoginTextYcord:LoginTextYcord4S, LoginRestTextWidth, LoginTextHeight)];
    [RegRestText setBackgroundColor:[UIColor clearColor]];
    [RegRestText setTextColor:UIColorFromRGB(0x000000)];
    [RegRestText setText:@"To Your Account"];
    [RegRestText setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegRestText];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(LoginTextXcord-10, (IS_IPHONE5)?170:LoginTextYcord4S+LoginTextHeight-5, LoginTextWidth+LoginRestTextWidth+logingapbetweenTwotext, 1)];
    [BorderLabel setBackgroundColor:UIColorFromRGB(0xa3a3a2)];
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
            [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
            [textField setBackgroundColor:[UIColor whiteColor]];
            [textField setTextColor:[UIColor blackColor]];
            [textField setDelegate:self];
            
            /*
             Add placholder to textfield
             */
            
            switch (textField.tag) {
                case 11:
                    self.UserEmail = textField;
                    [textField setPlaceholder:@"Username"];
                    break;
                case 12:
                    self.UserPassword = textField;
                    [textField setPlaceholder:@"Password"];
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
    
    self.LoginButton = (UIButton *)[self.BackgroundScroollView viewWithTag:100];
    [self.LoginButton setBackgroundColor:UIColorFromRGB(0x00c4ad)];
    [self.LoginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.LoginButton.titleLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:15.0f]];
    
    /*
     label one
     */
    
    UILabel *AlreadyRegisteredLabel = (UILabel *)[self.BackgroundScroollView viewWithTag:101];
    [AlreadyRegisteredLabel setTextColor:UIColorFromRGB(0x000000)];
    [AlreadyRegisteredLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     label two
     */
    
    UILabel *GotoForgetpassLabel = (UILabel *)[self.BackgroundScroollView viewWithTag:102];
    [GotoForgetpassLabel setTextColor:UIColorFromRGB(0x00c4ad)];
    [GotoForgetpassLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     label one
     */
    
    UILabel *AlreadyRegisteredLabel1 = (UILabel *)[self.BackgroundScroollView viewWithTag:110];
    [AlreadyRegisteredLabel1 setTextColor:UIColorFromRGB(0x000000)];
    [AlreadyRegisteredLabel1 setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     label two
     */
    
    UILabel *GotoForgetpassLabel1 = (UILabel *)[self.BackgroundScroollView viewWithTag:111];
    [GotoForgetpassLabel1 setTextColor:UIColorFromRGB(0x00c4ad)];
    [GotoForgetpassLabel1 setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:13.0f]];
    
    /*
     Go to Login Button
     */
    
    UIButton *ForgetPassButton = (UIButton *)[self.BackgroundScroollView viewWithTag:119];
    UIButton *registerButton = (UIButton *)[self.BackgroundScroollView viewWithTag:120];
    /*
     Add event target to the buttons
     */
    
    [self.LoginButton addTarget:self action:@selector(dologin:) forControlEvents:UIControlEventTouchUpInside];
    [ForgetPassButton addTarget:self action:@selector(Recover:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton addTarget:self action:@selector(Register:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)PaddingViewWithTextField:(UITextField *)UITextField
{
    UIView *paddingView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UITextField.layer.frame.size.height-25, UITextField.layer.frame.size.height)];
    UITextField.leftView        = paddingView;
    UITextField.leftViewMode    = UITextFieldViewModeAlways;
    [UITextField addSubview:paddingView];
}

-(IBAction)dologin:(id)sender
{
    AppDelegate *MainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [MainDelegate SetupTabbarController];
}

-(void)SetUserPrivateDtainKeyChain
{
    /*
     Initialze keychain class / Create instance of keychain class
     */
    
    /*
     Set keychain data accessable conirtion. Keycahin value can be accessed when the phone is unlock state/ active state
     */
    [self.keychainItemWrapper setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked) forKey:(__bridge id)(kSecAttrAccessible)];
    
    /*
     Reset Keychan data before update it, keychain data can't be overwrite
     */
    [self.keychainItemWrapper resetKeychainItem];
    
    /*
     Set User emailis in keychain as secure value
     */
    [self.keychainItemWrapper setObject:self.UserEmail.text forKey:(__bridge id)kSecAttrAccount];
    
    /*
     Set user password in keychain as secure value data
     */
    [self.keychainItemWrapper setObject:self.UserPassword.text forKey:(__bridge id)kSecValueData];
    
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
    [self.view setUserInteractionEnabled:YES];
    [self stopSpin];
    if ([[json objectForKey:[StaticStrings WSStatusStringString]] isEqualToString:[StaticStrings WSReturnSuccessString]]) {
        
        // Save data in keychain
        
        [self SetUserPrivateDtainKeyChain];
        
        // Clear all text filed data
        
        for(id aSubView in [self.BackgroundScroollView subviews])
        {
            if([aSubView isKindOfClass:[UITextField class]])
            {
                UITextField *textField=(UITextField*)aSubView;
                [textField setText:nil];
            }
        }
        
        UserDataClass *DataClass = [[UserDataClass alloc] initWithParamName:[json objectForKey:@"name"] ParamRegistrationDate:[json objectForKey:@"registration_date"] ParamuserEmail:[json objectForKey:@"user_email"] ParamUserId:[[json objectForKey:@"user_id"] intValue] ParamUsername:[json objectForKey:@"user_name"] ParamPaypalEmailId:@"Not Available" ParamUsedSpace:[json objectForKey:@"usedspace"]];
        [UserDataClass setSharedUserDataClass:DataClass];
        
        [self GotoDashboard];
        
    } else {
        
        ShowAlert([StaticStrings WSInvaliedString], [json objectForKey:[StaticStrings WSMessageString]]);
    }
}

/*
 URL connection Error Handler
 */
- (void)HnadleNsUrlConnectionErr:(handelURLConnection *)myObj Errdata:(NSError *)Errdata
{
    NSLog(@"URL connection handle error --- %@",[NSString stringWithFormat:@"%@",Errdata]);
}

-(void)dealloc
{
    self.BackgroundScroollView          = nil;
    self.UserEmail                      = nil;
    self.UserPassword                   = nil;
    self.URLConnection                  = nil;
    self.LoginButton                    = nil;
}

/*
 */

-(IBAction)Register:(id)sender
{
    SignupViewController *Signup = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:Signup];
}

-(IBAction)Recover:(id)sender
{
    ForgetPasswordViewController *Forgetpass = [[ForgetPasswordViewController alloc] initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:Forgetpass];
}

-(void)GotoDashboard
{
    
    
}

@end
