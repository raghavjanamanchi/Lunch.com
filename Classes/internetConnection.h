//
//  internetConnection.h
//  Lunch.com
//
//  Created by Rags on 15/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lunch_comAppDelegate.h"

@interface internetConnection : NSObject 
{
	Lunch_comAppDelegate *appDel;
}

@property (nonatomic, retain) Lunch_comAppDelegate *appDel;

-(void)initStatus;

@end
