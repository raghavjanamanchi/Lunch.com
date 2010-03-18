//
//  loginPage.m
//  Lunch
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "loginPage.h"
#import "postReviewController.h"
#import "draftReviewController.h"


@implementation loginPage

@synthesize mainMenu;
@synthesize appDel;
@synthesize tblView,userTxtfield,pwdTxtfield,nameLabel;
@synthesize postView,draftView;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	//Implement the login Page UI here
	appDel = [[UIApplication sharedApplication]delegate];
	postView = [[postReviewController alloc]initWithNibName:@"postReviewController" bundle:nil];
	draftView = [[draftReviewController alloc]initWithNibName:@"draftReviewController" bundle:nil];
	[userTxtfield becomeFirstResponder];
    [super viewDidLoad];
}

-(void)signOutClicked
{
	self.navigationItem.rightBarButtonItem = nil;
	[mainMenu removeFromSuperview];
	[userTxtfield becomeFirstResponder];
}

-(void)showMainmenu
{
	tblView.backgroundColor = [UIColor clearColor];
	tblView.rowHeight = 40;
	tblView.separatorColor = [UIColor blackColor];
	UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action:@selector(signOutClicked)];
	self.navigationItem.rightBarButtonItem = signOutBtn;
	[self.view addSubview:mainMenu];
	[tblView reloadData];
}

-(void)loginValid:(NSString*)name
{
	nameLabel.text = [NSString stringWithFormat:@"Welcome, %@", name];
	[self showMainmenu];
}

-(void)loginInvalid
{
	UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"Wrong UserName/Password!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Please try again",nil];
	[alertView dismissWithClickedButtonIndex:1 animated:YES];
	[alertView show];
	[userTxtfield becomeFirstResponder];
}

-(void)showdraftReview
{
	
}

-(void)showPostReview
{
	
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField 
{
	[theTextField resignFirstResponder];
	[appDel showLoadingPage:self];
	return YES;
}

-(void)finishedLoading
{
	NSData *data = [connectRetriever getLoginAuthentication:userTxtfield.text :pwdTxtfield.text];
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"-----------------------------------------JSON Parsing-----------------------------------------");
	NSLog(jsonString);
	
	// Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	NSDictionary *responseDict = [results valueForKey:@"response"];
	NSLog([responseDict description]);
	NSNumber *responseNumber = [responseDict valueForKey:@"success"];
	[appDel hideLoadingPage];
	if([responseNumber intValue] == 1)
	{
		NSString *userName = [responseDict valueForKey:@"username"];
		[self loginValid:userName];
	}
	else
		[self loginInvalid];
	
	//[data release];
	//[jsonString release];
 	/*[results release];
	[responseDict release];*/
	//NSLog([results description]);
}

#pragma mark TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section 
{
	return 2;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
	CGRect CellFrame = CGRectMake(0, 0, 300, 40);
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier];
	cell.frame=CGRectMake(0,0,320,70);
	
		CGRect Label1Frame = CGRectMake(50, 0, 240, 40);
		CGRect ImageFrame = CGRectMake(10,10,15,15);
		UIImageView *imageView=[[UIImageView alloc]initWithFrame:ImageFrame];
		//	imageView.image=[UIImage imageNamed:@"Nophoto.png"];
		imageView.tag=2;
		[cell.contentView addSubview:imageView];
		[imageView release];
		
		UILabel *lblTemp;
		lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
		lblTemp.tag = 1;
		lblTemp.font=[UIFont boldSystemFontOfSize:16];
		[lblTemp setNumberOfLines:1];
		[lblTemp setTextColor:[UIColor blackColor]];
		[lblTemp setBackgroundColor:[UIColor clearColor]];
		[cell.contentView addSubview:lblTemp];
		[lblTemp release];
		
		[cell setBackgroundColor:[UIColor whiteColor]];
	return cell;
}
	
- (UITableViewCell *)tableView:(UITableView *)tablView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tablView dequeueReusableCellWithIdentifier:CellIdentifier];

		cell = [self getCellContentView:CellIdentifier];
	
		UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
		UIImageView *imView=(UIImageView*)[cell viewWithTag:2];
		
	// Set up the cell...
	if(indexPath.row == 0)
		lblTemp1.text=@"Post a Micro Review";
	else
		lblTemp1.text=@"Draft a Review";
	imView.image=[UIImage imageNamed:@"tableicon.png"];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.navigationItem.rightBarButtonItem = nil;
	if(indexPath.row == 0)
	{
		[appDel.navigationController pushViewController:postView animated:YES];
	}
	else
	{
		[appDel.navigationController pushViewController:draftView animated:YES];
	}
}

- (void)didReceiveMemoryWarning 
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[draftView release];
	[postView release];
	[appDel release];
	[mainMenu release];
	[nameLabel release];
	[userTxtfield release];
	[pwdTxtfield release];
	[tblView release];
    [super dealloc];
}


@end
