//
//  JMSBDBMgrWrapper.m
//  JMSB
//
//  Created by ZCO Engineering Dept on 22/10/09.
//  Copyright 2009 ZCO. All rights reserved.
//

#import "JMSBDBMgrWrapper.h"
#import "Common.h"

static JMSBDBMgrWrapper *sharedGlobalWrapper = nil;

@implementation JMSBDBMgrWrapper

-(id)init
{
	if(self = [super init])
	{
		[self initDBMgr];
	}
	return self;
}
//	Function	:   initDBMgr
//	Purpose		:	Opens JMSB DB sqlite 
//	Parameter	:	nil
//	Return      :	nil
- (void)initDBMgr
{
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	//NSString *documentsDirectory = [paths objectAtIndex:0];
	//NSString *theDatabasePath = [documentsDirectory stringByAppendingPathComponent:kDatabaseName];
	NSString *theDatabasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];
	if(!databaseManager){
		// Opens connection to the specified sqlite database
		databaseManager = [[DataBaseManager alloc]initDBWithFileName:theDatabasePath];
	}
}
//	Function	:   sharedWrapper
//	Purpose		:	return shared wrapper instance
//	Parameter	:	nil
//	Return      :	sharedWrapper
+ (JMSBDBMgrWrapper*)sharedWrapper
{
	@synchronized(self) {
        if (sharedGlobalWrapper == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedGlobalWrapper;
	
}
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedGlobalWrapper == nil) {
            sharedGlobalWrapper = [super allocWithZone:zone];
            return sharedGlobalWrapper;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
	if(databaseManager)
	{
		[databaseManager close];
		[databaseManager  release];
		databaseManager = nil;
	}
}

- (id)autorelease
{
    return self;
}

//	Function	:   findAllSections
//	Purpose		:	find all sessions from sessions table
//	Parameter	:	nil
//	Return      :	array of sessions
- (NSArray*) findAllSections
{
	NSArray *sessionArray;
	sessionArray = [databaseManager executeQuery:@"SELECT Distinct Section FROM tblkent ORDER by id"];
	return [sessionArray autorelease];
}

//	Function	:   findAllSchedules
//	Purpose		:	find all schedules from Schedules table
//	Parameter	:	nil
//	Return      :	array of schedules
- (NSArray*) findAllSchedules
{
	NSArray *scheduleArray;
	scheduleArray = [databaseManager executeQuery:@"SELECT Distinct ScheduleName FROM SCHEDULE"];
	return [scheduleArray autorelease];
}

//	Function	:   findAllDays
//	Purpose		:	find all days of Week from DayOfWeek table
//	Parameter	:	nil
//	Return      :	array of days of Week
- (NSArray*) findAllDays
{
	NSArray *dayArray;
	dayArray = [databaseManager executeQuery:@"SELECT Distinct Day FROM DayOfWeek ORDER by DayOfWeekId"];
	return [dayArray autorelease];
}

//	Function	:   findClassDetailsforSchedule
//	Purpose		:	find all class details for the specified schedule,session and day of week
//	Parameter	:	theSchedule
//				:	theSession
//				:	theDayOfWeek
//	Return      :	array of class details
- (NSArray*) findClassDetailsforSchedule:(NSString*) theSchedule andSession: (NSString*) theSession andDayOfWeek: (NSString*) theDayOfWeek
{
	NSArray *classArray;
	NSString *query = [NSString stringWithFormat:
				@"Select C.StartTime,C.EndTime,C.Code,C.Name,C.Person,C.Info From Course C \
				LEFT OUTER JOIN Session ON Session.SessionId = C.SessionId \
				LEFT OUTER JOIN Schedule ON Schedule.ScheduleId = C.ScheduleId \
				LEFT OUTER JOIN DayOfWeek ON DayOfWeek.DayOfWeekId = C.DayOfWeekId \
				WHERE Schedule.ScheduleName = \'%@\' AND \
				Session.SessionName =\'%@\' AND \
				DayOfWeek.Day = \'%@\'",theSchedule,theSession,theDayOfWeek];
	classArray = [databaseManager executeQuery:query];
	return [classArray autorelease];
}
//	Function	:   findCountOfClassesforSchedule
//	Purpose		:	find count of all class details for the specified schedule,session and day of week
//	Parameter	:	theSchedule
//				:	theSession
//				:	theDayOfWeek
//	Return      :	count of class details or 0 by default
- (NSInteger) findCountOfClassesforSchedule:(NSString*) theSchedule andSession: (NSString*) theSession andDayOfWeek: (NSString*) theDayOfWeek
{
	NSInteger classCount = 0;
	NSArray *classArray;
	NSString *query = [NSString stringWithFormat:
			   @"Select COUNT(C.Code) AS Count From Course C \
			   LEFT OUTER JOIN Session ON Session.SessionId = C.SessionId \
			   LEFT OUTER JOIN Schedule ON Schedule.ScheduleId = C.ScheduleId \
			   LEFT OUTER JOIN DayOfWeek ON DayOfWeek.DayOfWeekId = C.DayOfWeekId \
			   WHERE Schedule.ScheduleName = \'%@\' AND \
			   Session.SessionName =\'%@\' AND \
			   DayOfWeek.Day = \'%@\'",theSchedule,theSession,theDayOfWeek];
	classArray = [databaseManager executeQuery:query];
	if ([classArray count] > 0)
	{
		NSDictionary *dict = [classArray objectAtIndex:0];
		classCount = [[dict objectForKey:@"Count"]intValue];
	}
	[classArray autorelease];
	return classCount;
}

//	Function	:   findSessionPartOfYearforSession
//	Purpose		:	find part number for the specified session
//	Parameter	:	theSession
//	Return      :	part number (1,2) 1 first half, 2 second half
- (NSInteger) findSessionPartOfYearforSession:(NSString*) theSession
{
	NSInteger sessionPart = 1;
	NSArray *partArray;
	NSString *query = [NSString stringWithFormat:@"SELECT SessionPartOfYear FROM Session Where SessionName = \'%@\'",theSession];
	partArray = [databaseManager executeQuery:query];
	if ([partArray count] > 0)
	{
		NSDictionary *dict = [partArray objectAtIndex:0];
		sessionPart = [[dict objectForKey:@"SessionPartOfYear"]intValue];
	}
	[partArray autorelease];
	return sessionPart;
}

- (NSArray*) findAllSubSectionsforSection:(NSString*) theSection
{
	NSArray *subsectArray;
	NSString *query = [NSString stringWithFormat:@"SELECT subsection FROM tblkent Where section = \'%@\'",theSection];
	subsectArray = [databaseManager executeQuery:query];
	if ([subsectArray count] > 0)
	{
		return [subsectArray autorelease];
	}
	return nil;
}

- (NSArray*) findhtmlforSection:(NSString*) theSection andsubsection:(NSString*) theSubSection
{
	NSArray *subsectArray;
	NSString *query = [NSString stringWithFormat:@"SELECT filename,id,section FROM tblkent Where section = \'%@\' and subsection = \'%@\'",theSection,theSubSection ];
	subsectArray = [databaseManager executeQuery:query];
	if ([subsectArray count] > 0)
	{
		return [subsectArray autorelease];
	}
	return nil;
}
- (NSArray*) findSectionforID:(NSString*) theID
{
	NSArray *sectArray;
	NSString *query = [NSString stringWithFormat:@"SELECT section FROM tblkent Where id = %@",theID];
	sectArray = [databaseManager executeQuery:query];
	if ([sectArray count] > 0)
	{
		return [sectArray autorelease];
	}
	return nil;
}

@end
