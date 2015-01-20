//
//  UILabel+Presentation.h
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Presentation)

+ (UILabel *)UILabelWithFrame:(CGRect)frame
                               Withfont:(NSString *)font
                               WithColor:(UIColor *)Color
                               WithFontSize:(float)FontSize
                               WithText:(NSString *)Text;
@end
