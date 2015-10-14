//
//  Language.m
//
//  Created by cktim852 on 21/03/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnectionUtility.h"

@implementation HTTPConnectionUtility

+ (NSMutableURLRequest*)createFormRequestWithURLString:(NSString*)urlpath
                                 requestParametersInfo:(NSDictionary*)requestParametersInfo
                                         requestMethod:(NSString*)method
                                        needHSBCHeader:(BOOL)needHSBCHeader
{
    // check params
    if (urlpath == nil)
    {
        return nil;
    }
    
    NSURL *url = nil;
    NSMutableURLRequest *urlRequest = nil;
    
    // urlencode and normalize parameters
    NSString *normalizedQueryString = [NSString stringWithFormat:@"%@", requestParametersInfo];
    
    if ([[method uppercaseString] isEqualToString:@"POST"])
    {
        // POST
        
        url =[NSURL URLWithString:urlpath];
        
        urlRequest = [NSMutableURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:[normalizedQueryString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else
    {
        // GET
        
        // check url path have '?' or not
        if( [urlpath rangeOfString:@"?"].location == NSNotFound )
        {
            url = [NSURL URLWithString:[urlpath stringByAppendingFormat:@"?%@",normalizedQueryString]];
        }
        else
        {
            url = [NSURL URLWithString:[urlpath stringByAppendingFormat:@"&%@",normalizedQueryString]];
        }
        
        
        urlRequest=[NSMutableURLRequest requestWithURL:url
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:60.0];
        
        [urlRequest setHTTPMethod:@"GET"];  // default GET
        [urlRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    

    return urlRequest;
}

@end
