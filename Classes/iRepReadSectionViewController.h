//
//  iRepReadSectionViewController.h
//  iRepertory
//
//  Created by Santhosh Joseph on 10/12/10.
//  Copyright 2010 mobileadventure. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRepReadSectionViewController : UIViewController {
	IBOutlet UIWebView *myWebView;
	NSString *htmlFilePath;
	int pageIndex;
	IBOutlet UIButton * btnNext;
	IBOutlet UIButton * btnPrev;
	IBOutlet UIImageView* myImgView;
	NSString *section;
}
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  andHtmlPage:(NSString *)theHtml andPageIndex:(int)thePageIndex
		   andSection:(NSString *)theSection;
@end
