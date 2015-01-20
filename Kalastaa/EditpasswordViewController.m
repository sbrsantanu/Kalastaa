//
//  EditpasswordViewController.m
//  Kalastaa
//
//  Created by Mac on 18/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import "EditpasswordViewController.h"

@interface EditpasswordViewController ()

@end

@implementation EditpasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"EditpasswordViewController" bundle:nil]:[super initWithNibName:@"EditpasswordViewController4s" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
