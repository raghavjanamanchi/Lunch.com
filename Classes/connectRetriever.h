//
//  connectRetriever.h
//  Lunch.com
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface connectRetriever : NSObject 
{
}

+ (NSData *)getLoginAuthentication:(NSString *)userName:(NSString*)passkey;
+ (NSData *)search:(NSString *)keyString;

@end
