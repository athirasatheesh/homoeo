//
//  iRepReadSectionViewController.m
//  iRepertory
//
//  Created by Santhosh Joseph on 10/12/10.
//  Copyright 2010 mobileadventure. All rights reserved.
//

#import "iRepReadSectionViewController.h"
#import "JMSBDBMgrWrapper.h"

@implementation iRepReadSectionViewController

//char *str_replace(char *orig, char *rep, char *with) {
//    char *result; // the return string
//    char *ins;    // the next insert point
//    char *tmp;    // varies
//    int len_rep;  // length of rep
//    int len_with; // length of with
//    int len_front; // distance between rep and end of last rep
//    int count;    // number of replacements
//	
//    if (!orig)
//        return NULL;
//    if (!rep || !(len_rep = strlen(rep)))
//        return NULL;
//    if (!(ins = strstr(orig, rep))) 
//        return NULL;
//    if (!with)
//        with = "";
//    len_with = strlen(with);
//	
//    for (count = 0; tmp = strstr(ins, rep); ++count) {
//        tmp += ins - tmp;
//        ins = tmp;
//    }
//	
//    // first time through the loop, all the variable are set correctly
//    // from here on,
//    //    tmp points to the end of the result string
//    //    ins points to the next occurrence of rep in orig
//    //    orig points to the remainder of orig after "end of rep"
//    tmp = result = malloc(strlen(orig) + (len_with - len_rep) * count + 1);
//	
//    if (!result)
//        return NULL;
//	
//    while (1) {
//        len_front = ins - orig;
//        tmp = strncpy(tmp, orig, len_front) + len_front;
//        tmp = strcpy(tmp, with) + len_with;
//        orig += len_front + len_rep; // move to next "end of rep"
//        if (--count) break;
//        ins = strstr(orig, rep);
//    }
//    strcpy(tmp, orig);
//    return result;
//}

char *replace_str(char *str, char *orig, char *rep)
{
	static char buffer[4096];
	char *p;
	
	if(!(p = strstr(str, orig)))  // Is 'orig' even in 'str'?
		return str;
	
	strncpy(buffer, str, p-str); // Copy characters from 'str' start to 'orig' st$
	buffer[p-str] = '\0';
	
	sprintf(buffer+(p-str), "%s%s", rep, p+strlen(orig));
	
	return buffer;
}
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  andHtmlPage:(NSString *)theHtml andPageIndex:(int)thePageIndex 
andSection:(NSString *)theSection
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
        // Custom initialization
		htmlFilePath = theHtml;
		pageIndex = thePageIndex;
		section = theSection;
    }
    return self;
}

- (void) viewNextPage
{
	NSString * tempPath = [NSString stringWithFormat:@"kentp%d",pageIndex];
	//NSString * tempPath = [NSString stringWithFormat:@"kentp%d",524];
	htmlFilePath = tempPath;

	NSArray * objects =  [[JMSBDBMgrWrapper sharedWrapper] findSectionforID:[NSString stringWithFormat:@"%d",pageIndex]];
	
	NSDictionary *dict = [objects objectAtIndex:0];
	section = [dict objectForKey:@"section"];
	
	self.title = section;

	htmlFilePath = [htmlFilePath stringByReplacingOccurrencesOfString:@".html" withString:@""];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:htmlFilePath ofType:@"html"];
	//NSData *helpData = [NSData dataWithContentsOfFile:filePath];
	//NSString *filePath = [[NSBundle mainBundle] pathForResource:@"kentp924" ofType:@"html"];
	NSLog(@"filePath  > %@",filePath);

	NSMutableString * strData = [NSMutableString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil];
	[strData replaceOccurrencesOfString:@"<body>" withString:@"<body background=\"bknd.jpg\">" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];

	[strData replaceOccurrencesOfString:@"<p class=\"p1\">" withString:@"<p align= center>" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];

	[strData replaceOccurrencesOfString:@"{color: #1c39f6}" withString:@"{color: #F88017}" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];
	[strData replaceOccurrencesOfString:@"Œ" withString:@"OE" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];
	[strData replaceOccurrencesOfString:@"œ" withString:@"oe" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];

	[strData replaceOccurrencesOfString:@"Æ" withString:@"AE" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];

	[strData replaceOccurrencesOfString:@"æ" withString:@"ae" options:NSLiteralSearch  range:NSMakeRange(0, [strData length])];


	[strData replaceOccurrencesOfString:@"http://www.homeoint.org/books/kentrep" withString:@"/" options:NSLiteralSearch range:NSMakeRange(0, [strData length])];

	//char * strCData =  [strData cStringUsingEncoding:NSUTF8StringEncoding];

	//char * final = replace_str(strCData,"æ","ae");

	NSData *helpData = [strData dataUsingEncoding:NSASCIIStringEncoding];


	//NSString * temp = [NSString stringWithCString:final encoding:NSUTF8StringEncoding];

	//NSData *helpData = [temp dataUsingEncoding:NSUTF8StringEncoding];



	NSString *path1 = [[NSBundle mainBundle] bundlePath];
	NSURL *url1 = [NSURL fileURLWithPath:path1];

	//NSLog(@"URL____> %@",url1);

	if(helpData)
	{
		[myWebView loadData:helpData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url1];
	}
	else 
	{
		[myWebView loadData:nil MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url1];
	}

	if (pageIndex >= 1423)
	{
		btnNext.enabled = NO;
	}
	if (pageIndex <= 1)
	{
		btnPrev.enabled = NO;
	}
}
- (IBAction)nextButtonPressed:(id)sender
{
	pageIndex++;
	[self viewNextPage];
	

	btnPrev.enabled = YES;
}

- (IBAction)backButtonPressed:(id)sender
{
	pageIndex--;
	[self viewNextPage];


	btnNext.enabled = YES;	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		btnNext.frame = CGRectMake(768 - 30, 0, 25, 25);
		myImgView.frame = CGRectMake(0, 0, 768, 30);
	}
	[self viewNextPage];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
