//
//  UIButton+Color.m
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "UIButton+Color.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIButton (Color)

+(UIButton *)UIRedButtonWithFrame:(CGRect)frame
                   WithButtonText:(NSString *)ButtonText
{
    UIButton *YellowButton = [self UIButtonWithFrame:frame WithButtonText:ButtonText WithButtonColor:UIColorFromRGB(0xfa4a2f)];
    return YellowButton;
}
+(UIButton *)UIBlueButtonWithFrame:(CGRect)frame
                    WithButtonText:(NSString *)ButtonText
{
    UIButton *YellowButton = [self UIButtonWithFrame:frame WithButtonText:ButtonText WithButtonColor:UIColorFromRGB(0x20a2e3)];
    return YellowButton;
}
+(UIButton *)UIWhiteButtonWithFrame:(CGRect)frame
                     WithButtonText:(NSString *)ButtonText
{
    UIButton *YellowButton = [self UIButtonWithFrame:frame WithButtonText:ButtonText WithButtonColor:UIColorFromRGB(0xffffff)];
    return YellowButton;
}
+(UIButton *)UIYellowButtonWithFrame:(CGRect)frame
                      WithButtonText:(NSString *)ButtonText
{
    UIButton *YellowButton = [self UIButtonWithFrame:frame WithButtonText:ButtonText WithButtonColor:UIColorFromRGB(0xffc229)];
    return YellowButton;
}

+(UIButton *)UIButtonWithFrame:(CGRect)frame
                  WithButtonText:(NSString *)ButtonText WithButtonColor:(UIColor *)ButtonColor
{
    UIButton *Mybutton = [[UIButton alloc] initWithFrame:frame];
    [Mybutton setBackgroundColor:ButtonColor];
    [Mybutton.layer setBorderColor:ButtonColor.CGColor];
    [Mybutton.layer setBorderWidth:1.0f];
    [Mybutton setTitle:ButtonText forState:UIControlStateNormal];
    [Mybutton setTitle:ButtonText forState:UIControlStateSelected];
    [Mybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Mybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [Mybutton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    return Mybutton;
}
@end
