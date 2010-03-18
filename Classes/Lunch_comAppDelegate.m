//
//  Lunch_comAppDelegate.m
//  Lunch.com
//
//  Created by Rags on 08/03/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Lunch_comAppDelegate.h"
#import "loginPage.h"
#import "internetConnection.h"

@implementation Lunch_comAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize login,loadingPage,fwdDelegate,check;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
	
    // Override point for customization after application launch
	[self initialiseControllers];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

-(void)process:(BOOL)hasInternet
{
	[check release];
	if(hasInternet)
	{
		[fwdDelegate finishedLoading];
	}
	else
	{
		UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Wrong UserName/Password!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Please try again",nil];
		[alertView dismissWithClickedButtonIndex:1 animated:YES];
		[alertView show];
	}
}

-(void)checkForinternet
{
	check = [[internetConnection alloc]init];
	[check initStatus];
}

-(void)initialiseControllers
{
	self.login = [[loginPage alloc]initWithNibName:@"loginPage" bundle:nil];
	navigationController = [[UINavigationController alloc]initWithRootViewController:self.login];
	[navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.49 green:0.784 blue:0.122 alpha:1.0]];

	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
	[navigationController.navigationBar.topItem setTitleView:imageView];

	[imageView release];
	[loadingPage setAlpha:0];
}

-(void)showLoadingPage:(id)delegate
{
	fwdDelegate = delegate;
	[self.window addSubview:loadingPage];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(checkForinternet)];
	[loadingPage setAlpha:0.75];
	[UIView commitAnimations];		
}

-(void)hideLoadingPage
{
	[loadingPage removeFromSuperview];
	[loadingPage setAlpha:0];
}

- (void)dealloc 
{
	[check release];
	[navigationController release];
	[fwdDelegate release];
	[loadingPage release];
	[login release];
    [window release];
    [super dealloc];
}


@end
