//
//  JMSBDBMgrWrapper.h
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseManager.h"

@interface JMSBDBMgrWrapper : NSObject {
	DataBaseManager *databaseManager;
}
+ (JMSBDBMgrWrapper*)sharedWrapper;
- (void)initDBMgr;
- (NSArray*) findAllSections;
- (NSArray*) findAllSubSectionsforSection:(NSString*) theSection;
- (NSArray*) findhtmlforSection:(NSString*) theSection andsubsection:(NSString*) theSubSection;

- (NSArray*) findAllSchedules;
- (NSArray*) findAllDays;
- (NSInteger) findSessionPartOfYearforSession:(NSString*) theSession;
- (NSArray*) findClassDetailsforSchedule:(NSString*) theSchedule andSession: (NSString*) theSession andDayOfWeek: (NSString*) theDayOfWeek;
- (NSInteger) findCountOfClassesforSchedule:(NSString*) theSchedule andSession: (NSString*) theSession andDayOfWeek: (NSString*) theDayOfWeek;
- (NSArray*) findSectionforID:(NSString*) theID;
@end
