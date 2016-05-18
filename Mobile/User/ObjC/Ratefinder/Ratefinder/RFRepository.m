//
//  RFRepository.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 21/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFRepository.h"

static RFRepository *singleRepository = nil;

@interface RFRepository()

@property NSArray *persons;
@property NSArray *sites;
@property NSArray *personsWithRatesOnCurrentSite;
@property NSArray *ratesOfCurrentPersonWithDatesOnCurrentSite;
@end

@implementation RFRepository

-(void)dbDidDisconnect
{
    [self.delegate updateDidFinish];
}

-(void)dbDidConnect
{
    [self.delegate updateDidStart];
}

-(void)itemsDidRecieveWithObject:(id)object ofType:(RFItemType)itemType
{
    NSArray *itemsDictionaries = object;
    NSMutableArray *itemsMutable = [NSMutableArray array];
    for (NSDictionary *item in itemsDictionaries) {
        RFItem *newItem = [[RFItem alloc] init];
        newItem.name = [NSString stringWithFormat:@"%@", item[@"Name"]];
        NSNumber *numberIdentificator = [item objectForKey:@"ID"];
        newItem.identificator = [numberIdentificator integerValue];
        [itemsMutable addObject:newItem];
    }
    
    switch (itemType) {
        case RFSiteItem:
            self.sites = itemsMutable;
            [self.delegate sitesDidUpdate];
            break;
        case RFPersonItem:
            self.persons = itemsMutable;
            [self.delegate personsDidUpdate];
        default:
            break;
    }
    
}

-(void)ratesWithDatesDidRecieveWithObject:(id)object
{
    NSArray *ratesOfCurrentPersonOnCurrentSite = object;
    NSMutableArray *personsRatesMutable = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (NSDictionary *personRates in ratesOfCurrentPersonOnCurrentSite) {
        RFRateWithDate *theRateWithDate = [[RFRateWithDate alloc] init];
        theRateWithDate.date = [dateFormatter dateFromString: personRates[@"Date"]];
        NSNumber *numberRate = personRates[@"Rank"];
        theRateWithDate.rate = [numberRate integerValue];
        [personsRatesMutable addObject:theRateWithDate];
    }
    self.ratesOfCurrentPersonWithDatesOnCurrentSite = personsRatesMutable;
    [self.delegate ratesWithDatesDidUpdate];
}

-(void)personsWithRatesDidRecieveWithObject:(id)object
{
    NSMutableArray *ratesOnCurrentSite = [NSMutableArray array];
    NSArray *ratesOnCurrentSiteDictionaries = object;
    
    for (NSDictionary *ratesOnSite in ratesOnCurrentSiteDictionaries) {
        RFPersonWithRate *personWithRate = [[RFPersonWithRate alloc] init];
        for (RFPerson *person in self.persons) {
            NSNumber *numberIdentificator = ratesOnSite[@"PersonID"];
            if (person.identificator == [numberIdentificator integerValue]) {
                personWithRate.person = person;
                NSNumber *numberRate = ratesOnSite[@"Rank"];
                personWithRate.rate = [numberRate integerValue];
                [ratesOnCurrentSite addObject:personWithRate];
                break;
            }
        }
    }
    
    self.personsWithRatesOnCurrentSite = ratesOnCurrentSite;
    [self.delegate personsWithRatesDidUpdate];
}

-(void)updatePersonsWithRatesOnCurrentSite
{
    self.personsWithRatesOnCurrentSite = nil;
    RFDatabaseConnection *dbConnection = [[RFDatabaseConnection alloc] init];
    dbConnection.delegate = self;
    [dbConnection getPersonsWithRatesOnSite:self.currentSite.identificator];
}

-(void)updateRatesOfCurrentPersonOnCurrentSite
{
    self.ratesOfCurrentPersonWithDatesOnCurrentSite = nil;
    RFDatabaseConnection *dbConnection = [[RFDatabaseConnection alloc] init];
    dbConnection.delegate = self;
    [dbConnection getRatesOfPerson:self.currentPerson.identificator onSite:self.currentSite.identificator from:self.startDateForRates to:self.finishDateForRates];
}

-(void)updateSites
{
    self.sites = nil;
    RFDatabaseConnection *dbConnection = [[RFDatabaseConnection alloc] init];
    dbConnection.delegate = self;
    [dbConnection getSites];
}

-(void)updatePersons
{
    self.persons = nil;
    RFDatabaseConnection *dbConnection = [[RFDatabaseConnection alloc] init];
    dbConnection.delegate = self;
    [dbConnection getPersons];
}

+(RFRepository *)sharedRepository {
    
    if (!singleRepository) {
        singleRepository = [[RFRepository alloc] init];
    }
    
    return singleRepository;
}

@end
