//
//  iRepSubSectionViewController.h
//  iRepertory
//
//  Created by Santhosh Joseph on 4/3/11.
//  Copyright 2011 mobileadventure. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface iRepSubSectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {

	NSArray *subsectionArray;
	NSString *sectionGroup;
	NSString *section;
}
@property (nonatomic, retain)NSArray *subsectionArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andsectionGroup:theSectionGroup;
@end
