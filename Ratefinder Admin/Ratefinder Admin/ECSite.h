//
//  ECSite.h
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECSite : NSObject

@property (assign, nonatomic) NSInteger siteID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;

+(instancetype)randomSite;

@end
