//
//  RFDatabaseConnection.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 28/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFDatabaseConnection.h"

static RFDatabaseConnection *singleDatabaseConnection;

@implementation RFDatabaseConnection

+(RFDatabaseConnection *) defaultDatabaseConnection
{
    if (!singleDatabaseConnection) {
        singleDatabaseConnection = [[RFDatabaseConnection alloc] init];
    }
    return singleDatabaseConnection;
}

-(NSArray *) getPersons
{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Persons" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:nil];
    return jsonArray;
}

-(NSArray *) getSites
{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Sites" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:nil];
    return jsonArray;
}

-(NSArray *) getPersonsWithRatesOnSite:(int)siteID
{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"PersonsWithRatesOnCurrentSite" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:nil];
    return jsonArray;
}

-(NSArray *)getRatesOfPerson:(int)personID onSite:(int)siteID from:(NSDate *)startDate to:(NSDate *)finishDate
{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"RatesOfCurrentPersonWithDatesOnCurrentSite" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:jsonFilePath];
    NSError *jsonError;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&jsonError];
    return jsonArray;
}


-(NSArray *) getDataFromURL: (NSURL *) theURL
{
    return nil;
}

@end
