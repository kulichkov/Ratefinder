//
//  RFDatabaseConnection.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 28/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFDatabaseConnection.h"

// URLs to webservice/php
#define SITES_URL @"http://kulichkov.netne.net/sites.php"
#define PERSONS_URL @"http://kulichkov.netne.net/persons.php"
#define PERSONSWRATES_URL @"http://kulichkov.netne.net/rates.php?siteID=%d"
#define RATESOFPERSON_URL @"http://kulichkov.netne.net/rateswithdates.php?siteID=%d&personID=%d&startDate=%@&finishDate=%@"
#define DATE_FORMAT @"yyyy-MM-dd"

static RFDatabaseConnection *singleDatabaseConnection;


@implementation RFDatabaseConnection
{
    NSArray *parsedJSONArray;
}

+(RFDatabaseConnection *) defaultDatabaseConnection
{
    if (!singleDatabaseConnection) {
        singleDatabaseConnection = [[RFDatabaseConnection alloc] init];
        singleDatabaseConnection->parsedJSONArray = nil;
    }
    
    return singleDatabaseConnection;
}


- (void) parseJSONData: (NSData *)data andSelector:(SEL)theSelector
{
 
    // remove webanalyze-trash
    NSString *stringJSON = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+<!--.*$"
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:stringJSON
                                                     options:0
                                                       range:NSMakeRange(0, stringJSON.length)];
    
    // main parsing algorythm
    if(result) {
        NSRange range = [result rangeAtIndex:0];
        stringJSON = [stringJSON stringByReplacingCharactersInRange:range withString:@""];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *jsonData = [stringJSON dataUsingEncoding:NSUTF8StringEncoding];
        parsedJSONArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        if (theSelector == @selector(getSites)) {
            [self.delegate itemsDidRecieveWithObject:parsedJSONArray ofType:RFSiteItem];
        } else if (theSelector == @selector(getPersons)) {
            [self.delegate itemsDidRecieveWithObject:parsedJSONArray ofType:RFPersonItem];
        } else if (theSelector == @selector(getPersonsWithRatesOnSite:)) {
            [self.delegate personsWithRatesDidRecieveWithObject:parsedJSONArray];
        } else if (theSelector == @selector(getRatesOfPerson:onSite:from:to:)) {
            [self.delegate ratesWithDatesDidRecieveWithObject:parsedJSONArray];
        }
    });
    
}

-(void)getDataFromURL: (NSURL *)theURL andSelector:(SEL)theSelector
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:theURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self parseJSONData:data andSelector:theSelector];
    }];
    [dataTask resume];
}

-(void)getSites
{
    NSURL *sitesURL = [NSURL URLWithString: SITES_URL];
    [self getDataFromURL:sitesURL andSelector:@selector(getSites)];
}

-(void)getPersons
{
    NSURL *personsURL = [NSURL URLWithString: PERSONS_URL];
    [self getDataFromURL:personsURL andSelector:@selector(getPersons)];
}

-(void)getPersonsWithRatesOnSite: (int)siteID
{
    NSString *stringURL = [NSString stringWithFormat: PERSONSWRATES_URL, siteID];
    NSURL *PersonsWithRatesOnSiteURL = [NSURL URLWithString: stringURL];
    [self getDataFromURL:PersonsWithRatesOnSiteURL andSelector:@selector(getPersonsWithRatesOnSite:)] ;
}

-(void)getRatesOfPerson:(int)personID onSite:(int)siteID from:(NSDate *)startDate to:(NSDate *)finishDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMAT;
    NSString *stringStartDate = [dateFormatter stringFromDate:startDate];
    NSString *stringFinishDate = [dateFormatter stringFromDate:finishDate];
    NSString *stringURL = [NSString stringWithFormat: RATESOFPERSON_URL, siteID, personID, stringStartDate, stringFinishDate];
    NSURL *PersonsWithRatesOnSiteURL = [NSURL URLWithString: stringURL];
    [self getDataFromURL:PersonsWithRatesOnSiteURL andSelector:@selector(getRatesOfPerson:onSite:from:to:)];
}

@end
