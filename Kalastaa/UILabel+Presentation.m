//
//  UILabel+Presentation.m
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "UILabel+Presentation.h"

@implementation UILabel (Presentation)

+ (UILabel *)UILabelWithFrame:(CGRect)frame
                     Withfont:(NSString *)font
                     WithColor:(UIColor *)Color
                     WithFontSize:(float)FontSize
                     WithText:(NSString *)Text
{
    UIFont * customFont = [UIFont fontWithName:font size:FontSize];
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:frame];
    fromLabel.text = Text;
    fromLabel.font = customFont;
    fromLabel.numberOfLines = 0;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = Color;
    fromLabel.textAlignment = NSTextAlignmentLeft;
    return fromLabel;
}
@end
