//
//  UITextField+Extaintation.m
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "UITextField+Extaintation.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UITextField (Extaintation)

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               font:(UIFont *)font WithPlaceholder:(NSString *)Placeholder IsSecure:(BOOL)isSecure{
    return [UITextField textFieldWithFrame:frame font:font padding:8.0f WithPlaceholder:Placeholder IsSecure:isSecure WithImageName:@""];
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               font:(UIFont *)font
                            padding:(CGFloat)padding
                    WithPlaceholder:(NSString *)Placeholder
                           IsSecure:(BOOL)isSecure
                    WithImageName:(NSString *)ImageName {
    
    UITextField *UserEmailTextField = [[UITextField alloc] initWithFrame:frame];
    [UserEmailTextField.layer setBorderWidth:1.0f];
    [UserEmailTextField.layer setCornerRadius:3.0f];
    [UserEmailTextField.layer setBorderColor:UIColorFromRGB(0xd9d9d9).CGColor];
    [UserEmailTextField setPlaceholder:Placeholder];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:Placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    UserEmailTextField.attributedPlaceholder = str;
    [UserEmailTextField setTextColor:[UIColor darkGrayColor]];
    [UserEmailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [UserEmailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [UserEmailTextField setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    
    if (isSecure) {
        [UserEmailTextField setSecureTextEntry:YES];
    }
    
    UIView *paddingView             = [self AddPaddingViewWithTextField:UserEmailTextField];
    UIImageView *TextFiledLeftImage = [self AssignImageInLeftViewWithView:paddingView WithImageName:ImageName];
    
    [UserEmailTextField addSubview:TextFiledLeftImage];
    return UserEmailTextField;
    
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               font:(UIFont *)font
                            padding:(CGFloat)padding
                    WithPlaceholder:(NSString *)Placeholder
                           IsSecure:(BOOL)isSecure {
    
    UITextField *UserEmailTextField = [[UITextField alloc] initWithFrame:frame];
    [UserEmailTextField.layer setBorderWidth:1.0f];
    [UserEmailTextField.layer setCornerRadius:3.0f];
    [UserEmailTextField.layer setBorderColor:UIColorFromRGB(0xd9d9d9).CGColor];
    [UserEmailTextField setPlaceholder:Placeholder];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:Placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    UserEmailTextField.attributedPlaceholder = str;
    [UserEmailTextField setTextColor:[UIColor darkGrayColor]];
    [UserEmailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [UserEmailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [UserEmailTextField setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    
    if (isSecure) {
        [UserEmailTextField setSecureTextEntry:YES];
    }
    
    UIView *paddingView             = [self PostAddPaddingViewWithTextField:UserEmailTextField];
    UILabel *TextFiledLeftImage = [self PostAssignImageInLeftViewWithView:paddingView];
    
    [UserEmailTextField addSubview:TextFiledLeftImage];
    return UserEmailTextField;
    
}
+(UIView *)PostAddPaddingViewWithTextField:(UITextField *)UITextField
{
    UIView *paddingView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UITextField.layer.frame.size.height-10, UITextField.layer.frame.size.height)];
    UITextField.leftView        = paddingView;
    UITextField.leftViewMode    = UITextFieldViewModeAlways;
    return paddingView;
}
+(UIView *)AddPaddingViewWithTextField:(UITextField *)UITextField
{
    UIView *paddingView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UITextField.layer.frame.size.height+10, UITextField.layer.frame.size.height)];
    UITextField.leftView        = paddingView;
    UITextField.leftViewMode    = UITextFieldViewModeAlways;
    return paddingView;
}

+(UIImageView *)AssignImageInLeftViewWithView:(UIView *)paddingView WithImageName:(NSString *)ImageName
{
    UIImageView *TextFiledLeftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 36, 36)];
    [TextFiledLeftImage setBackgroundColor:[UIColor clearColor]];
    [TextFiledLeftImage setImage:[UIImage imageNamed:ImageName]];
    return TextFiledLeftImage;
}
+(UILabel *)PostAssignImageInLeftViewWithView:(UIView *)paddingView
{
    UILabel *TextFiledLeftImage = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 5, 1)];
    [TextFiledLeftImage setBackgroundColor:[UIColor lightGrayColor]];
    return TextFiledLeftImage;
}
+ (UITextField *)textFieldWithFrame:(CGRect)frame font:(UIFont *)font WithPlaceholder:(NSString *)Placeholder IsSecure:(BOOL)isSecure fontsize:(float)Fontsize padding:(float)padding borderwidth:(float)borderwidth bordercolor:(UIColor *)bordercolor cornerredious:(float)cornerredious
{
    UITextField *UserEmailTextField = [[UITextField alloc] initWithFrame:frame];
    [UserEmailTextField.layer setBorderWidth:borderwidth];
    [UserEmailTextField.layer setCornerRadius:cornerredious];
    [UserEmailTextField.layer setBorderColor:bordercolor.CGColor];
    [UserEmailTextField setPlaceholder:Placeholder];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:Placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    UserEmailTextField.attributedPlaceholder = str;
    [UserEmailTextField setTextColor:[UIColor darkGrayColor]];
    [UserEmailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [UserEmailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [UserEmailTextField setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    
    if (isSecure) {
        [UserEmailTextField setSecureTextEntry:YES];
    }
    
    UIView *paddingView             = [self PostAddPaddingViewWithTextField:UserEmailTextField];
    UILabel *TextFiledLeftImage     = [self PostAssignImageInLeftViewWithView:paddingView];
    
    [UserEmailTextField addSubview:TextFiledLeftImage];
    return UserEmailTextField;
}
@end
