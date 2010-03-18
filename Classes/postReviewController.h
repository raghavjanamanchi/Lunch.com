//
//  postReviewController.h
//  Lunch
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lunch_comAppDelegate.h"

@interface postReviewController : UIViewController 
{
	UITableView *tblView;
	Lunch_comAppDelegate *appDel;
	NSMutableArray *headerArray,*detailsArray;
	UISearchBar *searchBar;
}

@property (nonatomic, retain) UITableView *tblView;
@property (nonatomic, retain) Lunch_comAppDelegate *appDel;
@property (nonatomic, retain) NSMutableArray *headerArray,*detailsArray;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end
