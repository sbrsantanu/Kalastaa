//
//  UIView+Alertmessage.m
//  CampOs
//
//  Created by Mac on 07/08/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "UIView+Alertmessage.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIView (Alertmessage)

@dynamic ViewBackgroundColor;
@dynamic ViewHeight;

-(void)ShowProgressViewWithMessage:(NSString *)MessageBody
{

    UIView *NotifyView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-60.0f, self.frame.size.width, self.frame.size.height)];
    [NotifyView setBackgroundColor:UIColorFromRGB(0x20a2e3)];
    [self addSubview:NotifyView];
    
    UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 320, 20)];
    [TextLabel setBackgroundColor:[UIColor clearColor]];
    [TextLabel setTextColor:[UIColor whiteColor]];
    [TextLabel setTextAlignment:NSTextAlignmentLeft];
    [TextLabel setFont:[UIFont fontWithName:@"Oswald-Regular" size:14.0f]];
    [TextLabel setText:MessageBody];
    [NotifyView addSubview:TextLabel];
    
    float widthIs =
    [TextLabel.text
     boundingRectWithSize:TextLabel.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:TextLabel.font }
     context:nil]
    .size.width;
    
    NSLog(@"widthIs ---%f",widthIs);
    
    ActivityIndicatorView *aiv = [[ActivityIndicatorView alloc] initWithFrame:CGRectMake(widthIs+25, 33.0f, 200, 20)];
    aiv.animationDuration = 1.0f;
    aiv.dotColor = UIColorFromRGB(0xde1d23);
    [aiv startAnimating];
    [NotifyView addSubview:aiv];
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        NotifyView.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)ShowSuccessMessageWithMessage:(NSString *)MessageBody
{
    UIView *NotifyView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-60.0f, self.frame.size.width, self.frame.size.height)];
    [NotifyView setBackgroundColor:UIColorFromRGB(0x409744)];
    [self addSubview:NotifyView];
    
    UIImageView *ImageViewSuccess = [[UIImageView alloc] initWithFrame:CGRectMake(20, 23, 25, 25)];
    [ImageViewSuccess setImage:[UIImage imageNamed:@"success_green"]];
    [ImageViewSuccess setBackgroundColor:[UIColor clearColor]];
    [NotifyView addSubview:ImageViewSuccess];
    
    UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 320, 20)];
    [TextLabel setBackgroundColor:[UIColor clearColor]];
    [TextLabel setTextColor:[UIColor whiteColor]];
    [TextLabel setTextAlignment:NSTextAlignmentLeft];
    [TextLabel setFont:[UIFont fontWithName:@"Oswald-Regular" size:14.0f]];
    [TextLabel setText:MessageBody];
    [NotifyView addSubview:TextLabel];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        NotifyView.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)ShowErrorMessageWithMessage:(NSString *)MessageBody
{
    UIView *NotifyView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-60.0f, self.frame.size.width, self.frame.size.height)];
    [NotifyView setBackgroundColor:UIColorFromRGB(0xd9201a)];
    [self addSubview:NotifyView];
    
    UIImageView *ImageViewSuccess = [[UIImageView alloc] initWithFrame:CGRectMake(20, 23, 25, 25)];
    [ImageViewSuccess setImage:[UIImage imageNamed:@"error_red"]];
    [ImageViewSuccess setBackgroundColor:[UIColor clearColor]];
    [NotifyView addSubview:ImageViewSuccess];
    
    UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 320, 20)];
    [TextLabel setBackgroundColor:[UIColor clearColor]];
    [TextLabel setTextColor:[UIColor whiteColor]];
    [TextLabel setTextAlignment:NSTextAlignmentLeft];
    [TextLabel setFont:[UIFont fontWithName:@"Oswald-Regular" size:14.0f]];
    [TextLabel setText:MessageBody];
    [NotifyView addSubview:TextLabel];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        NotifyView.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)ShowWarningMessageWithMessage:(NSString *)MessageBody
{
    UIView *NotifyView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-60.0f, self.frame.size.width, self.frame.size.height)];
    [NotifyView setBackgroundColor:UIColorFromRGB(0xeb8028)];
    [self addSubview:NotifyView];
    
    UIImageView *ImageViewSuccess = [[UIImageView alloc] initWithFrame:CGRectMake(20, 23, 25, 25)];
    [ImageViewSuccess setImage:[UIImage imageNamed:@"alert_icon"]];
    [ImageViewSuccess setBackgroundColor:[UIColor clearColor]];
    [NotifyView addSubview:ImageViewSuccess];
    
    UILabel *TextLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 28, 320, 20)];
    [TextLabel setBackgroundColor:[UIColor clearColor]];
    [TextLabel setTextColor:[UIColor whiteColor]];
    [TextLabel setTextAlignment:NSTextAlignmentLeft];
    [TextLabel setFont:[UIFont fontWithName:@"Oswald-Regular" size:14.0f]];
    [TextLabel setText:MessageBody];
    [NotifyView addSubview:TextLabel];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        NotifyView.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)HideMessageBoxWithView:(UIView *)NotificationView
{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y-60, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
@end

#define kActivityIndicatorDotNumber 3

@interface ActivityIndicatorView ()
{
    BOOL _isAnimating;
    
    //for calculate key frame value
    CGFloat _v0;
    CGFloat _v1;
    CGFloat _t0;
    CGFloat _t1;
    CGFloat _t2;
    CGFloat _a0;
    CGFloat _a1;
}

@property (nonatomic, retain) NSArray *keyframeValues;

@end


@implementation ActivityIndicatorView

@synthesize dotColor = _dotColor;
@synthesize keyframeValues = _keyframeValues;

@synthesize animationDuration = _animationDuration;
@synthesize ratioOfMaxAndMinVelocity = _ratioOfMaxAndMinVelocity;
@synthesize accelerateDistance = _accelerateDistance;
@synthesize decelerateDistance = _decelerateDistance;
@synthesize repeatInterval = _repeatInterval;
@synthesize dotInterval = _dotInterval;
@synthesize dotCount = _dotCount;
@synthesize repeated = _repeated;

- (void)dealloc
{
    _dotColor = nil;
    _keyframeValues = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //set default color
        self.backgroundColor            = [UIColor clearColor];
        self.dotColor                   = [UIColor redColor];
        self.dotCount                   = 4;
        self.ratioOfMaxAndMinVelocity   = 10;
        self.accelerateDistance         = 3./8;
        self.decelerateDistance         = 3./8;
        self.repeatInterval             = 0.5f;
        self.dotInterval                = 0.1f;
        self.animationDuration          = 1.0f;
        self.repeated                   = YES;
        
    }
    return self;
}


#pragma mark - public method

- (void)startAnimating
{
    if (_isAnimating)
        return;
    
    
    self.keyframeValues = [self values];
    
    [self initLayers];
    
    _isAnimating = YES;
    [self startAnimatingTransaction];
}


- (void)startAnimatingTransaction
{
    [CATransaction begin];
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    for (int i = 0; i < self.layer.sublayers.count; i++)
    {
        CALayer *layer = [self.layer.sublayers objectAtIndex:i];
        
        CAKeyframeAnimation *dotMoveKA = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        [dotMoveKA setValues:self.keyframeValues];
        [dotMoveKA setDuration:self.animationDuration];
        [dotMoveKA setBeginTime:currentTime + i * self.dotInterval];
        
        if (layer == [self.layer.sublayers lastObject])
        {
            [dotMoveKA setDelegate:self];
        }
        
        [layer addAnimation:dotMoveKA forKey:nil];
    }
    
    [CATransaction commit];
}

- (void)stopAnimating
{
    //    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self removeDots];
    _isAnimating = NO;
}

- (void)stopAnimatingNeedDelay:(NSTimeInterval)time
{
    if (time == kMTActivityIndicatorViewCycle)
        _isAnimating = NO;
    else
    {
        [self performSelector:@selector(removeDots) withObject:nil afterDelay:time];
        _isAnimating = NO;
    }
}

- (BOOL)isAnimating
{
    return _isAnimating;
}


#pragma mark - private method

- (void)initLayers
{
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    for (int i = 0; i < kActivityIndicatorDotNumber; i++)
    {
        CALayer *dotLayer = [CALayer layer];
        dotLayer.frame = CGRectMake(-2.0f, 5.0f, 3.0f, 3.0f);
        dotLayer.backgroundColor = UIColorFromRGB(0xffffff).CGColor;
        
        [self.layer addSublayer:dotLayer];
    }
}

- (void)removeDots
{
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (NSArray *)values
{
    [self evalBasic];
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger length = self.animationDuration / 0.1 + 1;
    for (int i = 0; i < length; i++)
    {
        CGFloat value = [self eval:i*0.1];
        [array addObject:[NSNumber numberWithFloat:value]];
    }
    
    return array;
}


#pragma mark - animation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_isAnimating)
    {
        [self performSelector:@selector(startAnimatingTransaction) withObject:nil afterDelay:self.repeatInterval];
    }
}


/*
 
 //start speed, can be modified
 #define v0 200.0f
 //second speed, cannot be modified
 #define v1 (220.0f - v0)
 //uniform velocity distance
 #define sd 80.0
 //acceleration
 #define a (sTotal - 2 * v0 -sd)
 
 - (CGFloat)eval:(CGFloat)time
 {
 CGFloat sTotal = self.frame.size.width;
 
 if (time < 1)
 {
 return v0 * time + 0.5 * a * time * time;
 }
 else if (time < 1 + sd/v1)
 {
 return (sTotal - sd) * 0.5 + v1 * (time - 1);
 }
 else if (time < 2 + sd/v1)
 {
 return (sTotal + sd ) * 0.5 + v1 * (time - 1 - sd/v1) - 0.5 * a * (time - 1 - sd/v1) * (time - 1 - sd/v1);
 }
 else
 {
 return sTotal + 2.0f;
 }
 }
 
 */

- (CGFloat)eval:(CGFloat)time
{
    if (time < _t0)
    {
        return _v0 * time + 0.5 * _a0 * time * time;
    }
    else if (time < _t1)
    {
        return _v0 * _t0 + 0.5 * _a0 * _t0 * _t0 + _v1 * (time - _t0);
    }
    else if (time < _t2)
    {
        return _v0 * _t0 + 0.5 * _a0 * _t0 * _t0 + _v1 * (_t1 - _t0) + _v1 * (time - _t1) + 0.5 * _a1 * (time - _t1) * (time - _t1);
    }
    else
    {
        return self.frame.size.width + 2;
    }
}


- (void)evalBasic
{
    
    //V1 = (2Ka*S + 2Kd*S + (1 - Ka - Kd)*S*(K + 1))/((K + 1)*Tt)
    
    CGFloat s = self.frame.size.width;
    CGFloat k = self.ratioOfMaxAndMinVelocity;
    CGFloat t = self.animationDuration;
    CGFloat ka = self.accelerateDistance;
    CGFloat kd = self.accelerateDistance;
    
    _v1 = (2*ka*s + 2*kd*s + (1 - ka - kd)*s*(k + 1))/((k + 1)*t);
    _v0 = k * _v1;
    _t0 = 2 * ka * s / ((k + 1) * _v1);
    _t1 = _t0 + (1 - ka - kd) * s / _v1;
    _t2 = _t1 + 2 * kd * s / ((k + 1) * _v1);
    _a0 = (1 - k) * _v1 / _t0;
    _a1 = (k - 1) * _v1 / (_t2 - _t1);
}

@end
