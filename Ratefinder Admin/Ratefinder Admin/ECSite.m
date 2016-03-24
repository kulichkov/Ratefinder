//
//  ECSite.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECSite.h"

@implementation ECSite

static NSString* names[] = {
    @"Lenta.ru", @"Взгляд", @"Аргументы и факты"
};

static NSString* url[] = {
    @"http://www.lenta.ru", @"http://www.vz.ru", @"http://www.aif.ru"
};

static int siteCount = 3;
static int ids = 100;

+(instancetype)randomSite {
    
    ECSite *site = [[ECSite alloc] init];
    
    site.siteID = arc4random() % ids;
    site.name = names[arc4random() % siteCount];
    site.url = url[arc4random() % siteCount];
    
    return site;    
}

@end
