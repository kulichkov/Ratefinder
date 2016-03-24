//
//  ECKeywords.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECKeywords.h"

@implementation ECKeywords

static NSString* keywords[] = {
    @"Владимир Владимирович", @"Путину", @"Путина"
};

static int keywordsCount = 3;
static int ids = 100;

+(instancetype)randomKeyword {
    
    ECKeywords *keyword = [[ECKeywords alloc] init];
    
    keyword.keywordsID = arc4random() % ids;
    keyword.name = keywords[arc4random() % keywordsCount];
    
    return keyword;
}

@end
