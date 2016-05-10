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

-(void)sitesDidRecieveWithObject:(id)object
{
    NSArray *sitesDictionaries = object;
    NSMutableArray *sitesMutable = [NSMutableArray array];
    for (NSDictionary *site in sitesDictionaries) {
        RFSite *newSite = [[RFSite alloc] init];
        newSite.name = [NSString stringWithFormat:@"%@", site[@"Name"]];
        NSNumber *numberIdentificator = [site objectForKey:@"ID"];
        newSite.identificator = [numberIdentificator integerValue];
        [sitesMutable addObject:newSite];
    }

    self.sites = sitesMutable;
    [self.delegate sitesDidUpdate];
}

-(void)personsDidRecieveWithObject:(id)object
{
    NSArray *personsDictionaries = object;
    NSMutableArray *personsMutable = [NSMutableArray array];
    for (NSDictionary *person in personsDictionaries) {
        RFSite *newPerson = [[RFSite alloc] init];
        newPerson.name = [NSString stringWithFormat:@"%@", person[@"Name"]];
        NSNumber *numberIdentificator = [person objectForKey:@"ID"];
        newPerson.identificator = [numberIdentificator integerValue];
        [personsMutable addObject:newPerson];
    }
    
    self.persons = personsMutable;
    [self.delegate personsDidUpdate];
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
    [[RFDatabaseConnection defaultDatabaseConnection] getPersonsWithRatesOnSite:self.currentSite.identificator];
}

-(void)updateRatesOfCurrentPersonOnCurrentSite
{
    [[RFDatabaseConnection defaultDatabaseConnection] getRatesOfPerson:self.currentPerson.identificator onSite:self.currentSite.identificator from:self.startDateForRates to:self.finishDateForRates];
}

+(RFRepository *)sharedRepository {
    
    
    if (!singleRepository) {
        singleRepository = [[RFRepository alloc] init];
        
        [RFDatabaseConnection defaultDatabaseConnection].delegate = singleRepository;
        [[RFDatabaseConnection defaultDatabaseConnection] getSites];
        [[RFDatabaseConnection defaultDatabaseConnection] getPersons];
    }
    
    return singleRepository;
}


@end
