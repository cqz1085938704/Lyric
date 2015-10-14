//
//  Language.h
//
//  Created by cktim852 on 21/03/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPConnectionUtility : NSObject <NSURLConnectionDataDelegate>

+ (NSMutableURLRequest*)createFormRequestWithURLString:(NSString*)urlpath
                                 requestParametersInfo:(NSDictionary*)requestParametersInfo
                                         requestMethod:(NSString*)method
                                        needHSBCHeader:(BOOL)needHSBCHeader;
@end
