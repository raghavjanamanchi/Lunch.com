//
//  Lunch_comAppDelegate.h
//  Lunch.com
//
//  Created by Rags on 08/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class loginPage,internetConnection;
@interface Lunch_comAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    UINavigationController *navigationController;
	loginPage *login;
	UIView *loadingPage;
	id fwdDelegate;
	internetConnection *check;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) loginPage *login;
@property (nonatomic, retain) IBOutlet UIView *loadingPage;
@property (nonatomic, retain) id fwdDelegate;
@property (nonatomic, retain) internetConnection *check;

-(void)initialiseControllers;
-(void)showLoadingPage:(id)delegate;
-(void)hideLoadingPage;
-(void)process:(BOOL)hasInternet;
@end

