//
//  RFRepository.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 21/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "RFPersonWithRate.h"
#include "RFSite.h"

@interface RFRepository : NSObject
@property NSArray *persons;
@property NSArray *sites;


+(RFRepository *)sharedRepository;

- (NSArray *)getRatesOnSite: (RFSite *)site;
//- (NSArray *)getRatesForPerson: (int)personID;

@end
