//
//  MyaccounttwoViewController.m
//  Kalastaa
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "MyaccounttwoViewController.h"
#import "UIColor+HexColor.h"

@interface MyaccounttwoViewController ()
@end

@implementation MyaccounttwoViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"MyaccounttwoViewController" bundle:nil]:[super initWithNibName:@"MyaccounttwoViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.navigationController navigationBar] setHidden:YES];
    
    UIView *HeaderView = (UIView *)[self.view viewWithTag:110];
    [HeaderView setBackgroundColor:[UIColor colorFromHex:0x1EBBFE]];
    
    UILabel *Titlelabel = (UILabel *)[self.view viewWithTag:888];
    [Titlelabel setText:@"Menu Two"];
    [Titlelabel setTextColor:[UIColor whiteColor]];
    [Titlelabel setFont:[UIFont fontWithName:@"Helvetica" size:18.0f]];
    
    UIButton *SetButton = (UIButton *)[self.view viewWithTag:111];
    [SetButton addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}
-(IBAction)RightSideMenuButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
