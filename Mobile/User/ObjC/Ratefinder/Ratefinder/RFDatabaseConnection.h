//
//  RFDatabaseConnection.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 28/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFDatabaseConnection : NSObject
-(NSArray *) getSites;
-(NSArray *) getPersons;
-(NSArray *) getPersonsWithRatesOnSite: (int) siteID;
-(NSArray *) getRatesOfPerson: (int) personID
                       onSite: (int) siteID
                         from: (NSDate *) startDate
                           to: (NSDate *) finishDate;
+(RFDatabaseConnection *) defaultDatabaseConnection;
@end
