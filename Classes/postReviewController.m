//
//  postReviewController.m
//  Lunch
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "postReviewController.h"
#import "connectRetriever.h"
#import "JSON.h"

@implementation postReviewController

@synthesize tblView,appDel;
@synthesize headerArray,detailsArray,searchBar;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	{
        // Custom initialization
		self.title = @"Post a Micro Review";
    }
    return self;
}

#pragma mark UISearchBar Methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
	[searchBar setText:@""];
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
	[searchBar setShowsCancelButton:NO animated:YES];
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
	[searchBar setShowsCancelButton:NO animated:YES];
	/////Proceed to search the contents
	[searchBar resignFirstResponder];
	[appDel showLoadingPage:self];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	appDel = [[UIApplication sharedApplication]delegate];
	headerArray = [[NSMutableArray alloc]init];
	detailsArray = [[NSMutableArray alloc]init];
	searchBar.tintColor = [UIColor colorWithRed:0.49 green:0.784 blue:0.122 alpha:1.0];
    [super viewDidLoad];
}

#pragma mark TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section 
{
	return [headerArray count];
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier
{
	CGRect CellFrame = CGRectMake(0, 0, 300,50);
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier];
	cell.frame=CGRectMake(0,0,320,70);
	
	CGRect Label1Frame = CGRectMake(10, 0, 240, 20);
	CGRect Label2Frame = CGRectMake(10, 20, 240, 30);
	
	UILabel *lblTemp;
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	lblTemp.font=[UIFont boldSystemFontOfSize:16];
	[lblTemp setNumberOfLines:1];
	[lblTemp setTextColor:[UIColor blackColor]];
	[lblTemp setBackgroundColor:[UIColor clearColor]];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	[lblTemp setNumberOfLines:2];
	[lblTemp setFont:[UIFont fontWithName:@"Arial" size:14]];
	[lblTemp setTextColor:[UIColor blackColor]];
	[lblTemp setBackgroundColor:[UIColor clearColor]];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	[cell setBackgroundColor:[UIColor lightGrayColor]];
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tablView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tablView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	cell = [self getCellContentView:CellIdentifier];
	
	UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];

	
	// Set up the cell...
		lblTemp1.text=[headerArray objectAtIndex:indexPath.row];
		lblTemp2.text=[detailsArray objectAtIndex:indexPath.row];
	
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)finishedLoading
{
	NSData *data = [connectRetriever search:searchBar.text];
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"-----------------------------------------JSON Search Parsing-----------------------------------------");
	NSLog(jsonString);
	
	// Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	NSDictionary *responseDict = [results valueForKey:@"response"];
	NSLog([responseDict description]);
}

- (void)didReceiveMemoryWarning {
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
	[searchBar release];
	[appDel release];
	[headerArray release];
	[detailsArray release];
	[tblView release];
    [super dealloc];
}


@end
