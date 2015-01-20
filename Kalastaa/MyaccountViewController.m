//
//  MyaccountViewController.m
//  Kalastaa
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "MyaccountViewController.h"
#import "UIColor+HexColor.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>

@interface MyaccountViewController ()

@end

@implementation MyaccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"MyaccountViewController" bundle:nil]:[super initWithNibName:@"MyaccountViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.navigationController navigationBar] setHidden:YES];
    
    UIView *HeaderView = (UIView *)[self.view viewWithTag:110];
    [HeaderView setBackgroundColor:[UIColor colorFromHex:0x1EBBFE]];
    
    UILabel *Titlelabel = (UILabel *)[self.view viewWithTag:888];
    [Titlelabel setText:@"Menu One"];
    [Titlelabel setTextColor:[UIColor whiteColor]];
    [Titlelabel setFont:[UIFont fontWithName:@"Helvetica" size:18.0f]];
    
    UIButton *SetButton = (UIButton *)[self.view viewWithTag:112];
    [SetButton addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)leftSideMenuButtonPressed:(id)sender {
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}

@end
