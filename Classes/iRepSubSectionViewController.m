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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andsectionGroup:theSectionGroup
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		sectionGroup = theSectionGroup;
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.subsectionArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	NSString * subsection = [[self.subsectionArray objectAtIndex:indexPath.row]objectForKey:@"subsection"];
	
	NSString * hTMlfileName;
	NSArray * objects = [[JMSBDBMgrWrapper sharedWrapper] findhtmlforSection:sectionGroup andsubsection:subsection];
	
	NSDictionary *dict = [objects objectAtIndex:0];
	hTMlfileName = [dict objectForKey:@"filename"];
	int page = [[dict objectForKey:@"id"]intValue];

	NSString * currentsection = [dict objectForKey:@"section"];;
	
	iRepReadSectionViewController *vc = [[iRepReadSectionViewController alloc]
										 initWithNibName:@"iRepReadSectionViewController" bundle:nil
										 andHtmlPage:hTMlfileName andPageIndex: page andSection:currentsection];

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
	
	
	
	NSString* strData = [[self.subsectionArray objectAtIndex:indexPath.row]objectForKey:@"subsection"];
	if (strData)
	{
		strData = [strData stringByReplacingOccurrencesOfString:@"Œ" withString:@"OE"];
		strData = [strData stringByReplacingOccurrencesOfString:@"œ" withString:@"oe"];
		strData = [strData stringByReplacingOccurrencesOfString:@"Æ" withString:@"AE"];
		strData = [strData stringByReplacingOccurrencesOfString:@"æ" withString:@"ae"];
	}
	
	textCell.textLabel.text = strData;
	
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
	
	self.subsectionArray = [[JMSBDBMgrWrapper sharedWrapper] findAllSubSectionsforSection:sectionGroup];
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
