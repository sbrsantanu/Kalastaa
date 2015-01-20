//
//  UITextView+UIPlaceHolderTextView.h
//  CampOs
//
//  Created by Mac on 14/08/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
