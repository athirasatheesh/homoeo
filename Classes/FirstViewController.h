//
//  FirstViewController.h
//  iRepertory
//
//  Created by Santhosh Joseph on 10/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSArray *summaryArray;
}
@property (nonatomic, retain)NSArray *summaryArray;
@end
