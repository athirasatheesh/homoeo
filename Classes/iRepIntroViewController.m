//
//  iRepIntroViewController.m
//  iRepertory
//
//  Created by Santhosh Joseph on 10/19/10.
//  Copyright 2010 mobileadventure. All rights reserved.
//

#import "iRepIntroViewController.h"
#import "Common.h"

@implementation iRepIntroViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor = REP_TITLE_TINT_COLOR;
	
	NSString *filePath = @"";
	
	switch (self.navigationController.tabBarItem.tag) {
		case 0:
			filePath = [[NSBundle mainBundle] pathForResource:@"preface" ofType:@"html"];
			break;
		case 1:
			filePath = [[NSBundle mainBundle] pathForResource:@"use" ofType:@"html"];
			break;
		case 2:
			filePath = [[NSBundle mainBundle] pathForResource:@"remedies" ofType:@"html"];
			
			break;

		default:
			break;
	}
	NSLog (@"tag = %d",self.navigationController.tabBarItem.tag );
	
	

	NSData *helpData = [NSData dataWithContentsOfFile:filePath];
	
	NSString *path1 = [[NSBundle mainBundle] bundlePath];
	NSURL *url1 = [NSURL fileURLWithPath:path1];
	
	
	if(helpData)
		[myWebView loadData:helpData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url1];
	
	
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration 
{
	self.view.backgroundColor = [UIColor redColor];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	return NO;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
