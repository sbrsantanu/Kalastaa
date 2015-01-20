//
//  SideMenuViewController.m
//  OCRScanner
//
//  Created by Mac on 25/09/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "SideMenuViewController.h"
#import "UIColor+HexColor.h"
#import <QuartzCore/QuartzCore.h>

@interface SideMenuViewController ()
@property (nonatomic,retain) UIScrollView *MainBgScrollview;
@end

@implementation SideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change background color
    
    [self.view setBackgroundColor:[UIColor colorFromHex:0x575757]];
    
    self.MainBgScrollview = (UIScrollView *)[self.view viewWithTag:786];
    [self.MainBgScrollview setDelegate:self];
    [self.MainBgScrollview setBackgroundColor:[UIColor clearColor]];
    [self.MainBgScrollview setUserInteractionEnabled:YES];
    [self.MainBgScrollview setScrollEnabled:YES];
    [self.MainBgScrollview setShowsHorizontalScrollIndicator:YES];
    [self.MainBgScrollview setContentSize:CGSizeMake(self.view.layer.frame.size.width, 628)];
    
    
    // Create Vartical label
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:CGRectMake(133, 0, 1, self.view.frame.size.height)];
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHex:0x575757] CGColor], (id)[[UIColor colorFromHex:0x7d7d7d] CGColor],(id)[[UIColor colorFromHex:0x575757] CGColor], nil];
    [gradient setOpacity:0.6f];
    [self.MainBgScrollview.layer insertSublayer:gradient atIndex:0];
    
    // Create Horizontal label
    
    CAGradientLayer *gradientone = [CAGradientLayer layer];
    [gradientone setFrame:CGRectMake(0, 113, self.view.frame.size.width, 1)];
    [gradientone setOpacity:0.6f];
    gradientone.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHex:0x575757] CGColor], (id)[[UIColor colorFromHex:0x7d7d7d] CGColor],(id)[[UIColor colorFromHex:0x575757] CGColor], nil];
    [self.MainBgScrollview.layer insertSublayer:gradientone atIndex:0];
    
    CAGradientLayer *gradienttwo = [CAGradientLayer layer];
    [gradienttwo setFrame:CGRectMake(0, 226, self.view.frame.size.width, 1)];
    [gradienttwo setOpacity:0.6f];
    gradienttwo.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHex:0x575757] CGColor], (id)[[UIColor colorFromHex:0x7d7d7d] CGColor],(id)[[UIColor colorFromHex:0x575757] CGColor], nil];
    [self.MainBgScrollview.layer insertSublayer:gradienttwo atIndex:0];
    
    CAGradientLayer *gradientthree = [CAGradientLayer layer];
    [gradientthree setFrame:CGRectMake(0, 339, self.view.frame.size.width, 1)];
    gradientthree.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHex:0x575757] CGColor], (id)[[UIColor colorFromHex:0x7d7d7d] CGColor],(id)[[UIColor colorFromHex:0x575757] CGColor], nil];
    [gradientthree setOpacity:0.6f];
    [self.MainBgScrollview.layer insertSublayer:gradientthree atIndex:0];
    
    CAGradientLayer *gradientfour = [CAGradientLayer layer];
    [gradientfour setFrame:CGRectMake(0, 450, self.view.frame.size.width, 1)];
    gradientfour.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHex:0x575757] CGColor], (id)[[UIColor colorFromHex:0x7d7d7d] CGColor],(id)[[UIColor colorFromHex:0x575757] CGColor], nil];
    [gradientfour setOpacity:0.6f];
    [self.MainBgScrollview.layer insertSublayer:gradientfour atIndex:0];
    
    NSArray *TextArray = [[NSArray alloc] initWithObjects:
                          @"",
                          @"A",
                          @"B",
                          @"C",
                          @"D",
                          @"E",
                          @"F",
                          @"G",
                          @"H",
                          @"I",
                          @"J",
                          nil];
    
    for (int isrt = 1; isrt <=10; isrt++) {
        
        UIImageView *UiimageView = [[UIImageView alloc] init];
        [UiimageView setBackgroundColor:[UIColor clearColor]];
        [UiimageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",isrt]]];
        [self.MainBgScrollview addSubview:UiimageView];
        
        UILabel *UserMenuLabel = [[UILabel alloc] init];
        [UserMenuLabel setBackgroundColor:[UIColor clearColor]];
        [UserMenuLabel setTextColor:[UIColor colorFromHex:0xa3a3a3]];
        [UserMenuLabel setText:[TextArray objectAtIndex:isrt]];
        [UserMenuLabel setTextAlignment:NSTextAlignmentCenter];
        [UserMenuLabel setFont:[UIFont fontWithName:@"Georgia" size:12.0f]];
        [self.MainBgScrollview addSubview:UserMenuLabel];
        
        UIButton *MenuButton = [[UIButton alloc] init];
        [MenuButton setBackgroundColor:[UIColor clearColor]];
        [MenuButton addTarget:self action:@selector(MenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [MenuButton setTag:1000+isrt];
        [self.MainBgScrollview addSubview:MenuButton];
        
        switch (isrt) {
            case 1:
                [UiimageView setFrame:CGRectMake(55, 45, 24,28)];
                [UserMenuLabel setFrame:CGRectMake(0, 80, 133,15)];
                [MenuButton setFrame:CGRectMake(0, 0, 133, 112)];
                break;
            case 2:
                [UiimageView setFrame:CGRectMake(185, 45, 27,30)];
                [UserMenuLabel setFrame:CGRectMake(134, 80, 133,15)];
                [MenuButton setFrame:CGRectMake(135, 0, 133, 112)];
                break;
            case 3:
                [UiimageView setFrame:CGRectMake(55, 150, 34,34)];
                [UserMenuLabel setFrame:CGRectMake(0, 185, 133,15)];
                [MenuButton setFrame:CGRectMake(0, 114, 133, 111)];
                break;
            case 4:
                [UiimageView setFrame:CGRectMake(185, 155, 25.5,23)];
                [UserMenuLabel setFrame:CGRectMake(134, 185, 133,15)];
                [MenuButton setFrame:CGRectMake(135, 114, 133, 111)];
                break;
            case 5:
                [UiimageView setFrame:CGRectMake(55, 260, 34,34)];
                [UserMenuLabel setFrame:CGRectMake(0, 295, 133,15)];
                [MenuButton setFrame:CGRectMake(0, 227, 133, 111)];
                break;
            case 6:
                [UiimageView setFrame:CGRectMake(185, 265, 29,22)];
                [UserMenuLabel setFrame:CGRectMake(134, 295, 133,15)];
                [MenuButton setFrame:CGRectMake(135, 227, 133, 111)];
                break;
            case 7:
                [UiimageView setFrame:CGRectMake(45, 370, 44,36)];
                [UserMenuLabel setFrame:CGRectMake(0, 410, 133,15)];
                [MenuButton setFrame:CGRectMake(0, 340, 133, 111)];
                break;
            case 8:
                [UiimageView setFrame:CGRectMake(185, 375, 20.5,27)];
                [UserMenuLabel setFrame:CGRectMake(130, 410, 133,15)];
                [MenuButton setFrame:CGRectMake(135, 340, 133, 111)];
                break;
            case 9:
                [UiimageView setFrame:CGRectMake(45, 475, 44,44)];
                [UserMenuLabel setFrame:CGRectMake(5, 515, 133,15)];
                [MenuButton setFrame:CGRectMake(0, 453, 133, 113)];
                break;
            case 10:
                [UiimageView setFrame:CGRectMake(185, 480, 32,32)];
                [UserMenuLabel setFrame:CGRectMake(134, 515, 133,15)];
                [MenuButton setFrame:CGRectMake(135, 453, 133, 113)];
                break;
        }
        
    }
}
-(IBAction)MenuButtonPressed:(UIButton *)sender
{
    
}
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
