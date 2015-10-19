    //
//  iRepSubSectionViewController.m
//  iRepertory
//
//  Created by Santhosh Joseph on 4/3/11.
//  Copyright 2011 mobileadventure. All rights reserved.
//

#import "iRepSubSectionViewController.h"
#import "JMSBDBMgrWrapper.h"

#import "iRepReadSectionViewController.h"

@implementation iRepSubSectionViewController
@synthesize subsectionArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [subsectionArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	iRepReadSectionViewController *vc = [[iRepReadSectionViewController alloc]initWithNibName:@"iRepReadSectionViewController" bundle:nil];

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
	
	textCell.textLabel.text = [[subsectionArray objectAtIndex:indexPath.row]objectForKey:@"subsection"];
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
	int tableHeight = self.view.bounds.size.height ;
	CGRect tableViewFrame = CGRectMake(0,0, (self.view.bounds.size.width), tableHeight - 40);
	
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
	
	subsectionArray = [[JMSBDBMgrWrapper sharedWrapper] findAllSections];
	
	
	[self.view addSubview: mismatchStatTable];

	
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
