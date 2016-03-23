//
//  RFDateViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 23/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFDateViewController.h"
#import "RFRepository.h"

@implementation RFDateViewController
{
    NSDate *startDate;
    NSDate *finishDate;
    RFRepository *repository;
}

- (void)viewDidLoad
{
    repository = [RFRepository sharedRepository];
    self.navigationItem.title = repository.currentPerson.name;
}

@end
