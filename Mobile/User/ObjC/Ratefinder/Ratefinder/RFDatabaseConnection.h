//
//  RFDatabaseConnection.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 28/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFItem.h"

@protocol RFDatabaseConnectionDelegate <NSObject>
-(void)itemsDidRecieveWithObject:(id)object ofType:(RFItemType)itemType;
-(void)personsWithRatesDidRecieveWithObject: (id)object;
-(void)ratesWithDatesDidRecieveWithObject: (id)object;

@end

@interface RFDatabaseConnection: NSObject <NSURLSessionDelegate, NSURLSessionDataDelegate>
@property id <RFDatabaseConnectionDelegate> delegate;

-(void)getSites;
-(void)getPersons;
-(void)getPersonsWithRatesOnSite: (int)siteID;
-(void)getRatesOfPerson: (int)personID
                       onSite: (int)siteID
                         from: (NSDate *)startDate
                           to: (NSDate *)finishDate;
@end
