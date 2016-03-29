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
        
        
        RFSite *site1 = [[RFSite alloc] init];
        site1.identificator = 1;
        site1.name = @"lenta.ru";
        
        RFSite *site2 = [[RFSite alloc] init];
        site2.identificator = 2;
        site2.name = @"gazeta.ru";
        
        RFSite *site3 = [[RFSite alloc] init];
        site3.identificator = 3;
        site3.name = @"vesti.ru";
        
        RFSite *site4 = [[RFSite alloc] init];
        site4.identificator = 4;
        site4.name = @"ria.ru";
        
        singleRepository.sites = [NSArray arrayWithObjects: site1, site2, site3, site4, nil];
    }
    
    return singleRepository;
}


@end
