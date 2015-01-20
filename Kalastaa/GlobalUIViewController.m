//
//  COGlobalUIViewController.m
//  CampOs
//
//  Created by Mac on 08/08/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

#import "GlobalUIViewController.h"
#import "AFNetworking.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import "AFJSONRequestOperation.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface COGlobalUIViewController ()
{
    UIImage *image;
    UIImageView *loadingView;
}
@property(nonatomic, copy) NSArray *viewControllers;
@end

@implementation COGlobalUIViewController


-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName {
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.type = kCATransitionFade;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:ViewControllerName animated:NO];
    
}
- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}
#pragma mark Spin Button
-(NSString *)CleanTextField:(NSString *)TextfieldName
{
    NSString *Cleanvalue = [TextfieldName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return Cleanvalue;
}
- (void)startSpin
{
    if (!loadingView) {
        
        loadingView = [[UIImageView alloc] initWithFrame:CGRectMake(140, self.view.frame.size.height-130, 26, 26)];
        loadingView.image = [UIImage imageNamed:@"282.png"];
        [self.view addSubview:loadingView];
        
    }
    
    loadingView.hidden = NO;
    [CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [loadingView frame];
	loadingView.layer.anchorPoint = CGPointMake(0.5, 0.5);
	loadingView.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.speed = 3.0f;
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[loadingView.layer addAnimation:animation forKey:@"rotationAnimation"];
	[CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self startSpin];
	}
}

- (void)stopSpin
{
    [loadingView.layer removeAllAnimations];
    loadingView.hidden = YES;
}
-(void)SetupHeaderViewWithView:(UIView *)mainview withBackButton:(BOOL)BackButton withTitle:(NSString *)Title
{
    UIView *HeaderImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [HeaderImage setBackgroundColor:[UIColor whiteColor]];
    [mainview addSubview:HeaderImage];
    
    UIView *BlackColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [BlackColorView setBackgroundColor:UIColorFromRGB(0x00c4ad)];
    [HeaderImage addSubview:BlackColorView];
    
    UILabel *LogoImage = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 320-82, 40)];
    [LogoImage setBackgroundColor:[UIColor clearColor]];
    [LogoImage setTextColor:[UIColor whiteColor]];
    [LogoImage setText:Title];
    [LogoImage setTextAlignment:NSTextAlignmentCenter];
    [LogoImage setFont:[UIFont fontWithName:StaticStrings.GlobalNormalFont size:25.0]];
    [HeaderImage addSubview:LogoImage];
    
    if (BackButton) {
        /*
         Set image for backview
         */
        
        UIImageView *Imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 22, 22)];
        [Imageview setImage:[UIImage imageNamed:@"backonename.png"]];
        [HeaderImage addSubview:Imageview];
        
        /*
         Go to Login Button
         */
        
        UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [BackButton setBackgroundColor:[UIColor clearColor]];
        [HeaderImage addSubview:BackButton];
        
        [BackButton addTarget:self action:@selector(goToBack:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(IBAction)goToBack:(id)sender
{
    @try {
        
        [self.navigationController popViewControllerAnimated:NO];
        
    } @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
}
-(void)ShowLoadingviewWithMessage:(NSString *)UIMessage
{
    self.NotifyView = [[UIView alloc] initWithFrame:CGRectMake(LoaderViewPositionX, LoaderViewPositionY, LoaderViewWidth, LoaderViewHeight)];
    self.GlobalAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.NotifyView ShowProgressViewWithMessage:UIMessage];
    [self.GlobalAppDelegate.window addSubview:self.NotifyView];
}
-(void)ShowSuccessviewWithMessage:(NSString *)UIMessage
{
    if(self.NotifyView!=nil) {
        [self HideLoadingView];
    } else {
        self.NotifyView = [[UIView alloc] initWithFrame:CGRectMake(LoaderViewPositionX, LoaderViewPositionY, LoaderViewWidth, LoaderViewHeight)];
        self.GlobalAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self.NotifyView ShowSuccessMessageWithMessage:UIMessage];
        [self.GlobalAppDelegate.window addSubview:self.NotifyView];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self HideLoadingView];
        });
    }
}
-(void)ShowErrorviewWithMessage:(NSString *)UIMessage
{
    if(self.NotifyView!=nil) {
        [self HideLoadingView];
    } else {
        self.NotifyView = [[UIView alloc] initWithFrame:CGRectMake(LoaderViewPositionX, LoaderViewPositionY, LoaderViewWidth, LoaderViewHeight)];
        self.GlobalAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self.NotifyView ShowErrorMessageWithMessage:UIMessage];
        [self.GlobalAppDelegate.window addSubview:self.NotifyView];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self HideLoadingView];
        });
    }
}
-(void)ShowAllFonts {
    // List all fonts on iPhone
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"   Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}
-(void)ShowWarningviewWithMessage:(NSString *)UIMessage
{
    if(self.NotifyView!=nil) {
        [self HideLoadingView];
    } else {
        self.NotifyView = [[UIView alloc] initWithFrame:CGRectMake(LoaderViewPositionX, LoaderViewPositionY, LoaderViewWidth, LoaderViewHeight)];
        self.GlobalAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [self.NotifyView ShowWarningMessageWithMessage:UIMessage];
        [self.GlobalAppDelegate.window addSubview:self.NotifyView];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self HideLoadingView];
        });
    }
}
-(void)HideLoadingView
{
    [self.NotifyView HideMessageBoxWithView:self.NotifyView];
    self.NotifyView = nil;
}
-(void)AllTextfieldResignFirstResponderWithview:(UIView *)ResponderView
{
    for (UIView *Subviews in [ResponderView subviews]) {
        if([Subviews isKindOfClass:[UITextField class]])
        {
            [((UITextField*)Subviews) resignFirstResponder];
        }
    }
}

-(NSDictionary *)executeFetch:(NSString *)query
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    return results;
}

-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray {
    @try {
        
        NSMutableDictionary *ParamDictionary = [[NSMutableDictionary alloc] initWithCapacity:FieldArray.count];
        if (ParamArray.count > 0) {
            if(FieldArray.count >0) {
                for (int i = 0; i<ParamArray.count; i++) {
                    [ParamDictionary setObject:[FieldArray objectAtIndex:i] forKey:[ParamArray objectAtIndex:i]];
                }
            } else {
                NSLog(@"Field data is blank");
            }
        } else {
            NSLog(@"Param object is blank");
        }
        return ParamDictionary;
    }
    @catch (NSException *Exception) {
        NSLog(@"Err in ParamDictionary %@",Exception);
    }
}

-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType
{
    
    NSMutableString *URLstring = [[NSMutableString alloc]init];
    
    int i=0;
    for (id key in TotalData) {
        
        i++;
        id anObject = [TotalData objectForKey:key];
        if(i==TotalData.count)
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        else
            [URLstring appendString:[NSString stringWithFormat:@"%@=%@&",key,[[self CleanTextField:anObject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    NSString *FinalString = [NSString stringWithFormat:@"%@%@?%@",StaticStrings.UrlGlobalSite,UrlType,URLstring];
    return FinalString;
    
}


-(BOOL)isConnectedToInternet {
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    
    if (reachability) {
        SCNetworkReachabilityFlags flags;
        BOOL worked = SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
        
        if (worked) {
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                return YES;
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                return YES;
            }
        }
        
    }
    return NO;
}
@end

@implementation StaticStrings

+(NSString *)BlankEmailError { return BlankEmailString; }
+(NSString *)BlankNameError { return BlankNameString; }
//+(NSString *)BlankUsernameError { return BlankUsernameString; }
+(NSString *)BlankSchoolError { return BlankSchoolString; }
//+(NSString *)BlankPasswordError { return BlankPasswordString; }
+(NSString *)BlankRetypePasswordError { return BlankRetypePasswordString; }
+(NSString *)BlankPhoneNumberError { return BlankPhoneNumberString; }
+(NSString *)EmailValidationError { return EmailValidationString; }
+(NSString *)UsernameValidationError { return UsernameValidationString; }
+(NSString *)PasswordmatchError { return PasswordmatchString; }
+(NSString *)PhoneValidationError { return PhoneValidationString; }
+(NSString *)PasswordLengthError { return PasswordLengthString; }
+(NSString *)UrlGlobalSite { return GlobalUrlString; }
+(NSString *)URLParameterString { return URLParameterString; }
+(NSString *)WebserviceMessageString { return WSReturnedMessageparam;}
+(NSString *)WebserviceErrorCodeString { return WSReturnederrorcodeparam;}
+(NSString *)Webservicesuccesscode { return WSSuccessCode;}
+(NSString *)WebserviceErrorCode { return WsErrorCode;}


/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Parameter Details Starts ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 @ParametersOfRegistration returns the parameterized string for Registration
 */
+(NSString *)ParametersOfRegistration { return ParamRegister; }

/*
 @ParametersOfLogin returns the parameterized string for Login
 */
+(NSString *)ParametersOfLogin  { return ParamLogin; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUserdetails  { return ParamUserdetails; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfChangePassword  { return ParamChangePassword; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfForgetPassword  { return ParamForgetPassword; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUpdateUser  { return ParamUpdateUser; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfAddVideo  { return ParamAddVideo; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUpdateVideo  { return ParamUpdateVideo; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfDeleteVideo  { return ParamDeleteVideo; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfAllUsersVideos  { return ParamAllUsersVideos; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfGetYourVideos  { return ParamGetYourVideos; }

/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfGetVideoDetails  { return ParamGetVideoDetails; }

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Parameter Details End ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 --------------------------------------------------------------------------------------------
 ************************* Global Strings Declearation start ******************************
 --------------------------------------------------------------------------------------------
 */

+(NSString *)ErrorBlankUsername { return ErrorBlankUsername; }
+(NSString *)ErrorBlankPassword { return ErrorBlankpassword; }
/*
 --------------------------------------------------------------------------------------------
 ************************* Global Strings Declearation end ******************************
 --------------------------------------------------------------------------------------------
 */

+(NSString *)WSReturnSuccessString { return WSReturnSuccess; }
+(NSString *)WSReturnErrorString  { return WSReturnError; }
+(NSString *)WSStatusStringString  { return WSStatusString; }
+(NSString *)WSMessageString { return WSMessageString; }
+(NSString *)WSInvaliedString { return WSInvaliedString; }

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Methods Details Starts ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 @WebserviceforRegistration returns the webservice string for Registration
 */
+(NSString *)WebserviceforRegistration  { return ServiceMethodRegister; }

/*
 @WebserviceforLogin returns the webservice string for Login
 */
+(NSString *)WebserviceforLogin  { return ServiceMethodLogin; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUserdetails  { return ServiceMethodUserdetails; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforChangePassword  { return ServiceMethodchangePassword; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforForgetPassword  { return ServiceMethodforgetPassword; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUpdateUser  { return ServiceMethodupdateUser; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforAddVideo  { return ServiceMethodaddVideo; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUpdateVideo  { return ServiceMethodupdateVideo; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforDeleteVideo  { return ServiceMethoddeleteVideo; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforAllUsersVideos  { return ServiceMethodgetAllUsersVideos; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforGetYourVideos  { return ServiceMethodgetYourVideos; }

/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforGetVideoDetails  { return ServiceMethodgetVideo; }

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Method Details end ******************************
 --------------------------------------------------------------------------------------------
 */


/*
 All Fonts
 */
+(NSString *)GlobalNormalFont { return @"Oswald";}
+(NSString *)GlobalRegulerFont { return @"Oswald-Regular";}
+(NSString *)GlobalLightFont { return @"Oswald-Light";}
+(NSString *)GlobalBoldFont { return @"Oswald-Bold";}

@end

/*
 * handelURLConnection cless is made for handle url connection using the delegate method.
 * handelURLConnection class will esposible for fetch data and will send local notification to the
 * parent class from where this class is accessing
 *
 */

@implementation handelURLConnection

@synthesize delegate = _delegate;

- (void)jobCompleted:(id)json {
    
    NSError *error;
    NSDictionary* jsonData  = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    NSLog(@"jsonData ---- %@",jsonData);
    [_delegate HnadleNsUrlConnection:self json:(NSDictionary *)jsonData];
    
}

-(void)getErrorToaccesssData:(NSError *)Errdata {
    
    [_delegate HnadleNsUrlConnectionErr:self Errdata:(NSError *)Errdata];
}
- (void)getValuFromURLWithPost:(NSString *)ParamDictionary URLFOR:(NSString *)URLFOR {
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Pulling", NULL);
    
    NSLog(@"ParamDictionary ==== %@ and URLFOR ===== %@",ParamDictionary,URLFOR);
    
    dispatch_async(fetchQ, ^{
        
        NSArray *myParametersone = [ParamDictionary componentsSeparatedByString:[NSString stringWithFormat:@"%@?",URLFOR]];
        NSString *myParameters = [myParametersone objectAtIndex:1];
        NSLog(@"myParameters ==== %@",myParameters);
        //abort();
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[myParametersone objectAtIndex:0],URLFOR]];
        NSLog(@"Process URL is ==== %@",url);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [myParameters dataUsingEncoding: NSASCIIStringEncoding];
        [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler:
         ^(NSURLResponse *r, NSData *data, NSError *error) {
            // NSLog(@"data --------- %@",data);
             if (error) {
                 [self getErrorToaccesssData:error];
             } else {
                 [self jobCompleted:data];
             }
         }];
    });
    
}
- (void)getValuFromURL:(NSString *)url {
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Pulling", NULL);
    
    dispatch_async(fetchQ, ^{
        
        NSURLRequest *RequestedURL = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        AFHTTPRequestOperation *operation_login = [[AFHTTPRequestOperation alloc]initWithRequest:RequestedURL];
        
       /* bool IsJsonSerilisationUsed = false;
        
        if(IsJsonSerilisationUsed)
            operation_login.responseSerializer = [AFJSONResponseSerializer serializer];
        */
        [operation_login setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self jobCompleted:responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self getErrorToaccesssData:error];
            
        }];
        [operation_login start];
    });
}

@end

@interface UserDataClass ()

@end

@implementation UserDataClass

static UserDataClass *_sharedInstance = nil;

+ (UserDataClass *)sharedUserDataClass
{
    @synchronized(self)
    {
        if (_sharedInstance == nil) {
            _sharedInstance = [[UserDataClass alloc] init];
        }
    }
    return _sharedInstance;
}

+ (void)setSharedUserDataClass:(UserDataClass *)object
{
    _sharedInstance = object;
}

- (id)initWithParamName:(NSString *)name ParamRegistrationDate:(NSString *)RegistrationDate ParamuserEmail:(NSString *)userEmail ParamUserId:(int)UserId ParamUsername:(NSString *)Username ParamPaypalEmailId:(NSString *)PaypalEmailId  ParamUsedSpace:(NSString *)UsedSpace
{
    self = [super init];
    if (self) {
        self.name               = name;
        self.RegistrationDate   = RegistrationDate;
        self.userEmail          = userEmail;
        self.UserId             = UserId;
        self.Username           = Username;
        self.PaypalEmailId      = PaypalEmailId;
        self.UsedSpace          = UsedSpace;
    }
    return self;
}

@end


@implementation VideoListdataModel

-(id)initWithImage :(NSString *)ParamImageUrl withVideoTitle:(NSString *)ParamVideoTitle withVideoUserName:(NSString *)ParamVideoUsername withTimeAgo:(NSString *)ParamTimeAgo withVideoId:(NSString *)ParamVideoId withUserId:(NSString *)ParamUserId withVideoDuration:(NSString *)ParamVideoDuration withVideoUrl:(NSString *)ParamVideoUrl withVideoDetails:(NSString *)ParamVideoDetails
{
    self = [super init];
    if (self) {
        self.VideoImageUrl = ParamImageUrl;
        self.VideoTitle = ParamVideoTitle;
        self.VideoUsername = ParamVideoUsername;
        self.VideoPostedTimeago = ParamTimeAgo;
        self.VideoId = ParamVideoId;
        self.UserId  = ParamUserId;
        self.VideoDuration  = ParamVideoDuration;
        self.VideoUrl       = ParamVideoUrl;
        self.VideoDetails   = ParamVideoDetails;
    }
    return self;
}
-(id)initWithPaymentTitle :(NSString *)ParamPaymentTitle PaymentDesc:(NSString *)paramPaymentDesc PaymentPrice:(NSString *)ParamPaymentPrice
{
    self = [super init];
    if (self) {
        self.PaymentTitle = ParamPaymentTitle;
        self.PaymentPrice = ParamPaymentPrice;
        self.PaymentDesc  = paramPaymentDesc;
    }
    return self;
}

-(id)initWithVideoId:(NSString *)ParamVideoId VideoTitle:(NSString *)ParamVideoTitle VideoDescription:(NSString *)paramVideoDescription;
{
    self = [super init];
    if(self) {
        self.EVideoDesc     = paramVideoDescription;
        self.EVideoId       = ParamVideoId;
        self.EVideoTitle    = ParamVideoTitle;
    }
    return self;
}
@end
