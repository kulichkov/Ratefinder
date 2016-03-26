//
//  ECFakeRepository.h
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECSite;
@class ECPerson;
@class ECKeywords;

@interface ECFakeRepository : NSObject

+(ECSite *)getRandomSite;
+(ECPerson *)getRandomPerson;
+(ECKeywords *)getRandomKeyword;

@end
