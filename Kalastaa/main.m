//
//  main.m
//  Kalastaa
//
//  Created by Mac on 11/12/14.
//  Copyright (c) 2014 Kalastaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define FACEBOOKAPPID @"514676771996100"
#define GraphAPI @"https://graph.facebook.com/"
#define GraphAPIFACEBOOK @"https://graph.facebook.com/"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ShowAlert(myTitle, myMessage) [[[UIAlertView alloc] initWithTitle:myTitle message:myMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define  IsIphone5 (([[UIScreen mainScreen] bounds].size.height)>500)?true:false

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
