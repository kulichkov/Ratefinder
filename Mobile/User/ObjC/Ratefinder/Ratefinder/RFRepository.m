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
    
    NSArray *ratesOnCurrentSiteDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getPersonsWithRatesOnSite: self.currentSite.identificator];
    
    for (NSDictionary *ratesOnSite in ratesOnCurrentSiteDictionaries) {
        RFPersonWithRate *personWithRate = [[RFPersonWithRate alloc] init];
        for (RFPerson *person in self.persons) {
            NSNumber *numberIdentificator = ratesOnSite[@"personsID"];
            if (person.identificator == [numberIdentificator integerValue]) {
                personWithRate.person = person;
                NSNumber *numberRate = ratesOnSite[@"rank"];
                personWithRate.rate = [numberRate integerValue];
                [ratesOnCurrentSite addObject:personWithRate];
                break;
            }
        }
    }
    return ratesOnCurrentSite;
}

-(NSArray *)ratesOfCurrentPersonWithDatesOnCurrentSite
{
    
//    NSDate *iDate = self.startDateForRates;
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    while ([calendar compareDate:iDate toDate:self.finishDateForRates toUnitGranularity:NSCalendarUnitDay] == NSOrderedAscending) {
//        RFRateWithDate *rateWithDate = [[RFRateWithDate alloc] init];
//        rateWithDate.date = iDate;
//        rateWithDate.rate = arc4random_uniform(100);
//        [ratesOfCurrentPersonOnCurrentSite addObject:rateWithDate];
//        iDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:iDate options:0];
//    }
    
    NSArray *ratesOfCurrentPersonOnCurrentSite = [[RFDatabaseConnection defaultDatabaseConnection] getRatesOfPerson:self.currentPerson.identificator onSite:self.currentSite.identificator from:self.startDateForRates to:self.finishDateForRates];
    NSMutableArray *personsRateMutable = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    for (NSDictionary *personRates in ratesOfCurrentPersonOnCurrentSite) {
        RFRateWithDate *theRateWithDate = [[RFRateWithDate alloc] init];
        theRateWithDate.date = [dateFormatter dateFromString: personRates[@"date"]];
        NSNumber *numberRate = personRates[@"rank"];
        theRateWithDate.rate = [numberRate integerValue];
        [personsRateMutable addObject:theRateWithDate];
    }
    
    return personsRateMutable;
}


+(RFRepository *)sharedRepository {
    
    
    if (!singleRepository) {
        singleRepository = [[RFRepository alloc] init];
        
        // Плохой код, повторения, надо избавиться!
        
        NSArray *personDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getPersons];
        NSMutableArray *personsMutable = [NSMutableArray array];
        for (NSDictionary *person in personDictionaries) {
            RFPerson *newPerson = [[RFPerson alloc] init];
            newPerson.name = [NSString stringWithFormat:@"%@", person[@"Name"]];
            NSNumber *numberIdentificator = [person objectForKey:@"ID"];
            newPerson.identificator = [numberIdentificator integerValue];
            [personsMutable addObject:newPerson];
        }
        singleRepository.persons = personsMutable;
        
        
        NSArray *sitesDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getSites];
        NSMutableArray *sitesMutable = [NSMutableArray array];
        for (NSDictionary *site in sitesDictionaries) {
            RFSite *newSite = [[RFSite alloc] init];
            newSite.name = [NSString stringWithFormat:@"%@", site[@"Name"]];
            NSNumber *numberIdentificator = site[@"ID"];
            newSite.identificator = [numberIdentificator integerValue];
            [sitesMutable addObject:newSite];
        }
        singleRepository.sites = sitesMutable;
    }
    
    return singleRepository;
}


@end
