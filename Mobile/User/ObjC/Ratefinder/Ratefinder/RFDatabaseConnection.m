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

-(NSArray *) getPersons
{
    return nil;
}

- (void) parseJSONData: (NSData *)data {
    
    NSString *stringJSON = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+<!--.*$"
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:stringJSON
                                                     options:0
                                                       range:NSMakeRange(0, stringJSON.length)];
    if(result) {
        NSRange range = [result rangeAtIndex:0];
        stringJSON = [stringJSON stringByReplacingCharactersInRange:range withString:@""];
        NSLog(@"json: %@", stringJSON);
    }

    NSData *jsonData = [stringJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    parsedJSONArray = parsedObject;
    
}

-(void)getAndParseDataFromNSURL: (NSURL *)theNSURL {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:theNSURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self parseJSONData:data];
        dispatch_semaphore_signal(sem);
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}


-(NSArray *) getSites
{
    NSURL *sitesURL = [NSURL URLWithString: @"http://kulichkov.netne.net/sites.php"];
    [self getAndParseDataFromNSURL:sitesURL];
    return parsedJSONArray;
}

-(NSArray *) getPersonsWithRatesOnSite:(int)siteID
{
    return nil;
}

-(NSArray *)getRatesOfPerson:(int)personID onSite:(int)siteID from:(NSDate *)startDate to:(NSDate *)finishDate
{
    return nil;
}


-(NSArray *) getDataFromURL: (NSURL *) theURL
{
    return nil;
}

@end
