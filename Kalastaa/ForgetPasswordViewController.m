//
//  ForgetPasswordViewController.m
//  Kalastaa
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"
#import "NSString+PJR.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define ShowAlert(myTitle, myMessage) [[[UIAlertView alloc] initWithTitle:myTitle message:myMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

@class handelURLConnection;

@interface ForgetPasswordViewController ()<UITextFieldDelegate,UIScrollViewDelegate,HnadleNsUrlConnectionDelegate>
@property (nonatomic,retain) handelURLConnection *URLConnection;
@property (nonatomic,retain) UIScrollView * BackgroundScroollView;
@property (nonatomic,retain) UITextField  *UserEmail;
@end

@implementation ForgetPasswordViewController

const float FPTextXcord          = 65.0f;
const float FPTextYcord          = 120.0f;
const float FPTextYcord4s        = 70.0f;
const float FPTextWidth          = 105.0f;
const float FPTextHeight         = 50.0f;
const float FPgapbetweenTwotext  = -5.0f;
const float FPRestTextWidth      = 106.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"ForgetPasswordViewController" bundle:nil]:[super initWithNibName:@"ForgetPasswordViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    [self SetupHeaderViewWithView:self.view withBackButton:YES withTitle:@"Recover"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"111-1.png"]]];
    
    self.HandleURLConnection = [[handelURLConnection alloc] init];
    
    /*
     Decleare background scrollview
     */
    
    self.BackgroundScroollView = (UIScrollView *)[self.view viewWithTag:99];
    [self.BackgroundScroollView setDelegate:self];
    
    /*
     */
    
    UILabel *RegTextlabel = [[UILabel alloc] initWithFrame:CGRectMake(FPTextXcord, (IS_IPHONE5)?FPTextYcord:FPTextYcord4s, FPTextWidth, FPTextHeight)];
    [RegTextlabel setBackgroundColor:[UIColor clearColor]];
    [RegTextlabel setTextColor:UIColorFromRGB(0x000000)];
    [RegTextlabel setText:@"Password"];
    [RegTextlabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegTextlabel];
    
    UILabel *RegRestText = [[UILabel alloc] initWithFrame:CGRectMake(FPTextXcord+FPTextWidth+FPgapbetweenTwotext, (IS_IPHONE5)?FPTextYcord:FPTextYcord4s, FPRestTextWidth, FPTextHeight)];
    [RegRestText setBackgroundColor:[UIColor clearColor]];
    [RegRestText setTextColor:UIColorFromRGB(0x000000)];
    [RegRestText setText:@"Recovery"];
    [RegRestText setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [self.BackgroundScroollView addSubview:RegRestText];
    
    UILabel *BorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(FPTextXcord-10, (IS_IPHONE5)?170:FPTextYcord4s+FPTextHeight-5, FPTextWidth+FPRestTextWidth+FPgapbetweenTwotext, 1)];
    [BorderLabel setBackgroundColor:UIColorFromRGB(0xd9d9d9)];
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
            [textField setDelegate:self];
            
            /*
             Add placholder to textfield
             */
            
            switch (textField.tag) {
                case 11:
                    self.UserEmail = textField;
                    [textField setPlaceholder:@"Email"];
                    [textField setBackgroundColor:[UIColor whiteColor]];
                    [textField setTextColor:[UIColor blackColor]];
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
    
    UIButton *LoginButton = (UIButton *)[self.BackgroundScroollView viewWithTag:100];
    [LoginButton setBackgroundColor:UIColorFromRGB(0x00c4ad)];
    [LoginButton setTitle:@"RECOVER" forState:UIControlStateNormal];
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton.titleLabel setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:15.0f]];
    
    
    
    /*
     Add event target to the buttons
     */
    
    [LoginButton addTarget:self action:@selector(dologin:) forControlEvents:UIControlEventTouchUpInside];
    
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
        
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[json objectForKey:[StaticStrings WSMessageString]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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
