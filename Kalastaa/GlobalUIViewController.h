//
//  COGlobalUIViewController.h
//  CampOs
//
//  Created by Mac on 08/08/14.
//  Copyright (c) 2014 sbrtech. All rights reserved.
//

/*
 
 Loader view parametres declearation
 
*/


typedef enum {
    CategoryTypeBooks = 0,
    CategoryTypecellPhone,
    CategoryTypeCloths,
    CategoryTypeElectronics,
    CategoryTypeEvents,
    CategoryTypeFree,
    CategoryTypeDvd,
    CategoryTypeOther,
    CategoryTypeRoommate,
    CategoryTypeRentSpace,
    CategoryTypeSErvice,
    CategoryTypeShoes,
    CategoryTypeTickets,
    CategoryTypeTeautoring,
    CategoryTypeTurnUp,
    CategoryTypeJobs
} CategoryType;

static const float LoaderViewPositionX          = 0.0f;
static const float LoaderViewPositionY          = 0.0f;
static const float LoaderViewWidth              = 320.0f;
static const float LoaderViewHeight             = 60.0f;
static const double delayInSeconds              = 1.5;

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIView+Alertmessage.h"

@class handelURLConnection;
@interface COGlobalUIViewController : UIViewController

//
@property (nonatomic,retain) UIView *NotifyView;
//
@property (nonatomic,retain) AppDelegate *GlobalAppDelegate;

@property (retain,nonatomic) handelURLConnection *HandleURLConnection;

-(void)ShowLoadingviewWithMessage:(NSString *)UIMessage;
-(void)ShowWarningviewWithMessage:(NSString *)UIMessage;
-(void)ShowErrorviewWithMessage:(NSString *)UIMessage;
-(void)ShowSuccessviewWithMessage:(NSString *)UIMessage;
-(void)HideLoadingView;
-(void)AllTextfieldResignFirstResponderWithview:(UIView *)ResponderView;
-(void)ShowAllFonts;
-(NSDictionary *)GenerateParamValueForSubmit:(NSArray *)ParamArray FieldArray:(NSArray *)FieldArray;
-(NSString *)CallURLForServerReturn: (NSMutableDictionary *)TotalData URL:(NSString *)UrlType;
-(BOOL)isConnectedToInternet;
- (void)startSpin;
- (void)stopSpin;
-(void)SetupHeaderViewWithView:(UIView *)mainview withBackButton:(BOOL)BackButton withTitle:(NSString *)Title;
-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName;
-(NSString *)CleanTextField:(NSString *)TextfieldName;
@end

#pragma static texts

static NSString * const BlankEmailString                = @"Email field is blank";
static NSString * const BlankNameString                 = @"Name field is blank";
static NSString * const ErrorBlankUsername             = @"Username field is blank";
static NSString * const BlankSchoolString               = @"School field is blank";
static NSString * const ErrorBlankpassword             = @"Password field is blank";
static NSString * const BlankRetypePasswordString       = @"Retype Password is blank";
static NSString * const BlankPhoneNumberString          = @"Phone Number is blank";
static NSString * const EmailValidationString           = @"Email is not valid";
static NSString * const UsernameValidationString        = @"Username Character renge is 6-12";
static NSString * const PasswordmatchString             = @"Both password did not match";
static NSString * const PhoneValidationString           = @"Phone is not valid";
static NSString * const PasswordLengthString            = @"Password length should be atleast 6";


#pragma static URLs

/*
 Testing server details
 */
//static NSString * const GlobalUrlString                 = @"http://myphpdevelopers.com/dev/rest/api.php?rquest=";

/*
 Live server details
 */
static NSString * const GlobalUrlString                 = @"http://recordreceipt.com/Appdirectory/api.php?rquest=";


static NSString * const URLParameterString              = @"&&";

#pragma Webservice methods

static NSString * const ServiceMethodRegister           = @"registerUser";
static NSString * const ServiceMethodLogin              = @"login";
static NSString * const ServiceMethodUserdetails        = @"getUser";
static NSString * const ServiceMethodchangePassword     = @"changePassword";
static NSString * const ServiceMethodforgetPassword     = @"forgetPassword";
static NSString * const ServiceMethodupdateUser         = @"updateUser";
static NSString * const ServiceMethodaddVideo           = @"addVideo";
static NSString * const ServiceMethodupdateVideo        = @"updateVideo";
static NSString * const ServiceMethoddeleteVideo        = @"deleteVideo";
static NSString * const ServiceMethodgetAllUsersVideos  = @"getAllUsersVideos";
static NSString * const ServiceMethodgetYourVideos      = @"getYourVideos";
static NSString * const ServiceMethodgetVideo           = @"getVideo";

#pragma webservice operation parameters

static NSString * const ParamRegister                   = @"name&&email&&user_name&&pwd";
static NSString * const ParamLogin                      = @"user_name&&pwd";
static NSString * const ParamUserdetails                = @"id";
static NSString * const ParamChangePassword             = @"pwd&&new_pwd&&id";
static NSString * const ParamForgetPassword             = @"email";
static NSString * const ParamUpdateUser                 = @"id&&name&&email";
static NSString * const ParamAddVideo                   = @"user_id&&vid_title&&vid_desc&&vid_url&&vid_file_size&&vid_file_type";
static NSString * const ParamUpdateVideo                = @"vid_id&&user_id&&vid_title&&vid_desc";
static NSString * const ParamDeleteVideo                = @"user_id&&vid_id";
static NSString * const ParamAllUsersVideos             = @"email&&password";
static NSString * const ParamGetYourVideos           = @"user_id";
static NSString * const ParamGetVideoDetails                = @"vid_id";

#pragma Some Statc Contents, will not be writiable

static NSString * const WSReturnedMessageparam          = @"message";
static NSString * const WSReturnederrorcodeparam        = @"errorcode";
static NSString * const WSSuccessCode                   = @"1";
static NSString * const WsErrorCode                     = @"0";


#pragma webservice return param

static NSString * const WSReturnSuccess                 = @"success";
static NSString * const WSReturnError                   = @"fail";
static NSString * const WSStatusString                  = @"status";
static NSString * const WSMessageString                  = @"msg";
static NSString * const WSInvaliedString                  = @"Invalid Credentials";

// Returendparameter

@interface StaticStrings : NSObject

/**
 Decleration of the static classes methods
 Method type Error
 */
+(NSString *)BlankEmailError;
+(NSString *)BlankNameError;
+(NSString *)BlankUsernameError;
+(NSString *)BlankSchoolError;
+(NSString *)BlankPasswordError;
+(NSString *)BlankRetypePasswordError;
+(NSString *)BlankPhoneNumberError;
+(NSString *)EmailValidationError;
+(NSString *)UsernameValidationError;
+(NSString *)PasswordmatchError;
+(NSString *)PhoneValidationError;
+(NSString *)PasswordLengthError;

/**
 Method type url Parameters
 */
+(NSString *)UrlGlobalSite;
+(NSString *)URLParameterString;
+(NSString *)WSReturnSuccessString;
+(NSString *)WSReturnErrorString;
+(NSString *)WSStatusStringString;
+(NSString *)WSMessageString;

/* 
 --------------------------------------------------------------------------------------------
 ************************* Webservice Parameter Details Starts ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 @ParametersOfRegistration returns the parameterized string for Registration
 */
+(NSString *)ParametersOfRegistration;
/*
 @ParametersOfLogin returns the parameterized string for Login
 */
+(NSString *)ParametersOfLogin;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUserdetails;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfChangePassword;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfForgetPassword;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUpdateUser;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfAddVideo;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfUpdateVideo;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfDeleteVideo;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfAllUsersVideos;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfGetYourVideos;
/*
 @ParametersOfUserdetails returns the parameterized string for Userdetails
 */
+(NSString *)ParametersOfGetVideoDetails;

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Parameter Details End ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Methods Details Starts ******************************
 --------------------------------------------------------------------------------------------
 */

/*
 @WebserviceforRegistration returns the webservice string for Registration
 */
+(NSString *)WebserviceforRegistration;
/*
 @WebserviceforLogin returns the webservice string for Login
 */
+(NSString *)WebserviceforLogin;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUserdetails;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforChangePassword;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforForgetPassword;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUpdateUser;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforAddVideo;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforUpdateVideo;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforDeleteVideo;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforAllUsersVideos;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforGetYourVideos;
/*
 @WebserviceforLogin returns the webservice string for userdetails
 */
+(NSString *)WebserviceforGetVideoDetails;

/*
 --------------------------------------------------------------------------------------------
 ************************* Webservice Method Details end ******************************
 --------------------------------------------------------------------------------------------
 */


+(NSString *)WebserviceMessageString;
+(NSString *)WebserviceErrorCodeString;
+(NSString *)Webservicesuccesscode;
+(NSString *)WebserviceErrorCode;
+(NSString *)WSInvaliedString;

/*
 All Fonts Used in app
 */

/*
 @GlobalNormalFont returns the Bold Font Name
 */
+(NSString *)GlobalNormalFont;
/*
 @GlobalRegulerFont returns the Bold Font Name
 */
+(NSString *)GlobalRegulerFont;
/*
 @GlobalLightFont returns the Bold Font Name
 */
+(NSString *)GlobalLightFont;
/*
  @GlobalBoldFont returns the Bold Font Name
 */
+(NSString *)GlobalBoldFont;

/*
 --------------------------------------------------------------------------------------------
 ************************* Global Strings Declearation start ******************************
 --------------------------------------------------------------------------------------------
 */

+(NSString *)ErrorBlankUsername;
+(NSString *)ErrorBlankPassword;
/*
 --------------------------------------------------------------------------------------------
 ************************* Global Strings Declearation end ******************************
 --------------------------------------------------------------------------------------------
 */


@end


/*
 * handelURLConnection cless is made for handle url connection using the delegate method.
 * handelURLConnection class will esposible for fetch data and will send local notification to the
 * parent class from where this class is accessing
 */

@class handelURLConnection;

@protocol HnadleNsUrlConnectionDelegate <NSObject>

@required

- (void)HnadleNsUrlConnection:(handelURLConnection *)myObj json:(NSDictionary *)json;
- (void)HnadleNsUrlConnectionErr:(handelURLConnection *)myObj Errdata:(NSError *)Errdata;

@end

@interface handelURLConnection : NSObject {
    __weak id <HnadleNsUrlConnectionDelegate> _delegate;
}

@property (nonatomic, weak) id <HnadleNsUrlConnectionDelegate> delegate;

- (void)getValuFromURL:(NSString *)url;
- (void)getValuFromURLWithPost:(NSString *)ParamDictionary URLFOR:(NSString *)URLFOR;
@end


@interface UserDataClass : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *RegistrationDate;
@property(nonatomic, strong) NSString *userEmail;
@property(assign) int UserId;
@property(nonatomic, strong) NSString *Username;
@property(nonatomic, strong) NSString *PaypalEmailId;
@property(nonatomic,strong) NSString *UsedSpace;

+ (UserDataClass *)sharedUserDataClass;
+ (void)setSharedUserDataClass:(UserDataClass *)object;

- (id)initWithParamName:(NSString *)name ParamRegistrationDate:(NSString *)RegistrationDate ParamuserEmail:(NSString *)userEmail ParamUserId:(int)UserId ParamUsername:(NSString *)Username ParamPaypalEmailId:(NSString *)PaypalEmailId  ParamUsedSpace:(NSString *)UsedSpace;

@end


@interface VideoListdataModel : NSObject

// Video details

@property (nonatomic,retain) NSString *VideoId;
@property (nonatomic,retain) NSString *UserId;
@property (nonatomic,retain) NSString *VideoImageUrl;
@property (nonatomic,retain) NSString *VideoTitle;
@property (nonatomic,retain) NSString *VideoUsername;
@property (nonatomic,retain) NSString *VideoPostedTimeago;
@property (nonatomic,retain) NSString *VideoDuration;
@property (nonatomic,retain) NSString *VideoUrl;
@property (nonatomic,retain) NSString *VideoDetails;

// Payment Details

@property (nonatomic,retain) NSString *PaymentTitle;
@property (nonatomic,retain) NSString *PaymentDesc;
@property (nonatomic,retain) NSString *PaymentPrice;

// Edited video Details

@property (nonatomic,retain) NSString *EVideoTitle;
@property (nonatomic,retain) NSString *EVideoDesc;
@property (nonatomic,retain) NSString *EVideoId;


-(id)initWithImage :(NSString *)ParamImageUrl withVideoTitle:(NSString *)ParamVideoTitle withVideoUserName:(NSString *)ParamVideoUsername withTimeAgo:(NSString *)ParamTimeAgo withVideoId:(NSString *)ParamVideoId withUserId:(NSString *)ParamUserId withVideoDuration:(NSString *)ParamVideoDuration withVideoUrl:(NSString *)ParamVideoUrl withVideoDetails:(NSString *)ParamVideoDetails;

-(id)initWithPaymentTitle :(NSString *)ParamPaymentTitle PaymentDesc:(NSString *)paramPaymentDesc PaymentPrice:(NSString *)ParamPaymentPrice;

-(id)initWithVideoId:(NSString *)ParamVideoId VideoTitle:(NSString *)ParamVideoTitle VideoDescription:(NSString *)paramVideoDescription;

@end
