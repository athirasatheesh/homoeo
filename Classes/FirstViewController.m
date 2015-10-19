//
//  FirstViewController.m
//  iRepertory
//
//  Created by Santhosh Joseph on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "iRepReadSectionViewController.h"
#import "JMSBDBMgrWrapper.h"
#import "Common.h"
#import "iRepSubSectionViewController.h"

@implementation FirstViewController

@synthesize summaryArray;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.summaryArray count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//	iRepReadSectionViewController *vc = [[iRepReadSectionViewController alloc]initWithNibName:@"iRepReadSectionViewController" bundle:nil];
//	
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	[self.navigationController pushViewController:vc animated:YES];
//	[vc release];
	
	NSString * section = [[self.summaryArray objectAtIndex:indexPath.row]objectForKey:@"section"];
	
	iRepSubSectionViewController *vc = [[iRepSubSectionViewController alloc]
										initWithNibName:@"iRepSubSectionViewController"											 
										bundle:nil andsectionGroup:section];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];

	
	
	
	
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	NSString *title = @"Title";
//	return title;
//}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSString *CellIdentifier = @"TableCell";
	
	UITableViewCell *textCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (textCell == nil)
	{
		textCell =  [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
	}
	
	textCell.textLabel.text = [[summaryArray objectAtIndex:indexPath.row]objectForKey:@"section"];
	textCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
	textCell.selectionStyle = UITableViewCellSelectionStyleGray;
	textCell.textLabel.alpha = 0.7;
	//textCell.alpha = 0.5;
	
	textCell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];
	
	return textCell;
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	float tableHeight = 0 ;
	float tableWidth = 0;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		tableWidth =  768;
		tableHeight = 1024;
	}
	else
	{
		tableWidth = 320;
		tableHeight = 480;
	}
	
	
	CGRect tableViewFrame = CGRectMake(0,0, tableWidth, tableHeight - 80);
	
	UITableView * mismatchStatTable = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
	mismatchStatTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//None;
	mismatchStatTable.backgroundColor =[UIColor clearColor];
	
	[mismatchStatTable setEditing:FALSE];
	[mismatchStatTable setDelegate:self];
	[mismatchStatTable setDataSource:self];
	mismatchStatTable.alwaysBounceHorizontal	= NO;
	mismatchStatTable.alwaysBounceVertical	= NO;
	
	UIView *contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame ]];
	contentView.backgroundColor =[UIColor clearColor];
	mismatchStatTable.backgroundView = contentView;
	
	[self.view addSubview: mismatchStatTable];
	self.summaryArray = [[JMSBDBMgrWrapper sharedWrapper] findAllSections];
	
	
	self.navigationController.navigationBar.tintColor = REP_TITLE_TINT_COLOR;

//	summaryArray = 
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
