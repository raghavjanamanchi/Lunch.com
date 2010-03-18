//
//  internetConnection.m
//  Lunch.com
//
//  Created by Rags on 15/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "internetConnection.h"


@implementation internetConnection
@synthesize appDel;

-(void)initStatus 
{
	appDel = [[UIApplication sharedApplication]delegate];
	NSURL *url=[[NSURL alloc]initWithString:@"http://www.lunch.com/"];
	NSURLRequest *req=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3000.0];
	[NSURLConnection connectionWithRequest:req delegate:self];	
	[url release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError: (NSError *)error
{
	NSLog(@"No internet");
	[appDel process:NO];	
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response
{
	NSString *str = [NSString stringWithFormat:@"%@",[response URL]];
	
	if( [str isEqualToString:@"http://www.lunch.com/"]) {
		NSLog(@"Getting response");
		[appDel process:YES];
	}
	else 
	{
		NSLog(@"No Internet");
		[appDel process:NO];
	}
}


@end
