//
//  RFRepository.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 21/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFRepository.h"

@implementation RFRepository

-(id)init
{
    self = [super init];
    
    RFPerson *person1 = [[RFPerson alloc] init];
    person1.personID = 1;
    person1.personName = @"Путин Владимир Владимирович";
    
    RFPerson *person2 = [[RFPerson alloc] init];
    person2.personID = 2;
    person2.personName = @"Медведев Дмитрий Анатольевич";
    
    RFPerson *person3 = [[RFPerson alloc] init];
    person3.personID = 3;
    person3.personName = @"Навальный Алексей Анатольевич";
    
    RFPerson *person4 = [[RFPerson alloc] init];
    person4.personID = 4;
    person4.personName = @"Жириновский Владимир Вольфович";
    
    self.persons = [NSArray arrayWithObjects: person1, person2, person3, person4, nil];
    
    RFSite *site1 = [[RFSite alloc] init];
    site1.siteID = 1;
    site1.siteName = @"lenta.ru";
    
    RFSite *site2 = [[RFSite alloc] init];
    site2.siteID = 2;
    site2.siteName = @"gazeta.ru";
    
    RFSite *site3 = [[RFSite alloc] init];
    site3.siteID = 3;
    site3.siteName = @"vesti.ru";
    
    RFSite *site4 = [[RFSite alloc] init];
    site4.siteID = 4;
    site4.siteName = @"ria.ru";
    
    self.sites = [NSArray arrayWithObjects: site1, site2, site3, site4, nil];
    
    return self;
}

@end
