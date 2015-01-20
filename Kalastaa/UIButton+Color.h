//
//  UIButton+Color.h
//  CampOs
//
//  Created by Mac on 30/07/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Color)

+(UIButton *)UIRedButtonWithFrame:(CGRect)frame
                  WithButtonText:(NSString *)ButtonText;
+(UIButton *)UIBlueButtonWithFrame:(CGRect)frame
                  WithButtonText:(NSString *)ButtonText;
+(UIButton *)UIWhiteButtonWithFrame:(CGRect)frame
                  WithButtonText:(NSString *)ButtonText;
+(UIButton *)UIYellowButtonWithFrame:(CGRect)frame
                  WithButtonText:(NSString *)ButtonText;
@end
