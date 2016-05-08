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
    [self.delegate RatesWithDatesDidUpdate];
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


/*
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
*/

+(RFRepository *)sharedRepository {
    
    
    if (!singleRepository) {
        singleRepository = [[RFRepository alloc] init];
        
        // Плохой код, повторения, надо избавиться!
        
//        NSArray *personDictionaries = [[RFDatabaseConnection defaultDatabaseConnection] getPersons];
//        NSMutableArray *personsMutable = [NSMutableArray array];
//        for (NSDictionary *person in personDictionaries) {
//            RFPerson *newPerson = [[RFPerson alloc] init];
//            newPerson.name = [NSString stringWithFormat:@"%@", person[@"Name"]];
//            NSNumber *numberIdentificator = [person objectForKey:@"ID"];
//            newPerson.identificator = [numberIdentificator integerValue];
//            [personsMutable addObject:newPerson];
//        }
//        singleRepository.persons = personsMutable;
//
        
        [RFDatabaseConnection defaultDatabaseConnection].delegate = singleRepository;
        [[RFDatabaseConnection defaultDatabaseConnection] getSites];
        [[RFDatabaseConnection defaultDatabaseConnection] getPersons];
       // NSLog(@"persons = %@", singleRepository.persons);
    }
    
    return singleRepository;
}


@end
