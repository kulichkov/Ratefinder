//
//  RFRepository.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 21/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "RFPersonWithRate.h"
#include "RFDatabaseConnection.h"
#include "RFRateWithDate.h"

@protocol RFRepositoryDelegate <NSObject>

-(void)sitesDidUpdate;
-(void)personsDidUpdate;
-(void)personsWithRatesDidUpdate;
-(void)ratesWithDatesDidUpdate;
-(void)updateDidFinish;
-(void)updateDidStart;
@end

@interface RFRepository: NSObject <RFDatabaseConnectionDelegate>
@property id <RFRepositoryDelegate> delegate;
@property (readonly, nonatomic) NSArray *persons;
@property (readonly, nonatomic) NSArray *sites;
@property (readonly, nonatomic) NSArray *personsWithRatesOnCurrentSite;
@property (readonly, nonatomic) NSArray *ratesOfCurrentPersonWithDatesOnCurrentSite;
@property RFPerson *currentPerson;
@property RFSite *currentSite;
@property NSDate *startDateForRates;
@property NSDate *finishDateForRates;
-(void)updatePersonsWithRatesOnCurrentSite;
-(void)updateRatesOfCurrentPersonOnCurrentSite;
+(RFRepository *)sharedRepository;
@end
