//
//  RFRepository.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 21/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFRepository.h"
#import "RFDatabaseConnection.h"

static RFRepository *singleRepository = nil;

@interface RFRepository()

@property NSArray *persons;
@property NSArray *sites;
@property NSArray *personsWithRatesOnCurrentSite;
@property NSArray *ratesOfCurrentPersonWithDatesOnCurrentSite;
@end

@implementation RFRepository

-(NSArray *)personsWithRatesOnCurrentSite
{
    NSMutableArray *ratesOnCurrentSite = [NSMutableArray array];
    
    for (RFPerson *person in self.persons) {
        RFPersonWithRate *personWithRate = [[RFPersonWithRate alloc] init];
        personWithRate.person = person;
        personWithRate.rate = arc4random_uniform(100500);
        [ratesOnCurrentSite addObject:personWithRate];
    }
    
    return ratesOnCurrentSite;
}

-(NSArray *)ratesOfCurrentPersonWithDatesOnCurrentSite
{
    
    NSMutableArray *ratesOfCurrentPersonOnCurrentSite = [NSMutableArray array];
    NSDate *iDate = self.startDateForRates;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    while ([calendar compareDate:iDate toDate:self.finishDateForRates toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
        RFRateWithDate *rateWithDate = [[RFRateWithDate alloc] init];
        rateWithDate.date = iDate;
        rateWithDate.rate = arc4random_uniform(100);
        [ratesOfCurrentPersonOnCurrentSite addObject:rateWithDate];
        iDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:iDate options:0];
    }
    return ratesOfCurrentPersonOnCurrentSite;
}


+(RFRepository *)sharedRepository {
    
    
    if (!singleRepository) {
        singleRepository = [[RFRepository alloc] init];
        
        // Плохой код, повторения, надо избавиться!
        
        NSArray *personDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getPersons];
        NSMutableArray *personsMutable = [NSMutableArray array];
        for (NSDictionary *person in personDictionaries) {
            RFPerson *newPerson = [[RFPerson alloc] init];
            newPerson.name = [NSString stringWithFormat:@"%@", person[@"name"]];
            NSNumber *numberIdentificator = [person objectForKey:@"id"];
            newPerson.identificator = [numberIdentificator integerValue];
            [personsMutable addObject:newPerson];
        }
        singleRepository.persons = personsMutable;
        
        
        NSArray *sitesDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getSites];
        NSMutableArray *sitesMutable = [NSMutableArray array];
        for (NSDictionary *site in sitesDictionaries) {
            RFSite *newSite = [[RFSite alloc] init];
            newSite.name = [NSString stringWithFormat:@"%@", site[@"name"]];
            NSNumber *numberIdentificator = site[@"id"];
            newSite.identificator = [numberIdentificator integerValue];
            [sitesMutable addObject:newSite];
        }
        singleRepository.sites = sitesMutable;
    }
    
    return singleRepository;
}


@end
