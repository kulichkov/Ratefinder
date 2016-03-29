//
//  ECFakeRepository.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECFakeRepository.h"
#import "ECSite.h"
#import "ECPerson.h"
#import "ECKeywords.h"

@implementation ECFakeRepository

static NSString* nameSites[] = {
    @"Lenta.ru", @"Взгляд", @"Аргументы и факты"
};

static NSString* url[] = {
    @"http://www.lenta.ru", @"http://www.vz.ru", @"http://www.aif.ru"
};

static NSString* namePersons[] = {
    @"Путин", @"Навальный", @"Тиньков"
};


static NSString* keywords[] = {
    @"Владимир Владимирович", @"Путину", @"Путина"
};

static int keywordsCount = 3;
static int ids = 100;
static int personCount = 3;
static int siteCount = 3;

+(ECSite *)getRandomSite {
    
    ECSite *site = [[ECSite alloc] init];
    
    site.siteID = arc4random() % ids;
    site.name = nameSites[arc4random() % siteCount];
    site.url = url[arc4random() % siteCount];
    
    return site;
}

+(ECPerson *)getRandomPerson {
    
    ECPerson *person = [[ECPerson alloc] init];
    
    person.personID = arc4random() % ids;
    person.name = namePersons[arc4random() % personCount];
    
    return person;
}

+(ECKeywords *)getRandomKeyword {
    
    ECKeywords *keyword = [[ECKeywords alloc] init];
    
    keyword.keywordsID = arc4random() % ids;
    keyword.name = keywords[arc4random() % keywordsCount];
    
    return keyword;
}

@end
