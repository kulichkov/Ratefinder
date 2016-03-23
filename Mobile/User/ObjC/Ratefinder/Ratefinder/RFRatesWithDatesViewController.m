//
//  RFRatesWithDatesViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 23/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFRatesWithDatesViewController.h"
#import "RFRepository.h"

@implementation RFRatesWithDatesViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    RFRepository *repository = [RFRepository sharedRepository];
    NSLog(@"%@",repository.ratesOfCurrentPersonWithDatesOnCurrentSite);
}
@end
