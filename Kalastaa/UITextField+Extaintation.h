//
//  UITextField+Extaintation.h
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extaintation)

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               font:(UIFont *)font WithPlaceholder:(NSString *)Placeholder IsSecure:(BOOL)isSecure;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               font:(UIFont *)font
                            padding:(CGFloat)padding
                            WithPlaceholder:(NSString *)Placeholder
                           IsSecure:(BOOL)isSecure
                      WithImageName:(NSString *)ImageName;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                                   font:(UIFont *)font
                                padding:(CGFloat)padding
                        WithPlaceholder:(NSString *)Placeholder
                               IsSecure:(BOOL)isSecure;

+ (UITextField *)textFieldWithFrame:(CGRect)frame font:(UIFont *)font WithPlaceholder:(NSString *)Placeholder IsSecure:(BOOL)isSecure fontsize:(float)Fontsize padding:(float)padding borderwidth:(float)borderwidth bordercolor:(UIColor *)bordercolor cornerredious:(float)cornerredious;
@end
