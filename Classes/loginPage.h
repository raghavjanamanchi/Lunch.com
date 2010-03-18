//
//  loginPage.h
//  Lunch
//
//  Created by Rags on 08/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lunch_comAppDelegate.h"
#import "connectRetriever.h"
#import "JSON.h"

@class draftReviewController,postReviewController;
@interface loginPage : UIViewController <UIAlertViewDelegate>
{	
	Lunch_comAppDelegate *appDel;
	
	UIView *mainMenu;
	UITableView *tblView;
	UILabel *nameLabel;
	UITextField *userTxtfield,*pwdTxtfield;
	
	postReviewController *postView;
	draftReviewController *draftView;
}
@property (nonatomic, retain) Lunch_comAppDelegate *appDel;

@property (nonatomic, retain) IBOutlet UIView *mainMenu;
@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UITextField *userTxtfield,*pwdTxtfield;

@property (nonatomic, retain) postReviewController *postView;
@property (nonatomic, retain) draftReviewController *draftView;

-(void)loginInvalid;
-(void)loginValid:(NSString*)name;
-(void)showPostReview;
-(void)showdraftReview;
-(void)finishedLoading;

@end
