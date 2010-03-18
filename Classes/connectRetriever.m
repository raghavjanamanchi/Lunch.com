//
//  connectRetriever.m
//  Lunch.com
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "connectRetriever.h"


@implementation connectRetriever

NSArray *cookieArray;
NSHTTPCookie *newCookie;

+ (NSData *)getLoginAuthentication:(NSString *)userName:(NSString*)passkey
{
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
	NSString *body=[NSString stringWithFormat:@"{\"beanName\":\"MemberAjaxService\",\"extraAjaxPathData\":\"%@/authenticate/\",\"parameters\":[\"%@\",\"%@\",true,\"\",null],\"target\":\"authenticateMember\"}"
					,userName,userName,passkey];
	NSData *postData=[body dataUsingEncoding:NSUTF8StringEncoding];
	NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *newurlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:
																			[NSString stringWithFormat:@"http://www.lunch.com/%@/authenticate/ajax.do",userName]]
															   cachePolicy:NSURLRequestUseProtocolCachePolicy
														   timeoutInterval:1000];
	[newurlRequest setHTTPMethod: @"POST"];
	[newurlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
	
	[newurlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
	[newurlRequest setHTTPBody:postData];
									
	
	NSError *error;
	NSHTTPURLResponse *response;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:newurlRequest returningResponse:&response error:&error];
	NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(responseString);
	NSDictionary *headerFields = [(NSHTTPURLResponse*)response allHeaderFields];
	NSLog(@"RESPONSE HEADERS: \n%@", [headerFields description]);
	NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.lunch.com/%@/authenticate/ajax.do",userName]]];
	NSLog(@"How many Cookies: %d", all.count);
	// Store the cookies:
	// NSHTTPCookieStorage is a Singleton.
	
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:all forURL:[NSURL URLWithString:@"http://www.lunch.com/authenticate"] mainDocumentURL:nil];
	
	// Now we can print all of the cookies we have:
//	newCookie = [NSHTTPCookie cookieWithProperties:[response allHeaderFields]];
	cookieArray = [[NSArray alloc]initWithArray:all];
	for (NSHTTPCookie *cookie in all)
		NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
										
	return responseData;

}

+ (NSData *)search:(NSString *)keyString
{
	//[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:@"http://www.lunch.com/j_spring_security_check"] mainDocumentURL:nil];
	NSString *body=[NSString stringWithFormat:@"{\"j_username=aprilfool\",\"j_password=aprilfool\",\"isRegistration=false\",\"_spring_security_remember_me=true\"}"];
	NSLog(@"The Body of the data to be sent = %@",body);
	NSData *postData=[body dataUsingEncoding:NSUTF8StringEncoding];
	NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *newurlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:
																			[NSString stringWithFormat:@"http://www.lunch.com/j_spring_security_check"]]
															   cachePolicy:NSURLRequestUseProtocolCachePolicy
														   timeoutInterval:1000];
	[newurlRequest setHTTPMethod: @"POST"];
	[newurlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
	
	[newurlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
	[newurlRequest setHTTPBody:postData];
	NSArray * availableCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://www.lunch.com/authenticate"]];
	for (NSHTTPCookie *cookie in availableCookies)
		NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
    NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:availableCookies];
	[newurlRequest setAllHTTPHeaderFields:headers];
	
	NSError *error;
	NSHTTPURLResponse *response;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:newurlRequest returningResponse:&response error:&error];
	NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(responseString);
	NSDictionary *headerFields = [(NSHTTPURLResponse*)response allHeaderFields];
	NSLog(@"RESPONSE HEADERS: \n%@", [headerFields description]);
	NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"http://www.lunch.com/ajax.do"]];
	NSLog(@"How many Cookies: %d", all.count);
	// Store the cookies:
	// NSHTTPCookieStorage is a Singleton.
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:all forURL:[NSURL URLWithString:@"http://www.lunch.com/ajax.do"] mainDocumentURL:nil];
	
	// Now we can print all of the cookies we have:
	for (NSHTTPCookie *cookie in all)
		NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
	
	return responseData;
/*	NSString *body=[NSString stringWithFormat:@"{\"beanName\":\"ContentAjaxService\",\"extraAjaxPathData\":\"\",\"parameters\":[\"%@\",0,5,\"true\",null,null,\"DATAPOINT\",\"{\"format\":\"json\"}],\"target\":\"searchDatapoints\",\"alreadySerialized\":\"true\"}"
					,keyString];
	NSLog(@"The Body of the data to be sent = %@",body);
	NSData *postData=[body dataUsingEncoding:NSUTF8StringEncoding];
	NSString *postLength=[NSString stringWithFormat:@"%d",[postData length]];
	NSMutableURLRequest *newurlRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:
																			[NSString stringWithFormat:@"http://www.lunch.com/ajax.do"]]
															   cachePolicy:NSURLRequestUseProtocolCachePolicy
														   timeoutInterval:1000];
	[newurlRequest setHTTPMethod: @"POST"];
	[newurlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
	
	[newurlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
	[newurlRequest setHTTPBody:postData];
	
	
	NSError *error;
	NSHTTPURLResponse *response;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:newurlRequest returningResponse:&response error:&error];
	NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(responseString);
	NSDictionary *headerFields = [(NSHTTPURLResponse*)response allHeaderFields];
	NSLog(@"RESPONSE HEADERS: \n%@", [headerFields description]);
	NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"http://www.lunch.com/ajax.do"]];
	NSLog(@"How many Cookies: %d", all.count);
	// Store the cookies:
	// NSHTTPCookieStorage is a Singleton.
	[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:all forURL:[NSURL URLWithString:@"http://www.lunch.com/ajax.do"] mainDocumentURL:nil];
	
	// Now we can print all of the cookies we have:
	for (NSHTTPCookie *cookie in all)
		NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
	
	return responseData;
	*/
}

/*	NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.lunch.com/aprilfool/authenticate/ajax.do", NSHTTPCookieOriginURL,
 @"testCookies", NSHTTPCookieName,
 @"1", NSHTTPCookieValue,
 @"beanName",@"MemberAjaxService",
 @"extraAjaxPathData",@"",
 nil];
 NSHTTPCookie *loginCookie = [NSHTTPCookie cookieWithProperties:properties];
 NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
 [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
 [cookieStorage setCookie:loginCookie];
 */
@end
