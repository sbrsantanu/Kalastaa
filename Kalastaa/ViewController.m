//
//  ViewController.m
//  Kalastaa
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "ViewController.h"
#import "MLPSpotlight.h"
#import "UIColor+HexColor.h"
#import "MyaccountViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "SignupViewController.h"

static NSString * const sampleDesc1 = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tincidunt laoreet diam, id suscipit ipsum sagittis a. ";

static NSString * const sampleDesc2 = @" Suspendisse et ultricies sem. Morbi libero dolor, dictum eget aliquam quis, blandit accumsan neque. Vivamus lacus justo, viverra non dolor nec, lobortis luctus risus.";

static NSString * const sampleDesc3 = @"In interdum scelerisque sem a convallis. Quisque vehicula a mi eu egestas. Nam semper sagittis augue, in convallis metus";

static NSString * const sampleDesc4 = @"Praesent ornare consectetur elit, in fringilla ipsum blandit sed. Nam elementum, sem sit amet convallis dictum, risus metus faucibus augue, nec consectetur tortor mauris ac purus.";

static NSString * const sampleDesc5 = @"Sed rhoncus arcu nisl, in ultrices mi egestas eget. Etiam facilisis turpis eget ipsum tempus, nec ultricies dui sagittis. Quisque interdum ipsum vitae ante laoreet, id egestas ligula auctor";

@class MyaccountViewController;

@interface ViewController ()<GHWalkThroughViewDataSource>

@property (nonatomic, strong) GHWalkThroughView* ghView ;
@property (nonatomic, strong) NSArray* descStrings;
@property (nonatomic, strong) UILabel* welcomeLabel;
@property (nonatomic,retain) IBOutlet UIView *OverlayView;

@property (nonatomic,retain) UIView *BGView;
@property (nonatomic,retain) UIImageView *LogoImageView;
@property (nonatomic,retain) UIButton *ButtonFBLogin;
@property (nonatomic,retain) UIButton *ButtonTwLogin;
@property (nonatomic,retain) UILabel *SeperaterLabel;
@property (nonatomic,retain) UILabel *ORLabel;

@property (nonatomic,retain) MyaccountViewController *SemiVC;

@property (nonatomic,retain) UIButton *SignupWithEmail;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"ViewController" bundle:nil]:[super initWithNibName:@"ViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self.navigationController navigationBar] setHidden:YES];
    /**
     *  Add Overlay View
     */
    
    // overlay view opacity
    _OverlayView.backgroundColor = [UIColor whiteColor];
    _OverlayView.layer.opacity = 0.8f;
    [MLPSpotlight addSpotlightInView:_OverlayView atPoint:_OverlayView.center];
    
    /**
     *  Add Walkthrough View
     */
    
    [self AddWalkThroughView];
    
    /**
     *
     */
    
    _BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_BGView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_BGView];
    
    /**
     *
     */
    
    _LogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 60, 150, 70)];
    [_LogoImageView setBackgroundColor:[UIColor clearColor]];
    [_LogoImageView setImage:[UIImage imageNamed:@"logo.png"]];
    [_BGView addSubview:_LogoImageView];
    
    /**
     *  Facebook Button
     */
    
    _ButtonFBLogin = [[UIButton alloc] initWithFrame:CGRectMake(60, 350, 200, 40)];
    [_ButtonFBLogin setBackgroundImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    [_ButtonFBLogin addTarget:self action:@selector(GoforFacebookSignup:) forControlEvents:UIControlEventTouchUpInside];
    [_BGView addSubview:_ButtonFBLogin];
    
    /**
     *  Twitter Button
     */
    
    _ButtonTwLogin = [[UIButton alloc] initWithFrame:CGRectMake(60, 400, 200, 40)];
    [_ButtonTwLogin setBackgroundImage:[UIImage imageNamed:@"tw.png"] forState:UIControlStateNormal];
    [_ButtonTwLogin addTarget:self action:@selector(GoforTwitterSignup:) forControlEvents:UIControlEventTouchUpInside];
    [_BGView addSubview:_ButtonTwLogin];
    
    
    /**
     *  OR Label
     */
    _ORLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 450, 100, 20)];
    [_ORLabel setFont:[UIFont fontWithName:@"Oswald" size:14.5]];
    [_ORLabel setTextAlignment:NSTextAlignmentCenter];
    [_ORLabel setBackgroundColor:[UIColor clearColor]];
    [_ORLabel setTextColor:[UIColor whiteColor]];
    [_ORLabel setText:@"OR"];
    [_BGView addSubview:_ORLabel];
    
    /**
     *  Seperater label
     */
    
    _SeperaterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 480, 300, 1)];
    [_SeperaterLabel setBackgroundColor:[UIColor whiteColor]];
    [_BGView addSubview:_SeperaterLabel];
    
    /**
     *  Signup with email Button
     */
    
    _SignupWithEmail = [[UIButton alloc] initWithFrame:CGRectMake(60, 490, 200, 40)];
    [_SignupWithEmail setTitle:@"Signup With Email" forState:UIControlStateNormal];
    [_SignupWithEmail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SignupWithEmail setBackgroundColor:[UIColor clearColor]];
    [_SignupWithEmail addTarget:self action:@selector(GoforNormalSignup:) forControlEvents:UIControlEventTouchUpInside];
    [_SignupWithEmail.titleLabel setFont:[UIFont fontWithName:@"Oswald" size:14.5]];
    [_BGView addSubview:_SignupWithEmail];
    
}

#pragma mark for facebook signup

-(IBAction)GoforFacebookSignup:(id)sender
{
}

#pragma mark for twitter signup

-(IBAction)GoforTwitterSignup:(id)sender
{
}

#pragma mark for NormalSignup

-(IBAction)GoforNormalSignup:(id)sender
{
    LoginViewController *LoginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self GotoDifferentViewWithAnimation:LoginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - GHDataSource

-(void)AddWalkThroughView
{
    _ghView = [[GHWalkThroughView alloc] initWithFrame:self.navigationController.view.bounds];
    [_ghView setDataSource:self];
    [_ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
    UILabel* welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    welcomeLabel.text = @"Welcome";
    welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel = welcomeLabel;
    self.descStrings = [NSArray arrayWithObjects:sampleDesc1,sampleDesc2, sampleDesc3, sampleDesc4, sampleDesc5, nil];
    
    self.ghView.isfixedBackground = NO;
    self.ghView.floatingHeaderView = nil;
    [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
}

-(NSInteger) numberOfPages
{
    return 5;
}

- (void) configurePage:(GHWalkThroughPageCell *)cell atIndex:(NSInteger)index
{
    cell.title = [NSString stringWithFormat:@"This is page %ld", index+1];
    cell.titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"title%ld", index+1]];
    cell.desc = [self.descStrings objectAtIndex:index];
}

- (UIImage*) bgImageforPage:(NSInteger)index
{
    NSString* imageName =[NSString stringWithFormat:@"bg_0%ld.jpg", index+1];
    UIImage* image = [UIImage imageNamed:imageName];
    return image;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.ghView.isfixedBackground = NO;
    
    switch (indexPath.row) {
        case 0:
            self.ghView.floatingHeaderView = nil;
            [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
            break;
        case 1:
            self.ghView.floatingHeaderView = nil;
            [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
            break;
        case 2:
        {
            [_ghView setFloatingHeaderView:self.welcomeLabel];
            [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionHorizontal];
        }
            break;
        case 3:
            [_ghView setFloatingHeaderView:self.welcomeLabel];
            self.ghView.isfixedBackground = YES;
            self.ghView.bgImage = [UIImage imageNamed:@"static_bg_01"];
            [self.ghView setWalkThroughDirection:GHWalkThroughViewDirectionVertical];
            break;
            
        default:
            break;
    }
    
    [self.ghView showInView:self.navigationController.view animateDuration:0.3];
}

@end
