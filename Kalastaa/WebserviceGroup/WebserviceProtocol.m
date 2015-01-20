//
//  WebserviceProtocol.m
//  Hema
//
//  Created by Mac on 05/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import "WebserviceProtocol.h"
#import "SOAPEnvelope.h"
#import "UrlParameterString.h"
#import "WebserviceHelper.h"
#import "NSError+CustomErrors.h"

@implementation WebserviceProtocol
@synthesize delegate = _delegate;

-(id)initWithParamObject:(NSArray *)DataParamObject
             ValueObject:(NSArray *)DataValueObject
            UrlParameter:(NSString *)DataUrlParameter
{
    self = [super init];
    if (self) {
        self.ParamArray = DataParamObject;
        self.ValueArray = DataValueObject;
        self.ParamUrl   = DataUrlParameter;
    }
    return self;
}


-(void)AccessWebservice
{
    if ([self.ParamArray count] != [self.ValueArray count]) {
        
        [self WebaccessCompleteWithRetrnedErrorObject:NSError.ParamCountError];
    } else {

        WebserviceInputParameter *inputParam = [[WebserviceInputParameter alloc] init];
        inputParam.webserviceRelativePath = [self GenerateURLFromString];
        inputParam.serviceMethodType = WEBSERVICE_METHOD_TYPE_POST;
        
        for (int I = 0; I<[self.ParamArray count];I++) {
            [inputParam.dict_postParameters setObject:[self.ValueArray objectAtIndex:I]
                                               forKey:[self.ParamArray objectAtIndex:I]];
        }
        
        NSLog(@"inputParam.dict_postParameters === %@",inputParam.dict_postParameters);
        typedef void (^successBlock)(id response);
        
     /*  [WebserviceHelper callJSONWebServiceWithInputParameter:inputParam
                                                       success:^(id response) {
                                                           NSLog(@"%@",response);
                                                           
                                                       } error:^(NSError *error, id JSON) {
                                                           NSLog(@"%@",error.description);
                                                       }];
       */
        
       [WebserviceHelper callWebserviceWithInputParameter:inputParam
                                                   success:^(id response) {
                                                       if (response) {
                                                           [self WebaccessCompleteWithRetrnedSuccessObject:response];
                                                       }
                                                   } error:^(NSError *error) {
                                                       [self WebaccessCompleteWithRetrnedErrorObject:error];
                                                   }];
    }
}

-(void)WebaccessCompleteWithRetrnedSuccessObject:(NSData *)ParamSuccessObject
{
    if ([ParamSuccessObject isKindOfClass:[NSData class]]) {
        NSString *str = [[NSString alloc] initWithData:ParamSuccessObject encoding:NSUTF8StringEncoding];
        [_delegate RetunWebserviceDataWithSuccess:self ObjectCarrier:str];
    }
}

-(void)WebaccessCompleteWithRetrnedErrorObject:(NSError *)ParamErrorObject
{
    [_delegate RetunWebserviceDataWithError:self ObjectCarrier:ParamErrorObject];
}

-(NSString *)GenerateURLFromString
{
    NSString *URLstring = [NSString stringWithFormat:@"%@%@",UrlParameterString.GlobalURL,self.ParamUrl];
    return URLstring;
}

@end
