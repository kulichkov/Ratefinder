//
//  ECPerson.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECPerson.h"

@implementation ECPerson

static NSString* names[] = {
    @"Путин", @"Навальный", @"Тиньков"
};

static int personCount = 3;
static int ids = 100;

+(instancetype)randomPerson {
    
    ECPerson *person = [[ECPerson alloc] init];
    
    person.personID = arc4random() % ids;
    person.name = names[arc4random() % personCount];
    
    return person;
}

@end
